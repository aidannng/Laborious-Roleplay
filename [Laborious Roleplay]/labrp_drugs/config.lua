Config = {}

Config.BlackMoney = true -- for hold corner system


Config.Corners = {

    [1] = {
        coord = vector3(305.6176, -2005.793, 20.5011),
        items = {"packagedweed"},
        radius = 30.0,
        minMoney = 450,
        maxMoney = 750,
        spawnpoints = {
            vector3(321.1385, -1988.255, 22.74219),
            vector3(331.0154, -2020.431, 21.69739),
        }
    },
    [2] = {
        coord = vector3(-36.81758, -1808.98, 26.46594),
        items = {"packagedweed"},
        radius = 30.0,
        minMoney = 450,
        maxMoney = 750,
        spawnpoints = {
            vector3(-22.25934, -1789.912, 27.76343),
            vector3(-56.57142, -1789.49, 27.69592),
        },
    },
    [3] = {
        coord = vector3(193.7407, -1764.119, 29.29675),
        items = {"packagedweed"},
        radius = 30.0,
        minMoney = 450,
        maxMoney = 750,
        spawnpoints = {
            vector3(224.822, -1746.303, 29.26306),
            vector3(212.2286, -1780.484, 29.12817),
        },
    }

}

Config.ItemsName = {

    ["packagedweed"] = "Packaged Weed",
    ["packagedmeth"] = "Packaged Meth",
    ["packagedcoca"] = "Packaged Cocain",

}


Config.methLab = {

    entry = { -- DON'T TOUCH!
        coord = vector3(809.89, -490.92, 0), 
        intcoord = vector3(997.48, -3200.8, -36.4), 
        entryheading = 194.3,
        intheading = 250.19,
        text = "[E] Use Lab Card", 
        requiredItem = true,
        item = "labcard", 
    },
    exit = { -- DON'T TOUCH!
        intcoord = vector3(997.16, -3200.64, -36.4), 
        coord = vector3(809.89, -490.92, 30.63), 
        text = "[E] Exit",
        heading = 90.0, 
    },
    cookZone = { -- DON'T TOUCH!
        coord = vector3(593.7495, -426.6198, 18.1084),
        text = "[E] Cook",
        startingCoord = vector3(594.8307, -426.356, 17.61975),
        startingText = "[E] Light the oven",
        methMinCount = 5,
        methMaksCount = 10,
        takeMethText = "[E] Pick up "
    },
    packageZone = { -- DON'T TOUCH!
        coord = vector3(602.7297, -416.967, 17.61975),
        text = "[E] Package meth",
        takeMethText = "[E] Pick up",
    }

}

Config.Coca = {

    entry = { -- DON'T TOUCH!
        coord = vector3(1004.6, -1572.88, 0), 
        intcoord = vector3(1088.56, -3188.12, -39.0), 
        intheading = 183.55,
        text = "[E] Enter", 
    },
    exit = { -- DON'T TOUCH!
        intcoord = vector3(1088.72, -3187.8, -39.0), 
        coord = vector3(1004.6, -1572.88, 0), 
        text = "[E] Exit",
        heading = 90.0, 
    }, 
    gatheringZone = {
        coords = {
            [1] = {coord = vector3(1390.207, -2090.809, 45.48938), heading = 183.39, rotx = -1.91, roty = -0.32, rotz = -0.60},
            [2] = {coord = vector3(1397.604, -2089.569, 45.48938), heading = 183.39, rotx = -1.91, roty = -0.32, rotz = -0.60},
            [3] = {coord = vector3(1394.796, -2096.176, 45.48938), heading = 183.39, rotx = -2.0, roty = -0.32, rotz = -0.60},
            [4] = {coord = vector3(1401.969, -2094.739, 45.48938), heading = 183.39, rotx = -2.0, roty = -0.32, rotz = -0.60},
            [5] = {coord = vector3(1398.884, -2097.363, 45.48938), heading = 183.39, rotx = -2.0, roty = -0.32, rotz = -0.60},
        },
        text = "[E] Gathering Coca",
        takeCoca = "[E] Pick up",
        count = 1, 
    },
    packageZone = {
        coord = vector3(1401.363, -2085.64, 45.48938),
        text = "[E] Package Coca",
        takePackCoc = "[E] Pick up",
        heading = 300.34,
        count = 1, 
    }
}

Config.Weed = {
    entry = {
        coord = vector3(951.24, -1711.76, 0),
        intcoord = vector3(1066.0, -3183.48, -39.16),
        intheading = 88.2,
        text = "[E] Enter",
    },
    exit = {
        intcoord = vector3(1066.0, -3183.48, -39.16),
        coord = vector3(951.24, -1711.76, 0),
        heading = 254.92,
        text = "[E] Exit",
    },
    gatheringZone = {
        coords = {
            [1] = {coord = vector3(2857.174, 4455.363, 41.31067), heading = 260.81},
            [2] = {coord = vector3(2858.993, 4450.048, 41.31067), heading = 260.81},
            [3] = {coord = vector3(2855.96, 4459.055, 41.31067), heading = 260.81},
            [4] = {coord = vector3(2865.732, 4453.728, 41.31067), heading = 260.81},
            [5] = {coord = vector3(2864.347, 4457.578, 41.31067), heading = 260.81},
            [6] = {coord = vector3(2863.213, 4461.468, 41.31067), heading = 260.81},
            [7] = {coord = vector3(2868.224, 4463.064, 41.31067), heading = 260.81},
            [8] = {coord = vector3(2870.004, 4457.868, 41.31067), heading = 260.81},
            [9] = {coord = vector3(2871.125, 4454.004, 41.31067), heading = 260.81},
        },
        text = "[E] Gathering Weed",
        count = 1,
    },
    packageZone = {
        coords = {
            [1] = {coord =  vector3(2860.47, 4463.921, 41.31067), heading = 125.00, rotx = -0.60, roty = 0.0, rotz = -1.4},
            [2] = {coord = vector3(2863.015, 4464.686, 41.31067), heading = 125.00, rotx = -0.60, roty = 0.0, rotz = -1.4},
            [3] = {coord = vector3(2866.352, 4465.767, 41.31067), heading = 125.00, rotx = -0.60, roty = 0.0, rotz = -1.4},
        },
        text = "[E] Place Buds",
        count = 1, 
        takeText = "[E] Package Weed",
    }
}


Config.Laundry = {
    entry = {
        coord = vector3(84.04, -1551.96, -100.6),
        intcoord = vector3(1138.0, -3198.96, -39.68),
        intheading = 11.64,
        text = "[E] Enter",
    },
    exit = {
        intcoord = vector3(1138.0, -3198.96, -39.68),
        coord = vector3(83.64, -1551.64, 29.6),
        heading = 46.85,
        text = "[E] Exit",
    },
    cuttingZone = {
        coords = vector3(1122.24, -3197.88, -40.4), 
        heading = 179.46,
        text = "[E] Cut the Money",
        countmin = 100,
        countmax = 200,
    },
    packageZone = {
        coord = vector3(1120.12, -3197.88, -39.92), 
        heading = 180.93,
        text = "[E] Turn into Banknote", 
    },
    washingZone = {
    coord = vector3(1122.32, -3194.6, -40.4), 
    heading = 346.76,
    text = "[E] Wash Money", 
}

}