function onEvent(name, value1, value2)
    if name == "Jumpscare" then
		makeLuaSprite('image', value1, 0, 0);
		addLuaSprite('image', true);
		setProperty('image.alpha', 1);
		doTweenColor('hello', 'image', 'FFFFFFFF', 1, 'quartIn');
		setObjectCamera('image', 'Other');
		runTimer('wait', value2);
		cameraShake('camOther', 1, value2);
	end
end
    
function onTimerCompleted(tag, loops, loopsleft)
    if tag == 'wait' then
		doTweenAlpha('byebye', 'image', 0, 1, 'quartOut');
    end
end
    
function onTweenCompleted(tag)
    if tag == 'byebye' then
		removeLuaSprite('image', true);
    end
end