function onCreate()
    makeLuaSprite('darknessBack', 'darknessBack', 0, 0);
    setScrollFactor('darknessBack', 0.7, 0.7);

    makeLuaSprite('darknessFront', 'darknessFront', 0, 0);
    setScrollFactor('darknessFront', 0.7, 0.7);

    addLuaSprite('darknessBack', false);
    addLuaSprite('darknessFront', true);
    close(true);
end
