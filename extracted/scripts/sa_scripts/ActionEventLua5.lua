-- 로데오 공중보급(드론AI관련 스크립트)
-- 게임시작시 최초 호스트가 한번 호출되도록 정의된 함수입니다.
function Init()

end

-- 월드에 진입하거나 방장위임시 호출되는 함수입니다.
function Setup()
             AERegFunction(1, "UpdateDrone")
			 totaltime = 0
             One = 0
             Loop = 1
             Time = 2
			 DroneStart = "DronePoint00"
			 --Line1
             AECreateMatinee("ActionEventMatinee00", "ActionEventPoint00", 0.7, Time, "zipline_start","ActionEventMatinee01",-95)
             AECreateMatinee("ActionEventMatinee01", "ActionEventPoint01", 1.0, Loop, "zipline_idle_3","ActionEventMatinee02",-95)
             AECreateMatinee("ActionEventMatinee02", "ActionEventPoint02", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line1Back
             AECreateMatinee("ActionEventMatinee03", "ActionEventPoint03", 0.7, Time, "zipline_start","ActionEventMatinee04",-95)
             AECreateMatinee("ActionEventMatinee04", "ActionEventPoint04", 1.0, Loop, "zipline_idle_3","ActionEventMatinee05",-95)
             AECreateMatinee("ActionEventMatinee05", "ActionEventPoint05", 0.6, Time, "zipline_arrive"," ",-95 )
             --Line2
             AECreateMatinee("ActionEventMatinee06", "ActionEventPoint06", 0.7, Time, "zipline_start","ActionEventMatinee07",-95)
             AECreateMatinee("ActionEventMatinee07", "ActionEventPoint07", 3.0, Loop, "zipline_idle_3","ActionEventMatinee08",-95)
             AECreateMatinee("ActionEventMatinee08", "ActionEventPoint08", 0.6, Time, "zipline_arrive"," ",-95 )
             --Line2Back
             AECreateMatinee("ActionEventMatinee09", "ActionEventPoint09", 0.7, Time, "zipline_start","ActionEventMatinee10",-95)
             AECreateMatinee("ActionEventMatinee10", "ActionEventPoint10", 3.0, Loop, "zipline_idle_3","ActionEventMatinee11",-95)
             AECreateMatinee("ActionEventMatinee11", "ActionEventPoint11", 0.6, Time, "zipline_arrive"," ",-95 )
			  --Line3
             AECreateMatinee("ActionEventMatinee12", "ActionEventPoint12", 0.7, Time, "zipline_start","ActionEventMatinee13",-95)
             AECreateMatinee("ActionEventMatinee13", "ActionEventPoint13", 3.5, Loop, "zipline_idle_3","ActionEventMatinee14",-95)
             AECreateMatinee("ActionEventMatinee14", "ActionEventPoint14", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line3Back
             AECreateMatinee("ActionEventMatinee15", "ActionEventPoint15", 0.7, Time, "zipline_start","ActionEventMatinee16",-95)
             AECreateMatinee("ActionEventMatinee16", "ActionEventPoint16", 3.5, Loop, "zipline_idle_3","ActionEventMatinee17",-95)
             AECreateMatinee("ActionEventMatinee17", "ActionEventPoint17", 0.6, Time, "zipline_arrive"," ",-95 )
end

function UpdateDrone( ObjHandle )
    -- 유저가 정의한 업데이트 함수. 이름은 알아서…
    name, dist = AEGetClearPoint(ObjHandle)
    -- name이 nil 이다가 목적지에 도착하면 그 포인트 이름과 목적지와의 정확한 거리를 반환

    if name == "DronePoint00" then
        AERunToPoint(ObjHandle, "DronePoint01")

    elseif name == "DronePoint01" then
        AERunToPoint(ObjHandle, "DronePoint02")

    elseif name == "DronePoint02" then
        AERunToPoint(ObjHandle, "DronePoint03")

    elseif name == "DronePoint03" then
        AERunToPoint(ObjHandle, "DronePoint04")

    elseif name == "DronePoint04" then
        AERunToPoint(ObjHandle, "DronePoint05")

    elseif name == "DronePoint05" then
        AERunToPoint(ObjHandle, "DronePoint00")
    end

    return 1
end



function OnEvent(eventKey, eventData, x, y, z)
    -- 정의된 이벤트 함수. 클라이언트가 상황에 따라 호출한다.
    if eventKey == 0 then
        -- 키타입이 0이면 드론 생성
        DronePointVal = math.random(0,5)

        if DronePointVal == 0 then
            DroneStart = "DronePoint00"
        elseif DronePointVal == 1 then
            DroneStart = "DronePoint01"
        elseif DronePointVal == 2 then
            DroneStart = "DronePoint02"
        elseif DronePointVal == 3 then
            DroneStart = "DronePoint03"
        elseif DronePointVal == 4 then
            DroneStart = "DronePoint04"
        elseif DronePointVal == 5 then
            DroneStart = "DronePoint05"
        end

        ObjHandle = AECreateBot(nil, 1217, DroneStart, 1000)
        -- 드론봇 인덱스를 호출. index(nil:랜덤), BotID, 생성위치("PointName" or x,y,z)

        AEUpdateTimer(ObjHandle, 1, 1.0)
        -- 유저가 앞서 정의한 업데이트 함수 연결 ( , 함수ID, 호출주기 )

        AEMoveOption(ObjHandle, 50, 2, 1.0, 600.0, 15)
        -- 타겟범위(0.1~99999)
        -- 이동옵션(0:그냥이동, 1:회전방향으로 이동, 2:회전후 이동)
        -- 회전속도(0.1~100)
        -- 이동속도(0.1~99999)
        -- 미끄러짐(0.1~100)

    elseif eventKey == 1 then
        -- 키타입이 1이면 아이템 박스 생성
        ObjHandle = AECreateBot(nil, 1218, x, y, z)
        -- 아이템박스봇 인덱스를 호출

        AESetData(ObjHandle, eventKey, eventData)
        -- 봇을 실제 박스 정보 인덱스와 연결하는 부분
    end
end


 







------------------------------------------------------------