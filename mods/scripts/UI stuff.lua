local fancyGameOver = true --Check this if you want a fancy gameover screen!
local impostorHUD = true --Check this if you want the Vs Impostor V4 HUD.
local mechanics = false --Check this if you want the mechanics.
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
        setTextString('scoreTxt', 'Score: '..misses..' | Combo Breaks: '..misses..'/30 | Accuracy: ?'..ratingFC)
        if mechanics then
            setTextString('scoreTxt', 'Score: '..score..' | Combo Breaks: '..misses..' / ? | Accuracy: ?'..ratingFC)
        end
    end

    if fancyGameOver then
       setPropertyFromClass('GameOverSubstate', 'deathSoundName', '');
       setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'losssus');
       setPropertyFromClass('GameOverSubstate', 'endSoundName', 'loseend');
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

     makeLuaText('breaks', '?/? COMBO BREAKS', 1000, 150, 87.5)
	 setTextSize("breaks", 100)
	 setTextAlignment("breaks", "center")
	 setObjectCamera("breaks", "camOther")
     setProperty('breaks.borderSize', 3)
     addLuaText("breaks")
     setTextColor('breaks', 'FF0000')
     screenCenter("breaks", "x")

     makeLuaSprite('space', 'space')
     setObjectCamera("space", "camOther")
     scaleObject('space', 1.5, 1.5)
     addLuaSprite('space')
     screenCenter("space", "x")
     screenCenter("space", "y")

     makeLuaSprite('border', 'borderSus')
     setObjectCamera("border", "camOther")
     scaleObject('border', 1.03, 1.03)
     addLuaSprite('border')
     screenCenter("border", "x")
     screenCenter("border", "y")

     makeLuaSprite('sus1', 'dummypostor1', 275, 440)
     setObjectCamera("sus1", "camOther")
     scaleObject('sus1', 1, 1)
     addLuaSprite('sus1')

     makeLuaSprite('sus2', 'dummypostor2', 200, 440)
     setObjectCamera("sus2", "camOther")
     scaleObject('sus2', 1, 1)
     addLuaSprite('sus2')
     setProperty('sus2.x', getProperty('sus1.x') + 125)

     makeLuaSprite('sus3', 'dummypostor3', 200, 485)
     setObjectCamera("sus3", "camOther")
     scaleObject('sus3', 1, 1)
     addLuaSprite('sus3')
     setProperty('sus3.x', getProperty('sus2.x') + 125)

     makeLuaSprite('sus4', 'dummypostor4', 200, 485)
     setObjectCamera("sus4", "camOther")
     scaleObject('sus4', 1, 1)
     addLuaSprite('sus4')
     setProperty('sus4.x', getProperty('sus3.x') + 125)
 
     makeLuaSprite('sus5', 'dummypostor5', 200, 510)
     setObjectCamera("sus5", "camOther")
     scaleObject('sus5', 1, 1)
     addLuaSprite('sus5')
     setProperty('sus5.x', getProperty('sus4.x') + 125)

     makeLuaSprite('sus6', 'dummypostor6', 200, 510)
     setObjectCamera("sus6", "camOther")
     scaleObject('sus6', 1, 1)
     addLuaSprite('sus6')
     setProperty('sus6.x', getProperty('sus5.x') + 125)

     makeLuaSprite('arrow', 'missAmountArrow', 900, 400)
     setObjectCamera("arrow", "camOther")
     scaleObject('arrow', 1, 1)
     addLuaSprite('arrow')
    end

end

function onCustomSubstateUpdate()
    setTextString('breaks', maxMisses..'/5 MISSES')

    if impostorHUD then
        setTextString('breaks', maxMisses..'/5 COMBO BREAKS')
    end
    
    if keyJustPressed('accept') then
        cameraFlash('camOther', '000000', 1.5)
        playSound('acceptsus')
        closeCustomSubstate('missSelect', true)
        setProperty('camHUD.visible', true)
        setProperty('camGame.visible', true)
        setProperty('breaks.visible', false)
        removeLuaSprite('sus1', true)
        removeLuaSprite('sus2', true)
        removeLuaSprite('sus3', true)
        removeLuaSprite('sus4', true)
        removeLuaSprite('sus5', true)
        removeLuaSprite('sus6', true)
        removeLuaSprite('arrow', true)
        removeLuaSprite('space', true)
        removeLuaSprite('border', true)
        soundFadeOut('sussyMenu', 1, 0)
    end

    if keyJustPressed('back') then
        playSound('cancelSus')
        soundFadeOut('sussyMenu', 0.5, 0)
        exitSong()
    end

    if keyJustPressed('right') and maxMisses ~= 0 then
        maxMisses = maxMisses - 1
        setProperty('arrow.x', getProperty('arrow.x') + 125)
        playSound('hoverSus')
    end

    if keyJustPressed('left') and maxMisses ~= 5 then
        maxMisses = maxMisses + 1
        setProperty('arrow.x', getProperty('arrow.x') - 125)
        playSound('hoverSus')
    end

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
            if fancyGameOver then
               setProperty('camHUD.visible', false)
               setProperty('camGame.visible', false)
               cameraFlash('camOther', 'FF0000', 1)
               playSound('amongkill')
            end
        end
    end
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
        if misses > 30 then
            setProperty('health', 0)
        end
        setTextString('scoreTxt', 'Score: ' ..score..' | Combo Breaks: '..misses..' / 30 | Accuracy: '..curAcc..ratingFC)
    end

    if mechanics then
         setTextString('scoreTxt', 'Score: '..score..' | Misses: '..misses..' / '..maxMisses..' | Rating: '..ratingName..' ('..curAcc..') - | '..ratingFC)
        if impostorHUD then
            setTextString('scoreTxt', 'Score: ' ..score..' | Combo Breaks: '..misses..' / '..maxMisses..' | Accuracy: ' ..curAcc..ratingFC)
        end
    end
end

function onGameOverStart()
    if fancyGameOver then
	    makeLuaSprite('dad', '')
	    makeGraphic('dad', 1280, 720, '820001')
	    setObjectCamera("dad", "camOther")
	    scaleObject('dad', 5, 5)
	    addLuaSprite('dad', true)
        screenCenter("dad", "x")
	    screenCenter("dad", "y")

	    makeLuaText('ded', 'DEFEAT', 1000)
	    setTextSize("ded", 100)
	    setTextAlignment("ded", "center")
	    setObjectCamera("ded", "camOther")
        addLuaText("ded")
        setProperty('ded.borderSize', 3)
        setTextColor('ded', 'FF0000')
	    screenCenter("ded", "x")
	    screenCenter("ded", "y")

	    makeLuaText('try', 'REJOIN?', 1000)
	    setTextSize("try", 75)
     	setTextAlignment("try", "center")
    	setObjectCamera("try", "camOther")
        addLuaText("try")
        setProperty('try.borderSize', 1.5)
        setTextColor('try', '00FFFF')
    	screenCenter("try", "x")
        setProperty('try.y', getProperty('ded.y') + 200)
    end
end

function onGameOverConfirm()
    if fancyGameOver then
        if keyJustPressed('accept') then
           cameraFlash('camOther', '00FFFF', 1)
           makeGraphic('dad', 1280, 720, '008494')
           setProperty('ded.visible', false)
           setTextString('try', 'RECONNECTING...')
           setProperty('try.borderSize', 3)
           screenCenter("try", "y")
           setTextSize("try", 100)
        end
    end
end