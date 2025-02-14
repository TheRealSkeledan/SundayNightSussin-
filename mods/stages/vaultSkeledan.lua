function onCreate()
    makeLuaSprite('vaultBack', 'vaultBack', -600, -300);
    setScrollFactor('vaultBack', 0.9, 0.9);

    makeLuaSprite('vaultFront', 'vaultFront', -600, -300);
    setScrollFactor('vaultFront', 0.9, 0.9);

    addLuaSprite('vaultBack', false);
    addLuaSprite('vaultFront', true);

    close(true);
end
