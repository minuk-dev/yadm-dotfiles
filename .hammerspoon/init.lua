-- hammerspoon config

ENGLISH_INPUTS = {
	["com.apple.keylayout.ABC"] = true,
	["org.youknowone.inputmethod.Gureum.system"] = true,
}
KOREAN_INPUTS = {
	["org.youknowone.inputmethod.Gureum.han2"] = true,
	["com.apple.inputmethod.Korean.2SetKorean"] = true,
}

function getAvailableInput(inputs)
	for inputName, _ in pairs(inputs) do
		if hs.keycodes.currentSourceID(inputName) then
			return inputName
		end
	end
end

INPUT_ENGLISH = getAvailableInput(ENGLISH_INPUTS)
INPUT_KOREAN = getAvailableInput(KOREAN_INPUTS)

require("modules.inputsource_aurora")

local escWatcher = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
	-- 모든 키 코드 확인하는 방법: hs.inspect(hs.keycodes.map)
	-- print("KeyCode:", event:getKeyCode(), "Key:", hs.keycodes.map[event:getKeyCode()])
	-- ESC 키 코드: 53
	if event:getKeyCode() == 53 then
		-- 입력소스 "설정"은 동기식이라 느리다. ESC 연타 시 매번 호출하면
		-- 이벤트탭 콜백이 느려져 macOS 가 탭을 타임아웃으로 비활성화시켜 먹통이 된다.
		-- 이미 영문이면 (빠른) 읽기만 하고 설정은 건너뛴다.
		if not ENGLISH_INPUTS[hs.keycodes.currentSourceID()] then
			hs.keycodes.currentSourceID(INPUT_ENGLISH)
		end
		hs.alert.show("escape", 0.5)
	end
	return false -- 이벤트를 계속 전달 (ESC 동작은 유지됨)
end)

escWatcher:start()
