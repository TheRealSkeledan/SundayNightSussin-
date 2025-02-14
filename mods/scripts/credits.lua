local offsetX = 10
local offsetY = 500
local objWidth = 500

local options = { -- Any options

    ["noCredits"] = false,
    ["showCreditsUnlisted"] = true,

}

local songData = {
    ['prologue'] = {
        ["songName"] = "Prologue",
        ["length"] = 5,
        ["boxColor"] = "#000000",
        ["credits"] = {
            ["Composer"] = "Skeledan",
            ["Charter"] = "Skeledan",
        },
    },
    ['another-foe'] = {
        ["songName"] = "Another Foe",
        ["length"] = 5,
        ["boxColor"] = "#000000",
        ["credits"] = {
            ["Composer"] = "Skeledan",
            ["Charter"] = "E1000MC",
        },
    },
    ['funki-beanie'] = {
        ["songName"] = "Funki' Beanie",
        ["length"] = 6,
        ["boxColor"] = "#000000",
        ["credits"] = {
            ["Composer"] = "Skeledan",
            ["Charter"] = "Skeledan",
        },
    },
    ['suspicious-actions'] = {
        ["songName"] = "Suspicious Actions",
        ["length"] = 7,
        ["boxColor"] = "#000000",
        ["credits"] = {
            ["Composer"] = "Skeledan",
            ["Charter"] = "Skeledan",
        },
    },
    ['suspicious-actions-old'] = {
        ["songName"] = "Suspicious Actions Old",
        ["length"] = 10,
        ["boxColor"] = "#000000",
        ["credits"] = {
            ["Composer"] = "Skeledan",
            ["Charter"] = "Skeledan",
        },
    },
    ['voided'] = {
        ["songName"] = "Voided",
        ["length"] = 5,
        ["boxColor"] = "#000000",
        ["credits"] = {
            ["Composer"] = "Zep",
            ["Charter"] = "Skeledan",
        },
    },
    ['epic-slaughter'] = {
        ["songName"] = "Epic Slaughter",
        ["length"] = 8,
        ["boxColor"] = "#000000",
        ["credits"] = {
            ["Composer"] = "Skeledan",
            ["Charter"] = "Skeledan",
        },
    },
    ['interfectorem'] = {
        ["songName"] = "Interfectorem",
        ['length'] = 8,
        ['boxColor'] = "#000000",
        ["credits"] = {
            ["Composer"] = "Skeledan",
            ["Charter"] = "[Auto-Gen]",
        },
    },
    ['polychrome'] = {
        ["songName"] = "Polychrome",
        ['length'] = 8,
        ['boxColor'] = "#000000",
        ["credits"] = {
            ["Composer"] = "Komotaso",
            ["Charter"] = "OG",
        },
    },
    ["finished-tasks"] = {
        ["songName"] = "Finished Tasks",
        ["length"] = 8,
        ['boxColor'] = "#000000",
        ["credits"] = {
            ["Composer"] = "Skeledan",
            ["Charter"] = "Skeledan",
        }
    }

}

function createBox(songTable) -- Creates the main box container
    if songTable then
        makeLuaSprite('creditContainer', 'empty', 0 - objWidth, offsetY)
        makeGraphic('creditContainer', objWidth, 175, songTable["boxColor"])
        setObjectCamera('creditContainer', 'other')
        setProperty("creditContainer.alpha", 0.7)
        addLuaSprite('creditContainer', true)
    else
        makeLuaSprite('creditContainer', 'empty', 0 - objWidth, offsetY)
        makeGraphic('creditContainer', objWidth, 175, "#000000")
        setObjectCamera('creditContainer', 'other')
        setProperty("creditContainer.alpha", 0.7)
        addLuaSprite('creditContainer', true)
    end
end

function createTitle(songTable) -- Creates the song title

    if songTable then

        if not options["noCredits"] then
            makeLuaText('songTitle', songTable["songName"], objWidth, offsetX - objWidth, offsetY+5)
            setTextSize('songTitle', 45)
            setTextAlignment('songTitle', 'left')
            setObjectCamera('songTitle', 'other')
            setTextColor('songTitle', string.format('%x', (getProperty('dad.healthColorArray')[1] * 0x10000) + (getProperty('dad.healthColorArray')[2] * 0x100) + getProperty('dad.healthColorArray')[3]))
            addLuaText('songTitle', true)
        else
            makeLuaText('songTitle', songTable["songName"], objWidth, offsetX - objWidth, offsetY+95)
            setTextSize('songTitle', 45)
            setTextAlignment('songTitle', 'left')
            setObjectCamera('songTitle', 'other')
            setTextColor('songTitle', string.format('%x', (getProperty('dad.healthColorArray')[1] * 0x10000) + (getProperty('dad.healthColorArray')[2] * 0x100) + getProperty('dad.healthColorArray')[3]))
            addLuaText('songTitle', true)
        end
    else
        makeLuaText('songTitle', songName, objWidth, offsetX - objWidth, offsetY+95)
        setTextSize('songTitle', 45)
        setTextAlignment('songTitle', 'left')
        setObjectCamera('songTitle', 'other')
        setTextColor('songTitle', string.format('%x', (getProperty('dad.healthColorArray')[1] * 0x10000) + (getProperty('dad.healthColorArray')[2] * 0x100) + getProperty('dad.healthColorArray')[3]))
        addLuaText('songTitle', true)
    end

