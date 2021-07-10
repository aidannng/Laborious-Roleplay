RegisterCommand('rad', function()
    showMenu = true
    local enabledMenus = {}
    for _, menuConfig in ipairs(rootMenuConfig) do
        if menuConfig:enableMenu() then
            local dataElements = {}
            local hasSubMenus = false
            if menuConfig.subMenus ~= nil and #menuConfig.subMenus > 0 then
                hasSubMenus = true
                local previousMenu = dataElements
                local currentElement = {}
                for i = 1, #menuConfig.subMenus do
                    currentElement[#currentElement+1] = newSubMenus[menuConfig.subMenus[i]]
                    currentElement[#currentElement].id = menuConfig.subMenus[i]
                    currentElement[#currentElement].enableMenu = nil

                    if i % MAX_MENU_ITEMS == 0 and i < (#menuConfig.subMenus - 1) then
                        previousMenu[MAX_MENU_ITEMS + 1] = {
                            id = "_more",
                            title = "More",
                            icon = "#more",
                            items = currentElement
                        }
                        previousMenu = currentElement
                        currentElement = {}
                    end
                    --::continue::
                end
                if #currentElement > 0 then
                    previousMenu[MAX_MENU_ITEMS + 1] = {
                        id = "_more",
                        title = "More",
                        icon = "#more",
                        items = currentElement
                    }
                end
                dataElements = dataElements[MAX_MENU_ITEMS + 1].items

            end
            enabledMenus[#enabledMenus+1] = {
                id = menuConfig.id,
                title = menuConfig.displayName,
                functionName = menuConfig.functionName,
                icon = menuConfig.icon,
            }
            if hasSubMenus then
                enabledMenus[#enabledMenus].items = dataElements
            end
        end
    end
    SendNUIMessage({
        state = "show",
        resourceName = GetCurrentResourceName(),
        data = enabledMenus,
        menuKeyBind = keyBind
    })
    SetCursorLocation(0.5, 0.5)
    SetNuiFocus(true, true)

    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
end, false)

RegisterKeyMapping('rad', 'Shows radial menu', 'keyboard', 'H')