function onCreate()
    --variables
	Dodged = false;
    canDodge = false;
    DodgeTime = 0;
	
    precacheImage('spacebar');
    precacheSound('DODGE');
	precacheSound('Dodged');
end

function onEvent(name, value1, value2)
    if name == "DodgeEvent" then
    --Get Dodge time
    DodgeTime = (value1);
	
    --Make Dodge Sprite
	makeAnimatedLuaSprite('spacebar', 'spacebar', 400, 200);
    luaSpriteAddAnimationByPrefix('spacebar', 'spacebar', 'spacebar', 12, true);
	luaSpritePlayAnimation('spacebar', 'spacebar');
	setObjectCamera('spacebar', 'other');
	scaleLuaSprite('spacebar', 0.50, 0.50); 
    addLuaSprite('spacebar', true); 
	
	--Set values so you can dodge
    playSound('FiredragonWarn', 2);
	canDodge = true;
	runTimer('Died', DodgeTime);
	
	end
end

function onUpdate()
   if canDodge == true and keyJustPressed('accept') then
   
    Dodged = true;
    playSound('FiredragonShoot', 2);
    characterPlayAnim('dad', 'shoot', true);
    setProperty('dad.specialAnim', true);
    removeLuaSprite('spacebar');
    canDodge = false
   
   end
end

function onTimerCompleted(tag, loops, loopsLeft)
   if tag == 'Died' and Dodged == false then
        characterPlayAnim('dad', 'shoot', true);
        setProperty('dad.specialAnim', true);
        setProperty('health', 0);
   elseif tag == 'Died' and Dodged == true then
    Dodged = false
   
   end
end