end


function getTableLen(creditsTable)
    local counter = 0
    for i, v in pairs (creditsTable) do
        counter = counter + 1
    end
    return counter
end

function onCreatePost()
    songTableMAIN = songData[songName]

    if songTableMAIN then
        createBox(songTableMAIN)
        createTitle(songTableMAIN)

        local creditTable = songTableMAIN["credits"]

        if not options["noCredits"] then
            local ySpacing = 115 / getTableLen(creditTable)

            if getTableLen(creditTable) == 1 then ySpacing = 70 end

            local counter = 1
            for i, v in pairs(creditTable) do
                local labelName = "credit"..i
                makeLuaText(labelName,i .. ": "..v, objWidth, offsetX - objWidth, offsetY + ySpacing*counter+25)
                setTextSize(labelName, 40 - getTableLen(creditTable) * 5)
                setTextAlignment(labelName, "left")
                setObjectCamera(labelName, "other")
                setTextColor(labelName, string.format('%x', (getProperty('dad.healthColorArray')[1] * 0x10000) + (getProperty('dad.healthColorArray')[2] * 0x100) + getProperty('dad.healthColorArray')[3]))
                addLuaText(labelName, true)
                counter = counter + 1
            end
        else
            makeLuaText('songPlaying', "Now playing:", objWidth, offsetX - objWidth, offsetY+25)
            setTextSize('songPlaying', 30)
            setTextAlignment('songPlaying', 'left')
            setObjectCamera('songPlaying', 'other')
            setTextColor('songPlaying', string.format('%x', (getProperty('dad.healthColorArray')[1] * 0x10000) + (getProperty('dad.healthColorArray')[2] * 0x100) + getProperty('dad.healthColorArray')[3]))
            addLuaText('songPlaying', true)
        end
    elseif options["showCreditsUnlisted"] then
        createBox(songTableMAIN)
        makeLuaText('songPlaying', "Now playing:", objWidth, offsetX - objWidth, offsetY+25)
        setTextSize('songPlaying', 30)
        setTextAlignment('songPlaying', 'left')
        setObjectCamera('songPlaying', 'other')
        setTextColor('songPlaying', "#FFFFFF")
        addLuaText('songPlaying', true)

       createTitle()
    end
end

function onSongStart()
    doTweenX("creditContainerTween", "creditContainer", getProperty("creditContainer.x") + objWidth, 1, "expoOut")
    doTweenX("songTitleTween", "songTitle", getProperty("songTitle.x") + objWidth, 1, "expoOut")

    if songTableMAIN then

        local creditTable = songTableMAIN["credits"]

        if not options["noCredits"] then
            local counter = 1
            for i, v in pairs(creditTable) do
                doTweenX("credit"..i.."Tween", "credit"..i, getProperty("credit"..i..".x") + objWidth, 1, "expoOut")
                counter = counter + 1
            end

        else
            doTweenX("songPlayingTween", "songPlaying", getProperty("songPlaying.x") + objWidth, 1, "expoOut")
        end
        if songTableMAIN then
            runTimer("creditDisplay", songTableMAIN["length"])
        else
            runTimer("creditDisplay", 5)
        end
    elseif options["showCreditsUnlisted"] then
        doTweenX("songPlayingTween", "songPlaying", getProperty("songPlaying.x") + objWidth, 1, "expoOut")
        runTimer("creditDisplay", 5)
    end
end

function onTimerCompleted(timerName)
    if songTableMAIN then
        if timerName == "creditDisplay" then
            doTweenX("creditContainerTween", "creditContainer", getProperty("creditContainer.x") - objWidth, 1, "expoOut")
            doTweenX("songTitleTween", "songTitle", getProperty("songTitle.x") - objWidth, 1, "expoOut")

            local creditTable = songTableMAIN["credits"]

            if not options["noCredits"] then
                local counter = 1
                for i, v in pairs(creditTable) do
                    doTweenX("credit"..i.."Tween", "credit"..i, getProperty("credit"..i..".x") - objWidth, 1, "expoOut")
                    counter = counter + 1
                end
    
            else
                doTweenX("songPlayingTween", "songPlaying", getProperty("songPlaying.x") - objWidth, 1, "expoOut")
            end

        end
    elseif options["showCreditsUnlisted"] then
        doTweenX("creditContainerTween", "creditContainer", getProperty("creditContainer.x") - objWidth, 1, "expoOut")
        doTweenX("songTitleTween", "songTitle", getProperty("songTitle.x") - objWidth, 1, "expoOut")
        doTweenX("songPlayingTween", "songPlaying", getProperty("songPlaying.x") - objWidth, 1, "expoOut")
    end
end

luaDebugMode = true