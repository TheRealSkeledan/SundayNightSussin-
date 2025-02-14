local fancyGameOver = false --Check this if you want a fancy gameover screen!
local impostorHUD = true --Check this if you want the Vs Impostor V4 HUD.
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
        setTextString('scoreTxt', 'Score: '..score..' | Misses: '..misses..' / ? | Rating: ?'..ratingFC)
    end

    if impostorHUD then

        makeLuaText('timeTxtNew', '')
        addLuaText('timeTxtNew', true)
        setTextSize('timeTxtNew', 14)
        setProperty('timeTxtNew.borderSize', 0.35)
        setProperty('timeTxtNew.alpha', 0)

        setProperty('timeBarBG.visible', false)
        setProperty('timeTxt.visible', false)
        setTimeBarColors('00FF00', '')
        setTextColor('botplayTxt', rgbToHex(getProperty("dad.healthColorArray")))
        setTextColor('scoreTxt', rgbToHex(getProperty("dad.healthColorArray")))

        makeLuaSprite('taskBar', 'taskBar', 95, 20)
        setObjectCamera("taskBar", "camHUD")
        addLuaSprite('taskBar', true)
        setObjectOrder('taskBar', 1)
        setProperty('taskBar.alpha', 0)
        setTextString('scoreTxt', 'Score: '..misses..' | Combo Breaks: '..misses..' | Accuracy: ?'..ratingFC)
        if mechanics then
            setTextString('scoreTxt', 'Score: '..score..' | Combo Breaks: '..misses..' / ? | Accuracy: ?'..ratingFC)
        end
    end
end

function onUpdate()
    if allowOpening and mechanics then
        cameraFlash('camOther', '000000', 1.5)
        openCustomSubstate('missSelect', true)
    end
end


function onCustomSubstateCreate(name)
    if name == 'missSelect' then
     allowOpening = false
     setProperty('camHUD.visible', false)
     setProperty('camGame.visible', false)
     playSound('susMenu', 0.8, 'sussyMenu')

     makeLuaSprite('arrow', 'missAmountArrow', 900, 400)
     setObjectCamera("arrow", "camOther")
     scaleObject('arrow', 1, 1)
     addLuaSprite('arrow')
     
     makeLuaSprite('theVoid', 'theVoid')
     setObjectCamera("theVoid", "camOther")
     scaleObject('theVoid', 1.5, 1.5)
     addLuaSprite('theVoid')
     screenCenter("theVoid", "x")
     screenCenter("theVoid", "y")

     makeLuaText('breaks', '?/? MISSES POSSIBLE', 1000, 150, 87.5)
	 setTextSize("breaks", 100)
	 setTextAlignment("breaks", "center")
	 setObjectCamera("breaks", "camOther")
     setProperty('breaks.borderSize', 3)
     addLuaText("breaks")
     setTextColor('breaks', 'FF0000')
     screenCenter("breaks", "x")
     screenCenter("breaks", "y")

     makeLuaSprite('border', 'barThing')
     setObjectCamera("border", "camOther")
     scaleObject('border', 1.03, 1.03)
     addLuaSprite('border')
     screenCenter("border", "x")
     screenCenter("border", "y")
     
    end

end

function onCustomSubstateUpdate()
    setTextString('breaks', maxMisses..' MISSES POSSIBLE')

    if impostorHUD then
        setTextString('breaks', maxMisses..' MISSES POSSIBLE')
    end
    
    if keyJustPressed('accept') then
        cameraFlash('camOther', '000000', 1.5)
        playSound('acceptsus')
        setProperty("theVoid.x", 10000)
        closeCustomSubstate('missSelect', true)
        setProperty('camHUD.visible', true)
        setProperty('camGame.visible', true)
        setProperty('breaks.visible', false)
        soundFadeOut('sussyMenu', 1, 0)
    end

    if keyJustPressed('back') then
        playSound('cancelSus')
        soundFadeOut('sussyMenu', 0.5, 0)
        exitSong()
    end

    if keyJustPressed('right') and maxMisses ~= 0 then
        maxMisses = maxMisses - 1
        changeColor(maxMisses)
        setProperty('arrow.x', getProperty('arrow.x') + 50)
        playSound('hoverSus')
    end

    if keyJustPressed('left') and maxMisses ~= 5 then
        maxMisses = maxMisses + 1
        setProperty('arrow.x', getProperty('arrow.x') - 50)
        playSound('hoverSus')
    end
    if comboBreaks == 0 then setTextColor('breaks', 'FF0000') end
    if comboBreaks == 1 then setTextColor('breaks', 'FF5500') end
    if comboBreaks == 2 then setTextColor('breaks', 'FFD500') end
    if comboBreaks == 3 then setTextColor('breaks', 'BFFF00') end
    if comboBreaks == 4 then setTextColor('breaks', '55FF00') end
    if comboBreaks == 5 then setTextColor('breaks', '00FF6A') end
end

function changeColour(comboBreaks)
    
end

function round(x, n) --https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
	--Stupid accuracy (i hate it).
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end

function onUpdatePost()
    if mechanics then
        setProperty('health', 1)
        setProperty('iconP2.x', 510)
        setProperty('iconP1.x', 620)

        if misses > maxMisses and not botPlay and not practice then
            setProperty('health', 0)
        end
    end

    setTextString('scoreTxt', 'Score: '..score..' | Misses: '..misses..' / '..maxMisses..' | Rating: ?'..ratingFC)
end

function onSongStart()
    
    if impostorHUD then
        
       setProperty('timeBar.y', getProperty('taskBar.y') + 4.75)
       setProperty('timeBar.x', getProperty('taskBar.x') + 3)
       setProperty('timeTxtNew.y', getProperty('taskBar.y'))
       setProperty('timeTxtNew.x', getProperty('taskBar.x') + 7.5)
       scaleObject('timeBar', 1, 0.952)
       setTextString('timeTxtNew', string.upper(songName))
       doTweenAlpha('appear1', 'taskBar', 1, 0.25, 'linear')
	   doTweenAlpha('appear2', 'timeTxtNew', 1, 0.25, 'linear')
    end
end

function onUpdateScore()
    curAcc = round((getProperty('ratingPercent') * 100), 2).. '%'
    if impostorHUD then
        if ratingFC == 'SFC' then 
            ratingFC =  ' [SFC]'
        elseif ratingFC == 'GFC' then 
            ratingFC = ' [GFC]'
        elseif ratingFC == 'FC' then
            ratingFC = ' [FC]'
        elseif ratingFC == 'SDCB' then 
            ratingFC = ''
        elseif ratingFC == 'Clear' then
            ratingFC = ''     
        end
        setTextString('scoreTxt', 'Score: ' ..score..' | Combo Breaks: '..misses..' | Accuracy: '..curAcc..ratingFC)
    end

    if mechanics then
         setTextString('scoreTxt', 'Score: '..score..' | Misses: '..misses..' / '..maxMisses..' | Rating: '..ratingName..' ('..curAcc..') - '..ratingFC)
        if impostorHUD then
            setTextString('scoreTxt', 'Score: ' ..score..' | Combo Breaks: '..misses..' / '..maxMisses..' | Accuracy: ' ..curAcc..ratingFC)
        end
    end
end