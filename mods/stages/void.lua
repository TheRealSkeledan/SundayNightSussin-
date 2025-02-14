function onCreate()
    makeLuaSprite('voidBG', 'voidBG', 0, 0);
    setScrollFactor('voidBG', 0.7, 0.7);

    makeLuaSprite('voidLight', 'voidLight', 0, 0);
    setScrollFactor('voidLight', 0.7, 0.7);

    addLuaSprite('voidBG', false);
    addLuaSprite('voidLight', true);
    close(true);
end
