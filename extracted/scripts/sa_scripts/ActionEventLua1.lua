-- 차이나타운 공중보급(드론AI관련 스크립트)
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
             AECreateMatinee("ActionEventMatinee01", "ActionEventPoint01", 3.0, Loop, "zipline_idle_3","ActionEventMatinee02",-95)
             AECreateMatinee("ActionEventMatinee02", "ActionEventPoint02", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line1Back
             AECreateMatinee("ActionEventMatinee03", "ActionEventPoint03", 0.7, Time, "zipline_start","ActionEventMatinee04",-95)
             AECreateMatinee("ActionEventMatinee04", "ActionEventPoint04", 3.0, Loop, "zipline_idle_3","ActionEventMatinee05",-95)
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
             AECreateMatinee("ActionEventMatinee13", "ActionEventPoint13", 4.0, Loop, "zipline_idle_3","ActionEventMatinee14",-95)
             AECreateMatinee("ActionEventMatinee14", "ActionEventPoint14", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line3Back
             AECreateMatinee("ActionEventMatinee15", "ActionEventPoint15", 0.7, Time, "zipline_start","ActionEventMatinee16",-95)
             AECreateMatinee("ActionEventMatinee16", "ActionEventPoint16", 4.0, Loop, "zipline_idle_3","ActionEventMatinee17",-95)
             AECreateMatinee("ActionEventMatinee17", "ActionEventPoint17", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line4
             AECreateMatinee("ActionEventMatinee18", "ActionEventPoint18", 0.7, Time, "zipline_start","ActionEventMatinee19",-95)
             AECreateMatinee("ActionEventMatinee19", "ActionEventPoint19", 4.0, Loop, "zipline_idle_3","ActionEventMatinee20",-95)
             AECreateMatinee("ActionEventMatinee20", "ActionEventPoint20", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line4Back
             AECreateMatinee("ActionEventMatinee21", "ActionEventPoint21", 0.7, Time, "zipline_start","ActionEventMatinee22",-95)
             AECreateMatinee("ActionEventMatinee22", "ActionEventPoint22", 4.0, Loop, "zipline_idle_3","ActionEventMatinee23",-95)
             AECreateMatinee("ActionEventMatinee23", "ActionEventPoint23", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line5
             AECreateMatinee("ActionEventMatinee24", "ActionEventPoint24", 0.7, Time, "zipline_start","ActionEventMatinee25",-95)
             AECreateMatinee("ActionEventMatinee25", "ActionEventPoint25", 4.0, Loop, "zipline_idle_3","ActionEventMatinee26",-95)
             AECreateMatinee("ActionEventMatinee26", "ActionEventPoint26", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line5Back
             AECreateMatinee("ActionEventMatinee27", "ActionEventPoint27", 0.7, Time, "zipline_start","ActionEventMatinee28",-95)
             AECreateMatinee("ActionEventMatinee28", "ActionEventPoint28", 4.0, Loop, "zipline_idle_3","ActionEventMatinee29",-95)
             AECreateMatinee("ActionEventMatinee29", "ActionEventPoint29", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line6
             AECreateMatinee("ActionEventMatinee30", "ActionEventPoint30", 0.7, Time, "zipline_start","ActionEventMatinee31",-95)
             AECreateMatinee("ActionEventMatinee31", "ActionEventPoint31", 4.0, Loop, "zipline_idle_3","ActionEventMatinee32",-95)
             AECreateMatinee("ActionEventMatinee32", "ActionEventPoint32", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line6Backiiii
             AECreateMatinee("ActionEventMatinee33", "ActionEventPoint33", 0.7, Time, "zipline_start","ActionEventMatinee34",-95)
             AECreateMatinee("ActionEventMatinee34", "ActionEventPoint34", 4.0, Loop, "zipline_idle_3","ActionEventMatinee35",-95)
             AECreateMatinee("ActionEventMatinee35", "ActionEventPoint35", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line7
             AECreateMatinee("ActionEventMatinee36", "ActionEventPoint36", 0.7, Time, "zipline_start","ActionEventMatinee37",-95)
             AECreateMatinee("ActionEventMatinee37", "ActionEventPoint37", 4.5, Loop, "zipline_idle_3","ActionEventMatinee38",-95)
             AECreateMatinee("ActionEventMatinee38", "ActionEventPoint38", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line7Back
             AECreateMatinee("ActionEventMatinee39", "ActionEventPoint39", 0.7, Time, "zipline_start","ActionEventMatinee40",-95)
             AECreateMatinee("ActionEventMatinee40", "ActionEventPoint40", 4.5, Loop, "zipline_idle_3","ActionEventMatinee41",-95)
             AECreateMatinee("ActionEventMatinee41", "ActionEventPoint41", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line8
             AECreateMatinee("ActionEventMatinee42", "ActionEventPoint42", 0.7, Time, "zipline_start","ActionEventMatinee43",-95)
             AECreateMatinee("ActionEventMatinee43", "ActionEventPoint43", 4.5, Loop, "zipline_idle_3","ActionEventMatinee44",-95)
             AECreateMatinee("ActionEventMatinee44", "ActionEventPoint44", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line8Back
             AECreateMatinee("ActionEventMatinee45", "ActionEventPoint45", 0.7, Time, "zipline_start","ActionEventMatinee46",-95)
             AECreateMatinee("ActionEventMatinee46", "ActionEventPoint46", 4.5, Loop, "zipline_idle_3","ActionEventMatinee47",-95)
             AECreateMatinee("ActionEventMatinee47", "ActionEventPoint47", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line9
             AECreateMatinee("ActionEventMatinee48", "ActionEventPoint48", 0.7, Time, "zipline_start","ActionEventMatinee49",-95)
             AECreateMatinee("ActionEventMatinee49", "ActionEventPoint49", 4.0, Loop, "zipline_idle_3","ActionEventMatinee50",-95)
             AECreateMatinee("ActionEventMatinee50", "ActionEventPoint50", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line9Back
             AECreateMatinee("ActionEventMatinee51", "ActionEventPoint51", 0.7, Time, "zipline_start","ActionEventMatinee52",-95)
             AECreateMatinee("ActionEventMatinee52", "ActionEventPoint52", 4.0, Loop, "zipline_idle_3","ActionEventMatinee53",-95)
             AECreateMatinee("ActionEventMatinee53", "ActionEventPoint53", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line10
             AECreateMatinee("ActionEventMatinee54", "ActionEventPoint54", 0.7, Time, "zipline_start","ActionEventMatinee55",-95)
             AECreateMatinee("ActionEventMatinee55", "ActionEventPoint55", 4.0, Loop, "zipline_idle_3","ActionEventMatinee56",-95)
             AECreateMatinee("ActionEventMatinee56", "ActionEventPoint56", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line10Back
             AECreateMatinee("ActionEventMatinee57", "ActionEventPoint57", 0.7, Time, "zipline_start","ActionEventMatinee58",-95)
             AECreateMatinee("ActionEventMatinee58", "ActionEventPoint58", 4.0, Loop, "zipline_idle_3","ActionEventMatinee59",-95)
             AECreateMatinee("ActionEventMatinee59", "ActionEventPoint59", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line11
             AECreateMatinee("ActionEventMatinee60", "ActionEventPoint60", 0.7, Time, "zipline_start","ActionEventMatinee61",-95)
             AECreateMatinee("ActionEventMatinee61", "ActionEventPoint61", 4.0, Loop, "zipline_idle_3","ActionEventMatinee62",-95)
             AECreateMatinee("ActionEventMatinee62", "ActionEventPoint62", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line11Back
             AECreateMatinee("ActionEventMatinee63", "ActionEventPoint63", 0.7, Time, "zipline_start","ActionEventMatinee64",-95)
             AECreateMatinee("ActionEventMatinee64", "ActionEventPoint64", 4.0, Loop, "zipline_idle_3","ActionEventMatinee65",-95)
             AECreateMatinee("ActionEventMatinee65", "ActionEventPoint65", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line12
             AECreateMatinee("ActionEventMatinee66", "ActionEventPoint66", 0.7, Time, "zipline_start","ActionEventMatinee67",-95)
             AECreateMatinee("ActionEventMatinee67", "ActionEventPoint67", 4.0, Loop, "zipline_idle_3","ActionEventMatinee68",-95)
             AECreateMatinee("ActionEventMatinee68", "ActionEventPoint68", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line12Back
             AECreateMatinee("ActionEventMatinee69", "ActionEventPoint69", 0.7, Time, "zipline_start","ActionEventMatinee70",-95)
             AECreateMatinee("ActionEventMatinee70", "ActionEventPoint70", 4.0, Loop, "zipline_idle_3","ActionEventMatinee71",-95)
             AECreateMatinee("ActionEventMatinee71", "ActionEventPoint71", 0.6, Time, "zipline_arrive"," ",-95 )
			 --StartLine1
             AECreateMatinee("ActionEventMatinee72", "ActionEventPoint72", 0.7, Time, "zipline_start","ActionEventMatinee73",-95)
             AECreateMatinee("ActionEventMatinee73", "ActionEventPoint73", 3.0i, Loop, "zipline_idle_3","ActionEventMatinee74",-95)
             AECreateMatinee("ActionEventMatinee74", "ActionEventPoint74", 0.6, Time, "zipline_arrive"," ",-95 )
			 --StartLine2
             AECreateMatinee("ActionEventMatinee75", "ActionEventPoint75", 0.7, Time, "zipline_start","ActionEventMatinee76",-95)
             AECreateMatinee("ActionEventMatinee76", "ActionEventPoint76", 3.0, Loop, "zipline_idle_3","ActionEventMatinee77",-95)
             AECreateMatinee("ActionEventMatinee77", "ActionEventPoint77", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line15
             AECreateMatinee("ActionEventMatinee78", "ActionEventPoint78", 0.7, Time, "zipline_start","ActionEventMatinee79",-95)
             AECreateMatinee("ActionEventMatinee79", "ActionEventPoint79", 4.0, Loop, "zipline_idle_3","ActionEventMatinee80",-95)
             AECreateMatinee("ActionEventMatinee80", "ActionEventPoint80", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line15Back
             AECreateMatinee("ActionEventMatinee81", "ActionEventPoint81", 0.7, Time, "zipline_start","ActionEventMatinee82",-95)
             AECreateMatinee("ActionEventMatinee82", "ActionEventPoint82", 4.0, Loop, "zipline_idle_3","ActionEventMatinee83",-95)
             AECreateMatinee("ActionEventMatinee83", "ActionEventPoint83", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line16
             AECreateMatinee("ActionEventMatinee84", "ActionEventPoint84", 0.7, Time, "zipline_start","ActionEventMatinee85",-95)
             AECreateMatinee("ActionEventMatinee85", "ActionEventPoint85", 4.0, Loop, "zipline_idle_3","ActionEventMatinee86",-95)
             AECreateMatinee("ActionEventMatinee86", "ActionEventPoint86", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line16Back
             AECreateMatinee("ActionEventMatinee87", "ActionEventPoint87", 0.7, Time, "zipline_start","ActionEventMatinee88",-95)
             AECreateMatinee("ActionEventMatinee88", "ActionEventPoint88", 4.0, Loop, "zipline_idle_3","ActionEventMatinee89",-95)
             AECreateMatinee("ActionEventMatinee89", "ActionEventPoint89", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line17
             AECreateMatinee("ActionEventMatinee90", "ActionEventPoint90", 0.7, Time, "zipline_start","ActionEventMatinee91",-95)
             AECreateMatinee("ActionEventMatinee91", "ActionEventPoint91", 4.0, Loop, "zipline_idle_3","ActionEventMatinee92",-95)
             AECreateMatinee("ActionEventMatinee92", "ActionEventPoint92", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line17Back
             AECreateMatinee("ActionEventMatinee93", "ActionEventPoint93", 0.7, Time, "zipline_start","ActionEventMatinee94",-95)
             AECreateMatinee("ActionEventMatinee94", "ActionEventPoint94", 4.0, Loop, "zipline_idle_3","ActionEventMatinee95",-95)
             AECreateMatinee("ActionEventMatinee95", "ActionEventPoint95", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line18
             AECreateMatinee("ActionEventMatinee96", "ActionEventPoint96", 0.7, Time, "zipline_start","ActionEventMatinee97",-95)
             AECreateMatinee("ActionEventMatinee97", "ActionEventPoint97", 4.0, Loop, "zipline_idle_3","ActionEventMatinee98",-95)
             AECreateMatinee("ActionEventMatinee98", "ActionEventPoint98", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line18Back
             AECreateMatinee("ActionEventMatinee99", "ActionEventPoint99", 0.7, Time, "zipline_start","ActionEventMatinee100",-95)
             AECreateMatinee("ActionEventMatinee100", "ActionEventPoint100", 4.0, Loop, "zipline_idle_3","ActionEventMatinee101",-95)
             AECreateMatinee("ActionEventMatinee101", "ActionEventPoint101", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line19
             AECreateMatinee("ActionEventMatinee102", "ActionEventPoint102", 0.7, Time, "zipline_start","ActionEventMatinee103",-95)
             AECreateMatinee("ActionEventMatinee103", "ActionEventPoint103", 4.0, Loop, "zipline_idle_3","ActionEventMatinee104",-95)
             AECreateMatinee("ActionEventMatinee104", "ActionEventPoint104", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line19Back
             AECreateMatinee("ActionEventMatinee105", "ActionEventPoint105", 0.7, Time, "zipline_start","ActionEventMatinee106",-95)
             AECreateMatinee("ActionEventMatinee106", "ActionEventPoint106", 4.0, Loop, "zipline_idle_3","ActionEventMatinee107",-95)
             AECreateMatinee("ActionEventMatinee107", "ActionEventPoint107", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line20
             AECreateMatinee("ActionEventMatinee108", "ActionEventPoint108", 0.7, Time, "zipline_start","ActionEventMatinee109",-95)
             AECreateMatinee("ActionEventMatinee109", "ActionEventPoint109", 4.0, Loop, "zipline_idle_3","ActionEventMatinee110",-95)
             AECreateMatinee("ActionEventMatinee110", "ActionEventPoint110", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line20Back
             AECreateMatinee("ActionEventMatinee111", "ActionEventPoint111", 0.7, Time, "zipline_start","ActionEventMatinee112",-95)
             AECreateMatinee("ActionEventMatinee112", "ActionEventPoint112", 4.0, Loop, "zipline_idle_3","ActionEventMatinee113",-95)
             AECreateMatinee("ActionEventMatinee113", "ActionEventPoint113", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line21
             AECreateMatinee("ActionEventMatinee114", "ActionEventPoint114", 0.7, Time, "zipline_start","ActionEventMatinee115",-95)
             AECreateMatinee("ActionEventMatinee115", "ActionEventPoint115", 4.0, Loop, "zipline_idle_3","ActionEventMatinee116",-95)
             AECreateMatinee("ActionEventMatinee116", "ActionEventPoint116", 0.6, Time, "zipline_arrive"," ",-95 )
			 --Line21Back
             AECreateMatinee("ActionEventMatinee117", "ActionEventPoint117", 0.7, Time, "zipline_start","ActionEventMatinee118",-95)
             AECreateMatinee("ActionEventMatinee118", "ActionEventPoint118", 4.0, Loop, "zipline_idle_3","ActionEventMatinee119",-95)
             AECreateMatinee("ActionEventMatinee119", "ActionEventPoint119", 0.6, Time, "zipline_arrive"," ",-95 ) 
end

function UpdateDrone( ObjHandle )                                                          -- 유저가 정의한 업데이트 함수. 이름은 알아서…

       name, dist = AEGetClearPoint(ObjHandle)                                             -- name이 nil 이다가 목적지에 도착하면 그 포인트 이름과 목적지와의 정확한 거리를 반환
       
 --      if name == "DronePoint00" then                                                      -- 조건보고
 --                    rndval = math.random( 1, 100 )
 --                    if rndval >= 1 and rndval <= 33 then                                  -- 확률로 경로 선택
 --                                 AERunToPoint(ObjHandle, "DronePoint04","DronePoint08")                  -- 경유지를 거쳐서 목적지를 갈수 있도록 한다. 개수는 맘대로해도 되나 되도록 작게..
 --                    elseif rndval >= 34 and rndval <= 66 then
 --                                 AERunToPoint(ObjHandle, "DronePoint04","DronePoint06")
 --            		 elseif rndval >= 67 and rndval <= 100 then
 --                                 AERunToPoint(ObjHandle, "DronePoint01","DronePoint02")			  
 --                    end
        if name == "DronePoint00" then
                     rndval = math.random( 1, 100 )
                     if rndval >= 1 and rndval <= 100 then                                  -- 확률로 경로 선택
                                  AERunToPoint(ObjHandle, "DronePoint01")                  -- 경유지를 거쳐서 목적지를 갈수 있도록 한다. 개수는 맘대로해도 되나 되도록 작게..	  
                     end
		elseif name == "DronePoint01" then	
		             rndval = math.random( 1, 100 )
                     if rndval >= 1 and rndval <= 100 then                                  -- 확률로 경로 선택
                                  AERunToPoint(ObjHandle, "DronePoint02")                  -- 경유지를 거쳐서 목적지를 갈수 있도록 한다. 개수는 맘대로해도 되나 되도록 작게..	  
                     end
		elseif name == "DronePoint02" then	
		             rndval = math.random( 1, 100 )
                     if rndval >= 1 and rndval <= 100 then                                  -- 확률로 경로 선택
                                  AERunToPoint(ObjHandle, "DronePoint03")                  -- 경유지를 거쳐서 목적지를 갈수 있도록 한다. 개수는 맘대로해도 되나 되도록 작게..	  
                     end
		elseif name == "DronePoint03" then	
		             rndval = math.random( 1, 100 )
                     if rndval >= 1 and rndval <= 100 then                                  -- 확률로 경로 선택
                                  AERunToPoint(ObjHandle, "DronePoint04")                  -- 경유지를 거쳐서 목적지를 갈수 있도록 한다. 개수는 맘대로해도 되나 되도록 작게..	  
                     end					 
		elseif name == "DronePoint04" then	
		             rndval = math.random( 1, 100 )
                     if rndval >= 1 and rndval <= 100 then                                  -- 확률로 경로 선택
                                  AERunToPoint(ObjHandle, "DronePoint05")                  -- 경유지를 거쳐서 목적지를 갈수 있도록 한다. 개수는 맘대로해도 되나 되도록 작게..	  
                     end
		elseif name == "DronePoint05" then	
		             rndval = math.random( 1, 100 )
                     if rndval >= 1 and rndval <= 100 then                                  -- 확률로 경로 선택
                                  AERunToPoint(ObjHandle, "DronePoint06")                  -- 경유지를 거쳐서 목적지를 갈수 있도록 한다. 개수는 맘대로해도 되나 되도록 작게..	  
                     end
		elseif name == "DronePoint06" then	
		             rndval = math.random( 1, 100 )
                     if rndval >= 1 and rndval <= 100 then                                  -- 확률로 경로 선택
                                  AERunToPoint(ObjHandle, "DronePoint07")                  -- 경유지를 거쳐서 목적지를 갈수 있도록 한다. 개수는 맘대로해도 되나 되도록 작게..	  
                     end
		elseif name == "DronePoint07" then	
		             rndval = math.random( 1, 100 )
                     if rndval >= 1 and rndval <= 100 then                                  -- 확률로 경로 선택
                                  AERunToPoint(ObjHandle, "DronePoint08")                  -- 경유지를 거쳐서 목적지를 갈수 있도록 한다. 개수는 맘대로해도 되나 되도록 작게..	  
                     end
		elseif name == "DronePoint08" then	
		             rndval = math.random( 1, 100 )
                     if rndval >= 1 and rndval <= 100 then                                  -- 확률로 경로 선택
                                  AERunToPoint(ObjHandle, "DronePoint09")                  -- 경유지를 거쳐서 목적지를 갈수 있도록 한다. 개수는 맘대로해도 되나 되도록 작게..	  
                     end
		elseif name == "DronePoint09" then	
		             rndval = math.random( 1, 100 )
                     if rndval >= 1 and rndval <= 100 then                                  -- 확률로 경로 선택
                                  AERunToPoint(ObjHandle, "DronePoint10")                  -- 경유지를 거쳐서 목적지를 갈수 있도록 한다. 개수는 맘대로해도 되나 되도록 작게..	  
                     end
		elseif name == "DronePoint10" then	
		             rndval = math.random( 1, 100 )
                     if rndval >= 1 and rndval <= 100 then                                  -- 확률로 경로 선택
                                  AERunToPoint(ObjHandle, "DronePoint00")								  -- 경유지를 거쳐서 목적지를 갈수 있도록 한다. 개수는 맘대로해도 되나 되도록 작게..	  
                     end
	 end
	 return 1      
end

function OnEvent(eventKey, eventData, x, y, z)                                                   -- 정의된 이벤트 함수. 클라이언트가 상황에 따라 호출한다.
       if eventKey == 0 then                                                                    -- 키타입이 0이면 드론 생성
	                 DronePointVal = math.random(0,10)
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
					  elseif DronePointVal == 6 then
					      DroneStart = "DronePoint06" 
					  elseif DronePointVal == 7 then
					      DroneStart = "DronePoint07" 
					  elseif DronePointVal == 8 then
					      DroneStart = "DronePoint08" 
					  elseif DronePointVal == 9 then
					      DroneStart = "DronePoint09" 
					  elseif DronePointVal == 10 then
					      DroneStart = "DronePoint10"
					  end
						  
					ObjHandle = AECreateBot(nil, 1217, DroneStart, 1000)                   -- 드론봇 인덱스를 호출. index(nil:랜덤), BotID, 생성위치("PointName" or x,y,z)
					AEUpdateTimer(ObjHandle, 1, 1.0)                                           -- 유저가 앞서 정의한 업데이트 함수 연결 ( , 함수ID, )

                     -- AEMoveOption(ObjHandle,....)
                     -- 타겟범위(0.1~99999)
                     -- 이동옵션(0:그냥이동, 1:회전방향으로 이동, 2:회전후 이동)
                     -- 회전속도(0.1~100)
                     -- 이동속도(0.1~99999)
                     -- 미끄러짐(0.1~100)				
                     AEMoveOption(ObjHandle, 50, 1, 1.0, 600.0, 15)

       elseif eventKey == 1 then                                                                        -- 키타입이 1이면 아이템 박스 생성

                     ObjHandle = AECreateBot(nil, 1218, x, y, z)                                   -- 아이템박스봇 인덱스를 호출
                     AESetData(ObjHandle, eventKey, eventData)                                  -- 봇을 실제 박스 정보 인덱스와 연결하는 부분
       
       end
end



 







------------------------------------------------------------