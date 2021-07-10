function createBlip(pos, label, sprite, display, scale, colour)
    local ok, rule, error = validate({
        [RULE_VECTOR3] = pos,
        [RULE_STRING] = label,
        [RULE_NUMBER] = sprite,
        [RULE_NUMBER] = display,
        [RULE_NUMBER] = scale,
        [RULE_NUMBER] = colour,
    })

    if not ok then
        dprint('Cannot create blip! Error: %s', error)
        return
    end

    local blip = AddBlipForCoord(pos.x, pos.y, pos.z)

    SetBlipSprite (blip, tonumber(sprite))
    SetBlipDisplay(blip, tonumber(display))
    SetBlipScale  (blip, tonumber(scale))
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, tonumber(colour))

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(label)
    EndTextCommandSetBlipName(blip)

    return blip
end

function removeBlip(blip)
    if DoesBlipExist(blip) then
        RemoveBlip(blip)
    end
end
