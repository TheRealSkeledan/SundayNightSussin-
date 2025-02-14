function onCreate()
    makeLuaSprite('defeatBG', 'defeatBG', 0, 0);
    setScrollFactor('defeatBG', 0.7, 0.7);

    --makeLuaSprite('defeatLight', 'defeatLight', 0, 0);
    --setScrollFactor('defeatLight', 0.7, 0.7);

    addLuaSprite('defeatBG', false);
    --addLuaSprite('defeatLight', true);
    close(true);
end
