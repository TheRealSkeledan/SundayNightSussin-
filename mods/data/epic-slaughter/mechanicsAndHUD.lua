local mechanics = true --Check this if you want the mechanics.
--Leave these two below alone, if you don't the script might break!
local maxMisses = 0
local allowOpening = true 

function rgbToHex(array)
    return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end

function onCreatePost()
    if mechanics then
        setProperty('healthBar.visible', false)
        setProperty('healthBarBG.visible', false)
    end
end

function onUpdatePost()
    if mechanics then
        setProperty('health', 1)
        setProperty('iconP2.x', 510)
        setProperty('iconP1.x', 620)

        if misses == 30 and not botPlay and not practice then
            setProperty('health', 0)
        end
    end
end