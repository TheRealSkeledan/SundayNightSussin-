function onCreate()
    makeLuaSprite('sapphireBedroomBack', 'sapphireBedroomBack', -600, -300);
    setScrollFactor('sapphireBedroomBack', 0.9, 0.9);

    makeLuaSprite('sapphireBedroomFront', 'sapphireBedroomFront', -600, -300);
    setScrollFactor('sapphireBedroomFront', 0.9, 0.9);

    addLuaSprite('sapphireBedroomBack', false);
    addLuaSprite('sapphireBedroomFront', true);
end