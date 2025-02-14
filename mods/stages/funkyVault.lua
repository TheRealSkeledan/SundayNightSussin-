function onCreate()
    makeLuaSprite('vaultBack', 'vaultBack', -600, -300);
    setScrollFactor('vaultBack', 0.9, 0.9);

    makeLuaSprite('vaultFront', 'vaultFront', -600, -300);
    setScrollFactor('vaultFront', 0.9, 0.9);

    makeAnimatedLuaSprite('leftChars', 'leftChars', -600, -300);
    addAnimationByPrefix('leftChars', 'idle', 'idle', 12, false);
    playAnim('leftChars', 'idle', true);

    makeAnimatedLuaSprite('rightChars', 'rightChars', -600, -300);
    addAnimationByPrefix('rightChars', 'idle', 'idle', 12, false);
    playAnim('rightChars', 'idle', true);

    addLuaSprite('vaultBack', false);
    addLuaSprite('vaultFront', true);
    addLuaSprite('rightChars', true);
    addLuaSprite('leftChars', true);
end

function onBeatHit()
    if curBeat % 2 == 0 then
        objectPlayAnimation('rightChars', 'idle');
        objectPlayAnimation('leftChars', 'idle');
    end
end