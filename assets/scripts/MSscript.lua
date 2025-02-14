local hitAlpha = 0
function onCreatePost()
    makeLuaText('HitTimeLabel', '', 200, 850, downscroll and 530 or 170)
    setTextSize('HitTimeLabel', 20)
    addLuaText('HitTimeLabel')
end
function onUpdatePost(dt)
    hitAlpha = hitAlpha - hitAlpha * math.min(dt * 8, 1)
    setProperty('HitTimeLabel.alpha', hitAlpha)
end
function goodNoteHit(i, d, t, s)
    if s then return end
    setTextString('HitTimeLabel', (math.floor((getPropertyFromGroup('notes', i, 'strumTime') - getSongPosition()) * 100) * 0.01) .. ' ms')
    hitAlpha = 16
end