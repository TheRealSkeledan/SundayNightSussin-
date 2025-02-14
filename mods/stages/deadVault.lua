function onCreate()
    makeLuaSprite('deadVaultBack', 'deadVaultBack', -600, -300);
    setScrollFactor('deadVaultBack', 0.9, 0.9);

    makeLuaSprite('deadVaultFront', 'deadVaultFront', -600, -300);
    setScrollFactor('deadVaultFront', 0.9, 0.9);

    addLuaSprite('deadVaultBack', false);
    addLuaSprite('deadVaultFront', true);

    close(true);
end