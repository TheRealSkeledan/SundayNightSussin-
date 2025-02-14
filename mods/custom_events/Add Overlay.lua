-- Event by JoltGanda
function onEvent(name, value1, value2)
	if name == 'Add Overlay' then
		if value2 == 'delete'
			removeLuaSprite(value1, true)
		else
			makeLuaSprite(value1, value1, 0, 0)
			setScrollFactor(value1, value2);
			setObjectCamera(value1, 'hud');
			addLuaSprite(value1, true)
		end
	end
end