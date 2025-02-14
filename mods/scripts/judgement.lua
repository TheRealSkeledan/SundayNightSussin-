local totalScore = 0

local minusInt = 0
local byebye = false

function onCreatePost()
    setProperty("health", 2)
    
    makeLuaText("judgeText", "SICK!!", 0, 0.0, 0.0)
    setTextSize("judgeText", 44)
    setTextBorder("judgeText", 2, "000000")
    setTextAlignment("judgeText", 'center')
    setTextFont("judgeText", "vcr.ttf")
    addLuaText("judgeText")
    
    makeLuaText("comboText", "100", 0, 0.0, 0.0)
    setTextSize("comboText", 33)
    setTextBorder("comboText", 2, "000000")
    setTextAlignment("comboText", 'center')
    setTextFont("comboText", "vcr.ttf")
    addLuaText("comboText")

    setProperty("judgeText.alpha", 0)
    setProperty("comboText.alpha", 0)

    setPropertyFromClass("PlayState", "showCombo", false)

end

function onUpdatePost(elapsed)
    setProperty("judgeText.x", screenWidth / 2 - getProperty("judgeText.width") / 2)
    setProperty("comboText.x", screenWidth / 2 - getProperty("comboText.width") / 2)

    if byebye then
        minusInt = minusInt + 1
        if getProperty("judgeText.text") == "VOID" then
            setTextString("comboText", getMisses() - minusInt * -getMisses() / -framerate)
        else
            setTextString("comboText", getProperty("combo") - minusInt * -getProperty("combo") / -framerate)
        end
        
    else
        if getProperty("judgeText.text") == "VOID" then
            setTextString("comboText", getMisses())
        else
            setTextString("comboText", getProperty("combo"))
        end
        minusInt = 0
    end
    
    if getProperty("judgeText.text") == "PERFECT!!" then
        setTextColor("judgeText", string.format('%x', (getProperty('dad.healthColorArray')[1] * 0x10000) + (getProperty('dad.healthColorArray')[2] * 0x100) + getProperty('dad.healthColorArray')[3]))
        setTextColor("comboText", string.format('%x', (getProperty('dad.healthColorArray')[1] * 0x10000) + (getProperty('dad.healthColorArray')[2] * 0x100) + getProperty('dad.healthColorArray')[3]))
    elseif getProperty("judgeText.text") == "GOOD" then
        setTextColor("judgeText", "24c57f")
        setTextColor("comboText", "FFFFFF")
    elseif getProperty("judgeText.text") == "FAILURE..." then
        setTextColor("judgeText", "ad2410")
        setTextColor("comboText", "FFFFFF")
    elseif getProperty("judgeText.text") == "VOID" then
        setTextColor("judgeText", "8b00ff")
        setTextColor("comboText", "ff0000")
    end
    if getProperty('health') < 0.4 then
        setTextColor("judgeText", "880000")
        setTextColor("comboText", "880000")
    end

    if downscroll then
        setProperty("judgeText.y", 500)
    else
        setProperty("judgeText.y", 180)
    end
    setProperty("comboText.y", getProperty("judgeText.y") + 60)
end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
    byebye = false
    health = getProperty("health")
    health = health - 0.6
    setTextString("judgeText", "VOID")

    setTextColor("judgeText", "FF0000")
    setTextColor("comboText", "FF0000")

    setProperty("judgeText.alpha", 1)
    setProperty("comboText.alpha", 1)

    cancelTween("rTta")
    cancelTween("tsTta")
    cancelTween("cTta")
    cancelTween("ratingVisiske")

    setProperty("judgeText.scale.x", 1.2)
    doTweenX("rTtsx", "judgeText.scale", 1, 0.45 * getProperty("playbackRate"), "")
    setProperty("comboText.scale.x", 1.2)
    doTweenX("cTtsx", "comboText.scale", 1, 0.45 * getProperty("playbackRate"), "")

    setProperty("judgeText.scale.y", 1.2)
    doTweenY("rTtsy", "judgeText.scale", 1, 0.45 * getProperty("playbackRate"), "")
    setProperty("comboText.scale.y", 1.2)
    doTweenY("cTtsy", "comboText.scale", 1, 0.45 * getProperty("playbackRate"), "")

    doTweenY("judgeTextTween", "judgeText", getProperty("judgeText.y") - objWidth, 1, "expoOut")
    doTweenY("comboTextTween", "comboText", getProperty("comboText.y") - objWidth, 1, "expoOut")
    
    cancelTimer("byebye")
    runTimer("byebye", 3 / 2 * getProperty("playbackRate"))
    
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    byebye = false
    setTextColor("judgeText", "FFFFFF")
    setTextColor("comboText", "FFFFFF")

    setProperty("judgeText.alpha", 1)
    setProperty("comboText.alpha", 1)

    cancelTween("rTta")
    cancelTween("tsTta")
    cancelTween("cTta")
    cancelTween("ratingVisiske")

    if getPropertyFromGroup("notes", membersIndex, "rating") == "sick" then
        setTextString("judgeText", "PERFECT!!")
    end
    if getPropertyFromGroup("notes", membersIndex, "rating") == "good" then
        setTextString("judgeText", "GOOD")
    end
    if getPropertyFromGroup("notes", membersIndex, "rating") == "bad" then
        setTextString("judgeText", "FAILURE...")
    end
    if getPropertyFromGroup("notes", membersIndex, "rating") == "shit" then
        setTextString("judgeText", "DEGENERATE")
        setTextColor("judgeText", "4e735c")
        setTextColor("comboText", "4e735c")
    end
    if getProperty('health') < 0.4 then
        setTextString("judgeText", "LOW HEALTH")
        setTextColor("judgeText", "ff0100")
        setTextColor("comboText", "ff0100")
    end

    
    
    if not isSustainNote then
        setProperty("judgeText.scale.x", 1.2)
        doTweenX("rTtsx", "judgeText.scale", 1, 0.45 * getProperty("playbackRate"), "")
        setProperty("comboText.scale.x", 1.2)
        doTweenX("cTtsx", "comboText.scale", 1, 0.45 * getProperty("playbackRate"), "")

        setProperty("judgeText.scale.y", 1.2)
        doTweenY("rTtsy", "judgeText.scale", 1, 0.45 * getProperty("playbackRate"), "")
        setProperty("comboText.scale.y", 1.2)
        doTweenY("cTtsy", "comboText.scale", 1, 0.45 * getProperty("playbackRate"), "")
    end
        
    cancelTimer("byebye")
    runTimer("byebye", 3 / 2 * getProperty("playbackRate"), 1)

end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "ratingVisiske" then
        if getProperty("judgeText.visible") == false then
            setProperty("judgeText.visible", true)
        else
            setProperty("judgeText.visible", false)
            
            setProperty("judgeText.alpha", 0)
            setProperty("comboText.alpha", 0)
        end
    end
end

function onTweenCompleted(tag)
    if tag == "rTta" then
        byebye = false

        minusInt = 0
    end
end