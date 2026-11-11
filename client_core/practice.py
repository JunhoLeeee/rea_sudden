"""Authored offline practice rules; only HitMarker is based on recovered code.

Units are metres; z is up and yaw zero faces +x. Physics, arena and weapons
are prototype choices, not claims about original game behavior.
"""
from dataclasses import dataclass
import json
import math
from pathlib import Path
from .hitmarker import HitMarker, select_settings

ROOT = Path(__file__).resolve().parents[1]
CELL = 2.0
ARENA = (
    '################',
    '#..............#',
    '#..............#',
    '#....##...##...#',
    '#....##...##...#',
    '#..............#',
    '#..............#',
    '#..##.....##...#',
    '#..##.....##...#',
    '#..............#',
    '#..............#',
    '################',
)
SPAWN = (5.0, 11.0)
TARGETS = ((11, 11), (17, 11), (25, 11), (27, 5), (17, 3), (7, 19))
WEAPONS = {
    'rifle': dict(name='TRAINING RIFLE', capacity=30, reserve=90, damage=34,
                  interval=.105, reload=1.8, recoil=.009),
    'pistol': dict(name='TRAINING PISTOL', capacity=7, reserve=35, damage=55,
                   interval=.3, reload=1.25, recoil=.018),
}


def ray_box(origin, direction, low, high):
    """Nearest nonnegative ray/AABB distance; parallel and inside rays supported."""
    near, far = 0.0, math.inf
    for start, delta, minimum, maximum in zip(origin, direction, low, high):
        if abs(delta) < 1e-12:
            if not minimum <= start <= maximum:
                return None
            continue
        a, b = (minimum-start)/delta, (maximum-start)/delta
        near, far = max(near, min(a, b)), min(far, max(a, b))
        if near > far:
            return None
    return near


@dataclass
class Target:
    id: int
    x: float
    y: float
    health: int = 100
    respawn: float = 0


