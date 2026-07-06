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
		-- 콜백에서 무거운 일(입력소스 전환/alert 그리기)을 직접 하면 느려져서
		-- 연타 몇 번 만에 macOS 가 이벤트탭을 타임아웃으로 꺼버린다(그 뒤로 먹통).
		-- => 콜백은 즉시 반환하고, 느린 작업은 전부 비동기로 넘긴다.
		hs.timer.doAfter(0, function()
			-- 이미 영문이면 굳이 바꾸지 않는다 (연타 시 불필요한 전환 방지)
			if not ENGLISH_INPUTS[hs.keycodes.currentSourceID()] then
				hs.keycodes.currentSourceID(INPUT_ENGLISH)
				hs.alert.show("escape", 0.5)
			end
		end)
	end
	return false -- 이벤트를 계속 전달 (ESC 동작은 유지됨)
end)

escWatcher:start()
