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
		-- 입력소스 전환은 비동기로 처리해 이벤트탭 콜백이 즉시 반환하도록 한다.
		hs.timer.doAfter(0, function()
			-- 이미 영문이면 굳이 바꾸지 않는다 (연타 시 불필요한 전환 방지)
			if not ENGLISH_INPUTS[hs.keycodes.currentSourceID()] then
				hs.keycodes.currentSourceID(INPUT_ENGLISH)
			end
		end)
		hs.alert.show("escape", 0.5)
	end
	return false -- 이벤트를 계속 전달 (ESC 동작은 유지됨)
end)

escWatcher:start()
