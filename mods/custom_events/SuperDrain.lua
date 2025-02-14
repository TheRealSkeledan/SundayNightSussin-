-- Event by JoltGanda
function onEvent(name, value1, value2) 
	if name == 'SuperDrain' then
		runTimer('drain', 0.2, 0);
	end
	if name == 'SuperDrain' and value1 == 'off' then
		cancelTimer('drain');
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	setProperty('health', getProperty('health')-0.01);
end