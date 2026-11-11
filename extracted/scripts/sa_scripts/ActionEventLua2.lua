-- 32구역 드론 AI스크립트
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
end

function UpdateDrone( ObjHandle )                                                          -- 유저가 정의한 업데이트 함수. 이름은 알아서…

    name, dist = AEGetClearPoint(ObjHandle)                                             -- name이 nil 이다가 목적지에 도착하면 그 포인트 이름과 목적지와의 정확한 거리를 반환

  if name == "DronePoint" then
                   AERunToPoint(ObjHandle, "DronePoint00") 

		elseif name == "DronePoint00" then
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
                   AERunToPoint(ObjHandle, "DronePoint06") 
		elseif name == "DronePoint06" then
                   AERunToPoint(ObjHandle, "DronePoint07") 
		elseif name == "DronePoint07" then
                   AERunToPoint(ObjHandle, "DronePoint08") 
		elseif name == "DronePoint08" then
                   AERunToPoint(ObjHandle, "DronePoint09") 
		elseif name == "DronePoint09" then
                   AERunToPoint(ObjHandle, "DronePoint10") 
		elseif name == "DronePoint10" then
                   AERunToPoint(ObjHandle, "DronePoint11") 
		elseif name == "DronePoint11" then
                   AERunToPoint(ObjHandle, "DronePoint12") 
		elseif name == "DronePoint12" then
                   AERunToPoint(ObjHandle, "DronePoint13") 
		elseif name == "DronePoint13" then
                   AERunToPoint(ObjHandle, "DronePoint14") 
		elseif name == "DronePoint14" then
                   AERunToPoint(ObjHandle, "DronePoint15") 
		elseif name == "DronePoint15" then
                   AERunToPoint(ObjHandle, "DronePoint16") 
		elseif name == "DronePoint16" then
                   AERunToPoint(ObjHandle, "DronePoint") 

	 end 
	 return 1     
end

function OnEvent(eventKey, eventData, x, y, z)                                                   -- 정의된 이벤트 함수. 클라이언트가 상황에 따라 호출한다.
       if eventKey == 0 then                                                                    -- 키타입이 0이면 드론 생성
	                 DronePointVal = math.random(0,17)

					  if DronePointVal == 0 then
					      DroneStart = "DronePoint"
					  elseif DronePointVal == 1 then
					      DroneStart = "DronePoint00" 
					  elseif DronePointVal == 2 then
					      DroneStart = "DronePoint01" 
					  elseif DronePointVal == 3 then
					      DroneStart = "DronePoint02" 
					  elseif DronePointVal == 4 then
					      DroneStart = "DronePoint03" 
					  elseif DronePointVal == 5 then
					      DroneStart = "DronePoint04" 
					  elseif DronePointVal == 6 then
					      DroneStart = "DronePoint05" 
					  elseif DronePointVal == 7 then
					      DroneStart = "DronePoint06" 
					  elseif DronePointVal == 8 then
					      DroneStart = "DronePoint07" 
					  elseif DronePointVal == 9 then
					      DroneStart = "DronePoint08" 
					  elseif DronePointVal == 10 then
					      DroneStart = "DronePoint09" 
					  elseif DronePointVal == 11 then
					      DroneStart = "DronePoint10" 
					  elseif DronePointVal == 12 then
					      DroneStart = "DronePoint11" 
					  elseif DronePointVal == 13 then
					      DroneStart = "DronePoint12" 
					  elseif DronePointVal == 14 then
					      DroneStart = "DronePoint13" 
					  elseif DronePointVal == 15 then
					      DroneStart = "DronePoint14" 
					  elseif DronePointVal == 16 then
					      DroneStart = "DronePoint15" 
					  elseif DronePointVal == 17 then
					      DroneStart = "DronePoint16" 
 

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