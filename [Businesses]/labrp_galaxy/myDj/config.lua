Config = {}
Translation = {}

Translation = {
    ['de'] = {
        ['DJ_interact'] = 'Drücke ~g~E~s~, um auf das DJ Pult zuzugreifen',
        ['title_does_not_exist'] = '~r~Dieser Titel existiert nicht!',
    },

    ['en'] = {
        ['DJ_interact'] = 'Press ~g~E~s~, to access the DJ desk',
        ['title_does_not_exist'] = '~r~This title does not exist!',
    }
}

Config.Locale = 'en'

Config.useESX = true -- can not be disabled without changing the callbacks
Config.enableCommand = false

Config.enableMarker = true -- purple marker at the DJ stations

Config.DJPositions = {
    {
        name = 'galaxy',
        pos = vector3(376.1671, 275.6176, 92.39929),
        requiredJob = nil, 
        range = 30.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },

    {
        name = 'laser',
        pos = vector3(-1151.895, -1241.341, -79.97437),
        requiredJob = nil, 
        range = 40.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },

    {
        name = 'steve',
        pos = vector3(-291.5341, -731.0769, 130.4293),
        requiredJob = nil, 
        range = 17.5, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },

    {
        name = 'ballas',
        pos = vector3(137.9077, -1933.332, 15.96851),
        requiredJob = nil, 
        range = 17.5, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },

    {
        name = 'grovecustoms',
        pos = vector3(-104.7297, -1796.967, 33.00366),
        requiredJob = nil, 
        range = 35.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    }
    --{name = 'bahama', pos = vector3(-1381.01, -616.17, 31.5), requiredJob = 'DJ', range = 25.0}
}