class Practice:
    def __init__(self):
        self.settings_document = json.loads(
            (ROOT / 'extracted/scripts/sa_scripts/GameplaySettings.txt').read_text(encoding='utf-8-sig'))
        self.style = 0
        self.reset()
        self.state = 'menu'

    def reset(self):
        self.x, self.y = SPAWN
        self.z = self.vz = self.yaw = self.pitch = 0.0
        self.crouched = False
        self.clock = self.shots = self.hits = self.kills = self.headshots = 0
        self.remaining = 90.0
        self.cooldown = self.reload_left = 0.0
        self.weapon = 'rifle'
        self.ammo = {key: [row['capacity'], row['reserve']] for key, row in WEAPONS.items()}
        self.targets = [Target(i, *point) for i, point in enumerate(TARGETS)]
        self.marker = HitMarker(select_settings(self.settings_document, self.style))
        self.marker_frame = None
        self.last_event = 'READY'
        self.shot_id = 0
        self.previous_jump = False
        self.state = 'playing'

    @property
    def eye(self):
        return self.z + (1.0 if self.crouched else 1.55)

    def action(self, name):
        if name in ('start', 'restart'):
            self.reset()
        elif name == 'pause' and self.state == 'playing':
            self.state = 'paused'
        elif name == 'resume' and self.state == 'paused':
            self.state = 'playing'
        elif name == 'menu':
            self.state = 'menu'
        elif name == 'reload' and self.state == 'playing':
            rounds, reserve = self.ammo[self.weapon]
            if not self.reload_left and rounds < WEAPONS[self.weapon]['capacity'] and reserve:
                self.reload_left = WEAPONS[self.weapon]['reload']
                self.last_event = 'RELOADING'
        elif name in WEAPONS and self.state == 'playing':
            self.weapon = name
            self.reload_left = 0.0
            self.cooldown = max(self.cooldown, .2)

    def set_style(self, style):
        self.style = int(style) & 255
        self.marker = HitMarker(select_settings(self.settings_document, self.style))
        self.marker_frame = None

    def open_position(self, x, y):
        radius = .24
        for row in range(math.floor((y-radius)/CELL), math.floor((y+radius)/CELL)+1):
            for col in range(math.floor((x-radius)/CELL), math.floor((x+radius)/CELL)+1):
                if row < 0 or row >= len(ARENA) or col < 0 or col >= len(ARENA[0]):
                    return False
                if ARENA[row][col] == '#':
                    nx = max(col*CELL, min(x, (col+1)*CELL))
                    ny = max(row*CELL, min(y, (row+1)*CELL))
                    if (nx-x)**2 + (ny-y)**2 < radius**2:
                        return False
        return True

    def wall_distance(self, origin, direction):
        nearest = 100.0
        for row, line in enumerate(ARENA):
            for col, tile in enumerate(line):
                if tile == '#':
                    distance = ray_box(origin, direction, (col*CELL, row*CELL, 0),
                                       ((col+1)*CELL, (row+1)*CELL, 3))
                    if distance is not None:
                        nearest = min(nearest, distance)
        return nearest

    def fire(self):
        if self.state != 'playing' or self.cooldown > 1e-9 or self.reload_left:
            return
        weapon = WEAPONS[self.weapon]
        if self.ammo[self.weapon][0] == 0:
            self.action('reload')
            return
        self.ammo[self.weapon][0] -= 1
        self.cooldown = weapon['interval']
        self.shots += 1
        self.shot_id += 1
        origin = (self.x, self.y, self.eye)
        direction = (math.cos(self.yaw)*math.cos(self.pitch),
                     math.sin(self.yaw)*math.cos(self.pitch), math.sin(self.pitch))
        nearest = self.wall_distance(origin, direction)
        hit = None
        for target in self.targets:
            if target.health <= 0:
                continue
            distance = ray_box(origin, direction, (target.x-.32, target.y-.32, 0),
                               (target.x+.32, target.y+.32, 1.85))
            if distance is not None and distance < nearest:
                nearest, hit = distance, target
        self.last_event = 'MISS'
        if hit:
            head = origin[2] + direction[2]*nearest >= 1.4
            hit.health = max(0, hit.health - weapon['damage']*(3 if head else 1))
            self.hits += 1
            self.headshots += int(head)
            event = 'head' if head else 'normal'
            if hit.health == 0:
                self.kills += 1
                hit.respawn = 2.0
                event = 'kill'
            self.marker.trigger(event)
            self.last_event = 'HEADSHOT KILL' if event == 'kill' and head else event.upper()
        self.pitch = min(.85, self.pitch + weapon['recoil'])
        if self.kills >= 10:
            self.state = 'finished'
            self.last_event = 'DRILL COMPLETE'

    def step(self, dt, controls=None):
        if not math.isfinite(dt) or dt < 0:
            raise ValueError('finite nonnegative delta required')
        controls = controls or {}
        if self.state != 'playing':
            return
        self.yaw = (self.yaw + controls.get('look_x', 0)) % math.tau
        self.pitch = max(-.85, min(.85, self.pitch + controls.get('look_y', 0)))
        jump = bool(controls.get('jump'))
        self.crouched = bool(controls.get('crouch')) and self.z == 0
        if jump and not self.previous_jump and self.z == 0 and not self.crouched:
            self.vz = 5.0
        self.previous_jump = jump
        remaining = min(dt, .1)
        while remaining > 1e-9 and self.state == 'playing':
            delta = min(remaining, 1/120)
            remaining -= delta
            self._integrate(delta, controls)
        self.marker_frame = self.marker.advance(min(dt, .1), center=(0, 0))

    def _integrate(self, dt, controls):
        self.clock += dt
        self.remaining = max(0.0, self.remaining-dt)
        if self.remaining == 0:
            self.state = 'finished'
            self.last_event = 'TIME UP'
            return
        self.cooldown = max(0.0, self.cooldown-dt)
        if self.reload_left:
            self.reload_left = max(0.0, self.reload_left-dt)
            if self.reload_left < 1e-9:
                self.reload_left = 0.0
                rounds, reserve = self.ammo[self.weapon]
                amount = min(WEAPONS[self.weapon]['capacity']-rounds, reserve)
                self.ammo[self.weapon] = [rounds+amount, reserve-amount]
                self.last_event = 'READY'
        for target in self.targets:
            if target.health <= 0:
                target.respawn = max(0.0, target.respawn-dt)
                if target.respawn < 1e-9:
                    target.health = 100
        forward = float(bool(controls.get('forward'))) - float(bool(controls.get('back')))
        strafe = float(bool(controls.get('right'))) - float(bool(controls.get('left')))
        norm = max(1.0, math.hypot(forward, strafe))
        speed = 1.4 if self.crouched else (2.0 if controls.get('walk') else 3.3)
        yaw = self.yaw
        dx = (math.cos(yaw)*forward-math.sin(yaw)*strafe)*speed*dt/norm
        dy = (math.sin(yaw)*forward+math.cos(yaw)*strafe)*speed*dt/norm
        if self.open_position(self.x+dx, self.y):
            self.x += dx
        if self.open_position(self.x, self.y+dy):
            self.y += dy
        if self.z > 0 or self.vz > 0:
            self.vz -= 12.0*dt
            self.z = max(0.0, self.z+self.vz*dt)
            if self.z == 0:
                self.vz = 0.0
        self.yaw = (self.yaw + (bool(controls.get('turn_right'))-bool(controls.get('turn_left')))*1.8*dt) % math.tau
        if controls.get('fire'):
            self.fire()

    def snapshot(self):
        rounds, reserve = self.ammo[self.weapon]
        return dict(state=self.state, player=dict(x=self.x, y=self.y, z=self.z, eye=self.eye,
                    yaw=self.yaw, pitch=self.pitch, crouched=self.crouched),
                    weapon=self.weapon, weapon_name=WEAPONS[self.weapon]['name'],
                    ammo=rounds, reserve=reserve, reload_left=self.reload_left,
                    reload_duration=WEAPONS[self.weapon]['reload'],
                    remaining=self.remaining, kills=self.kills, goal=10, shots=self.shots,
                    hits=self.hits, headshots=self.headshots,
                    accuracy=round(100*self.hits/self.shots) if self.shots else 0,
                    targets=[dict(id=t.id, x=t.x, y=t.y, health=t.health) for t in self.targets],
                    marker=self.marker_frame, last_event=self.last_event, shot_id=self.shot_id,
                    style=self.style)
