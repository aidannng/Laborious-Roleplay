Config = {}
Config.License = '237bf0020850a96db8fb569b1b00c3c9'
Config.Locale = 'en'
Config.Debug = false
Config.ESX = 'esx:getSharedObject'
Config.ESXCallbacks = {
    ['esx_datastore:getDataStore'] = 'esx_datastore:getDataStore',
    ['esx:playerLoaded'] = 'esx:playerLoaded',
    ['esx:setJob'] = 'esx:setJob',
    ['esx_addonaccount:getSharedAccount'] = 'esx_addonaccount:getSharedAccount',
    ['skinchanger:getSkin'] = 'skinchanger:getSkin',
    ['skinchanger:loadClothes'] = 'skinchanger:loadClothes',
    ['esx_skin:setLastSkin'] = 'esx_skin:setLastSkin',
    ['esx_skin:save'] = 'esx_skin:save',
    ['skinchanger:loadSkin'] = 'skinchanger:loadSkin',
}
Config.WaitBeforeOpenMenu = 200
Config.DatastoreName = 'clothing'
Config.CheckPlayerPosition = 2000
Config.NearObjectDistance = 50
Config.GlobalBlacklist = {
    ['hats'] = {
        ['helmet_1'] = {
            ['male'] = {}, --Specific sex blacklist
            ['female'] = {},
        }
    },
    ['bags'] = {
        --Numbers of blacklisted items for bags for both sex
    }
}
Config.GlobalWhitelist = { --Same as blacklist you can do with whitelist
    --['hats'] = {
    --    ['helmet_1'] = {
    --        ['male'] = {}, --Specific sex blacklist
    --        ['female'] = {},
    --    }
    --},
    --['bags'] = {
    --    --Numbers of blacklisted items for bags for both sex
    --}
}
--Where player can change his clothes at store or anywhere
Config.ChangePoint = {
    title = 'Change clothes', -- menu title
    label = 'Change room\n~r~[E]~w~', --3D text
    help = 'Press ~INPUT_CONTEXT~ to open change room menu',
    menualign = 'center',
    renderDistance = 5.0,
    size = 0.5,
    points = {
        vector3(429.75, -811.41, 29.49),
        vector3(71.19, -1387.76, 29.38),
        vector3(-819.66, -1067.17, 11.33),
        vector3(3.63, 6505.58, 31.88),
        vector3(1699.01, 4817.92, 42.06),
        vector3(1201.89, 2714.5, 38.22),
        vector3(-1100.45, 2717.04, 19.11),
        vector3(-703.51, -151.62, 37.42),
        vector3(-168.3, -299.38, 39.73),
        vector3(-1447.35, -242.73, 49.82),
        vector3(118.18, -232.61, 54.56),
        vector3(617.72, 2773.41, 42.09),
        vector3(-1182.54, -765.13, 17.33),
        vector3(-3178.37, 1035.77, 20.86),
        vector3(-571.05, -198.66, 42.76),
        vector3(365.2, 4819.63, -59),
        vector3(151.01, -768.22, 50.14),
        vector3(461.55,-996.48,30.69), --PD
        vector3(-342.6593, -160.4044, 44.57947), -- LSC
        vector3(1399.345, 1164, 114.3209), -- Mafia
        vector3(986.2154, -133.7275, 78.88574), -- Big Dogs
        vector3(128.5714, -755.8417, 242.1436), -- FBI
        vector3(393.5341, 279.3231, 94.97729), -- Galaxy Nightclub
        vector3(-54.31648, -1083.864, 26.36487), -- PDM
        vector3(-162.5275, 900.3561, 233.4491), -- Sonora Cartel 
        vector3(-269.9077, -731.3538, 125.4586), -- Steve's Penthouse
        vector3(-280.4044, -722.0703, 125.4586), -- Steve's Penthouse daddy plasmas room
        vector3(-103.6088, -1782.462, 32.21167), -- Ballas Mech Shop
        vector3(124.2462, -1959.31, 15.21021), -- Ballas HQ 
        vector3(931.1736, -1461.059, 33.61023), -- NT Warehouse
        vector3(44.71649, -2573.868, 6.296753), -- NH HQ
    }
}
Config.Stores = {
    {
        position = vector3(422.86,-808.31,29.49),
        label = 'Binco - Clothes',
        sprite = 73, -- to disable blip make this -1
        color = 1,
        sections = {
            boots = {
                pos = vector3(419.55,-802.77,29.49),
                label = '👞',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Shoes',
                        name = 'shoes_1',
                        from = -1,
                        to = 88,
                        current = 1,
                        price = 150,
                        reset = {
                            'shoes_2'
                        },
                    },
                    {
                        label = 'Shoes color',
                        name = 'shoes_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 354.66
                },
                size = 1.2, --Default 1
                renderDistance = 10.0,
            },
            hats = {
                pos = vector3(427.51,-798.89,29.49),
                label = '👒 ',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Hats',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hat color',
                        name = 'helmet_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 174.66
                }
            },
            pants = {
                pos = vector3(430.58,-800.13,29.5),
                label = '👖',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Pants',
                        name = 'pants_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Pants color',
                        name = 'pants_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 86.66
                }
            },
            glasses = {
                pos = vector3(425.69,-808.11,29.49),
                label = '👓',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                        blacklist = {
                            26,27,
                        }
                    },
                    {
                        label = 'Glasses color',
                        name = 'glasses_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 100.66
                }
            },
            tshirt = {
                pos = vector3(425.41,-798.9,29.49),
                label = '👕',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt color',
                        name = 'tshirt_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Torso 1',
                        name = 'torso_1',
                        from = -1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,

                    },
                    {
                        label = 'Torso 2',
                        name = 'torso_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Bulletproof Vests',
                        name = 'bproof_1',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Bulletproof Vest Varities',
                        name = 'bproof_2',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Arms',
                        name = 'arms',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Chains',
                        name = 'chain_1',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Chain color',
                        name = 'chain_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 180.66
                }
            }
        }
    },
    {
        position = vector3(77.77,-1391.3,29.38),
        label = 'Binco - Clothes',
        sprite = 73,
        color = 59,

        sections = {
            boots = {
                pos = vector3(81.21,-1396.5,29.38),
                label = '👞',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Shoes',
                        name = 'shoes_1',
                        from = -1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Shoes color',
                        name = 'shoes_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 354.66
                }
            },
            hats = {
                pos = vector3(73.44,-1400.25,29.38),
                label = '👒 ',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Hats',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,

                    },
                    {
                        label = 'Hat color',
                        name = 'helmet_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 355.66
                }
            },
            pants = {
                pos = vector3(69.76,-1399.06,29.38),
                label = '👖',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Pants',
                        name = 'pants_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Pants color',
                        name = 'pants_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 275.66
                }
            },
            glasses = {
                pos = vector3(75.21,-1391.22,29.38),
                label = '👓',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                        blacklist = {
                            26,27,
                        }
                    },
                    {
                        label = 'Glasses color',
                        name = 'glasses_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 275.06
                }
            },
            tshirt = {
                pos = vector3(75.53,-1399.99,29.38),
                label = '👕',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt color',
                        name = 'tshirt_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Torso 1',
                        name = 'torso_1',
                        from = -1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,

                    },
                    {
                        label = 'Torso 2',
                        name = 'torso_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Bulletproof Vests',
                        name = 'bproof_1',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Bulletproof Vest Varities',
                        name = 'bproof_2',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Arms',
                        name = 'arms',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Chains',
                        name = 'chain_1',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Chain color',
                        name = 'chain_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 3.66
                }
            }
        }
    },
    {
        position = vector3(-715.03,-145.58,37.42),
        label = 'Ponsonbys - Clothes',
        sprite = 73,
        color = 59,

        sections = {
            boots = {
                pos = vector3(-715.03,-145.58,37.42),
                label = '👞',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Shoes',
                        name = 'shoes_1',
                        from = -1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Shoes color',
                        name = 'shoes_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 195.66
                }
            },
            pants = {
                pos = vector3(-712.93,-147.71,37.42),
                label = '👖',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Pants',
                        name = 'pants_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Pants color',
                        name = 'pants_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 130.66
                }
            },
            tshirt = {
                pos = vector3(-707.98,-161.21,37.42),
                label = '👕',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt color',
                        name = 'tshirt_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Torso 1',
                        name = 'torso_1',
                        from = -1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,

                    },
                    {
                        label = 'Torso 2',
                        name = 'torso_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Bulletproof Vests',
                        name = 'bproof_1',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Bulletproof Vest Varities',
                        name = 'bproof_2',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Arms',
                        name = 'arms',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Chains',
                        name = 'chain_1',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Chain color',
                        name = 'chain_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 23.66
                }
            }
        }
    },
    {
        position = vector3(-165.69,-311.55,39.73),
        label = 'Ponsonbys - Clothes',
        sprite = 73,
        color = 59,

        sections = {
            boots = {
                pos = vector3(-165.69,-311.55,39.73),
                label = '👞',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Shoes',
                        name = 'shoes_1',
                        from = -1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Shoes color',
                        name = 'shoes_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 331.66
                }
            },
            pants = {
                pos = vector3(-165.75,-308.54,39.73),
                label = '👖',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Pants',
                        name = 'pants_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Pants color',
                        name = 'pants_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 252.66
                }
            },
            tshirt = {
                pos = vector3(-158.68,-295.79,39.73),
                label = '👕',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt color',
                        name = 'tshirt_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Torso 1',
                        name = 'torso_1',
                        from = -1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,

                    },
                    {
                        label = 'Torso 2',
                        name = 'torso_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Bulletproof Vests',
                        name = 'bproof_1',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Bulletproof Vest Varities',
                        name = 'bproof_2',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Arms',
                        name = 'arms',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Chains',
                        name = 'chain_1',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Chain color',
                        name = 'chain_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 160.66
                }
            }
        }
    },
    {
        position = vector3(-822.42,-1080.5,11.33),
        label = 'Binco - Clothes',
        sprite = 73,
        color = 59,

        sections = {
            boots = {
                pos = vector3(-822.42,-1080.5,11.33),
                label = '👞',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Shoes',
                        name = 'shoes_1',
                        from = -1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Shoes color',
                        name = 'shoes_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 26.66
                }
            },
            hats = {
                pos = vector3(-829.79,-1075.68,11.33),
                label = '👒 ',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Hats',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,

                    },
                    {
                        label = 'Hat color',
                        name = 'helmet_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 299.66
                }
            },
            pants = {
                pos = vector3(-830.46,-1072.01,11.34),
                label = '👖',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Pants',
                        name = 'pants_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Pants color',
                        name = 'pants_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 203.66
                }
            },
            glasses = {
                pos = vector3(-821.0,-1072.71,11.33),
                label = '👓',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                        blacklist = {
                            26,27,
                        }
                    },
                    {
                        label = 'Glasses color',
                        name = 'glasses_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 210.25
                }
            },
            tshirt = {
                pos = vector3(-828.63,-1077.37,11.33),
                label = '👕',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt color',
                        name = 'tshirt_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Torso 1',
                        name = 'torso_1',
                        from = -1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,

                    },
                    {
                        label = 'Torso 2',
                        name = 'torso_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Bulletproof Vests',
                        name = 'bproof_1',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Bulletproof Vest Varities',
                        name = 'bproof_2',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Arms',
                        name = 'arms',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Chains',
                        name = 'chain_1',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Chain color',
                        name = 'chain_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 298.66
                }
            }
        }
    },
    {
        position = vector3(-1444.74,-230.44,49.81),
        label = 'Ponsonbys - Clothes',
        sprite = 73,
        color = 59,

        sections = {
            boots = {
                pos = vector3(-1444.74,-230.44,49.81),
                label = '👞',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Shoes',
                        name = 'shoes_1',
                        from = -1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Shoes color',
                        name = 'shoes_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 122.66
                }
            },
            pants = {
                pos = vector3(-1446.13,-233.26,49.81),
                label = '👖',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Pants',
                        name = 'pants_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Pants color',
                        name = 'pants_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 51.66
                }
            },
            tshirt = {
                pos = vector3(-1457.65,-242.21,49.81),
                label = '👕',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt color',
                        name = 'tshirt_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Torso 1',
                        name = 'torso_1',
                        from = -1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,

                    },
                    {
                        label = 'Torso 2',
                        name = 'torso_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Bulletproof Vests',
                        name = 'bproof_1',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Bulletproof Vest Varities',
                        name = 'bproof_2',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Arms',
                        name = 'arms',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Chains',
                        name = 'chain_1',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Chain color',
                        name = 'chain_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 317.66
                }
            }
        }
    },
    {
        position = vector3(3.3,6519.29,31.88),
        label = 'Binco - Clothes',
        sprite = 73,
        color = 59,

        sections = {
            boots = {
                pos = vector3(3.3,6519.29,31.88),
                label = '👞',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Shoes',
                        name = 'shoes_1',
                        from = -1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Shoes color',
                        name = 'shoes_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 224.66
                }
            },
            hats = {
                pos = vector3(11.62,6516.03,31.88),
                label = '👒 ',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Hats',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,

                    },
                    {
                        label = 'Hat color',
                        name = 'helmet_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 126.66
                }
            },
            pants = {
                pos = vector3(12.76,6512.48,31.89),
                label = '👖',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Pants',
                        name = 'pants_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Pants color',
                        name = 'pants_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 47.66
                }
            },
            glasses = {
                pos = vector3(3.74,6511.35,31.88),
                label = '👓',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                        blacklist = {
                            26,27,
                        }
                    },
                    {
                        label = 'Glasses color',
                        name = 'glasses_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 58.99
                }
            },
            tshirt = {
                pos = vector3(9.95,6517.47,31.88),
                label = '👕',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt color',
                        name = 'tshirt_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Torso 1',
                        name = 'torso_1',
                        from = -1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,

                    },
                    {
                        label = 'Torso 2',
                        name = 'torso_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Bulletproof Vests',
                        name = 'bproof_1',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Bulletproof Vest Varities',
                        name = 'bproof_2',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Arms',
                        name = 'arms',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Chains',
                        name = 'chain_1',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Chain color',
                        name = 'chain_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 129.66
                }
            }
        }
    },
    {
        position = vector3(119.08,-222.55,54.56),
        label = 'Suburban - Clothes',
        sprite = 73,
        color = 59,

        sections = {
            boots = {
                pos = vector3(119.08,-222.55,54.56),
                label = '👞',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Shoes',
                        name = 'shoes_1',
                        from = -1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Shoes color',
                        name = 'shoes_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 244.66
                }
            },
            hats = {
                pos = vector3(121.87,-221.85,54.56),
                label = '👒 ',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Hats',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,

                    },
                    {
                        label = 'Hat color',
                        name = 'helmet_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 252.66
                }
            },
            pants = {
                pos = vector3(122.99,-229.27,54.56),
                label = '👖',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Pants',
                        name = 'pants_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Pants color',
                        name = 'pants_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 341.66
                }
            },
            glasses = {
                pos = vector3(126.77,-221.2,54.56),
                label = '👓',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                        blacklist = {
                            26,27,
                        }
                    },
                    {
                        label = 'Glasses color',
                        name = 'glasses_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 37.99
                }
            },
            tshirt = {
                pos = vector3(121.91,-212.01,54.56),
                label = '👕',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt color',
                        name = 'tshirt_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Torso 1',
                        name = 'torso_1',
                        from = -1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,

                    },
                    {
                        label = 'Torso 2',
                        name = 'torso_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Bulletproof Vests',
                        name = 'bproof_1',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Bulletproof Vest Varities',
                        name = 'bproof_2',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Arms',
                        name = 'arms',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Chains',
                        name = 'chain_1',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Chain color',
                        name = 'chain_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 249.66
                }
            }
        }
    },
    {
        position = vector3(1687.45,4825.47,42.06),
        label = 'Binco - Clothes',
        sprite = 73,
        color = 59,

        sections = {
            boots = {
                pos = vector3(1687.45,4825.47,42.06),
                label = '👞',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Shoes',
                        name = 'shoes_1',
                        from = -1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Shoes color',
                        name = 'shoes_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 275.66
                }
            },
            hats = {
                pos = vector3(1694.85,4830.45,42.06),
                label = '👒 ',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Hats',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,

                    },
                    {
                        label = 'Hat color',
                        name = 'helmet_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 187.66
                }
            },
            pants = {
                pos = vector3(1698.32,4829.52,42.07),
                label = '👖',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Pants',
                        name = 'pants_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Pants color',
                        name = 'pants_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 95.66
                }
            },
            glasses = {
                pos = vector3(1694.12,4820.95,42.06),
                label = '👓',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                        blacklist = {
                            26,27,
                        }
                    },
                    {
                        label = 'Glasses color',
                        name = 'glasses_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 127.99
                }
            },
            tshirt = {
                pos = vector3(1692.77,4829.9,42.06),
                label = '👕',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt color',
                        name = 'tshirt_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Torso 1',
                        name = 'torso_1',
                        from = -1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,

                    },
                    {
                        label = 'Torso 2',
                        name = 'torso_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Bulletproof Vests',
                        name = 'bproof_1',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Bulletproof Vest Varities',
                        name = 'bproof_2',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Arms',
                        name = 'arms',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Chains',
                        name = 'chain_1',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Chain color',
                        name = 'chain_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 183.66
                }
            }
        }
    },
    {
        position = vector3(620.66,2764.38,42.09),
        label = 'Suburban - Clothes',
        sprite = 73,
        color = 59,

        sections = {
            boots = {
                pos = vector3(620.66,2764.38,42.09),
                label = '👞',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Shoes',
                        name = 'shoes_1',
                        from = -1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Shoes color',
                        name = 'shoes_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 84.66
                }
            },
            hats = {
                pos = vector3(618.46,2762.72,42.09),
                label = '👒 ',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Hats',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,

                    },
                    {
                        label = 'Hat color',
                        name = 'helmet_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 105.66
                }
            },
            pants = {
                pos = vector3(614.29,2768.7,42.09),
                label = '👖',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Pants',
                        name = 'pants_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Pants color',
                        name = 'pants_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 184.19
                }
            },
            glasses = {
                pos = vector3(614.52,2759.92,42.09),
                label = '👓',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                        blacklist = {
                            26,27,
                        }
                    },
                    {
                        label = 'Glasses color',
                        name = 'glasses_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 239.5
                }
            },
            tshirt = {
                pos = vector3(622.64,2753.04,42.09),
                label = '👕',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt color',
                        name = 'tshirt_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Torso 1',
                        name = 'torso_1',
                        from = -1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,

                    },
                    {
                        label = 'Torso 2',
                        name = 'torso_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Bulletproof Vests',
                        name = 'bproof_1',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Bulletproof Vest Varities',
                        name = 'bproof_2',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Arms',
                        name = 'arms',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Chains',
                        name = 'chain_1',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Chain color',
                        name = 'chain_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 95.66
                }
            }
        }
    },
    {
        position = vector3(1193.16,2704.16,38.22),
        label = 'Binco - Clothes',
        sprite = 73,
        color = 59,

        sections = {
            boots = {
                pos = vector3(1193.16,2704.16,38.22),
                label = '👞',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Shoes',
                        name = 'shoes_1',
                        from = -1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Shoes color',
                        name = 'shoes_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 0.66
                }
            },
            hats = {
                pos = vector3(1189.36,2712.21,38.22),
                label = '👒 ',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Hats',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,

                    },
                    {
                        label = 'Hat color',
                        name = 'helmet_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 271.66
                }
            },
            pants = {
                pos = vector3(1190.59,2715.4,38.23),
                label = '👖',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Pants',
                        name = 'pants_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Pants color',
                        name = 'pants_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 174.66
                }
            },
            glasses = {
                pos = vector3(1198.08,2710.11,38.22),
                label = '👓',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                        blacklist = {
                            26,27,
                        }
                    },
                    {
                        label = 'Glasses color',
                        name = 'glasses_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 188.99
                }
            },
            tshirt = {
                pos = vector3(1189.42,2710.09,38.22),
                label = '👕',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt color',
                        name = 'tshirt_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Torso 1',
                        name = 'torso_1',
                        from = -1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,

                    },
                    {
                        label = 'Torso 2',
                        name = 'torso_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Bulletproof Vests',
                        name = 'bproof_1',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Bulletproof Vest Varities',
                        name = 'bproof_2',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Arms',
                        name = 'arms',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Chains',
                        name = 'chain_1',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Chain color',
                        name = 'chain_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 267.66
                }
            }
        }
    },
    {
        position = vector3(-1188.25,-772.88,17.33),
        label = 'Suburban - Clothes',
        sprite = 73,
        color = 59,

        sections = {
            boots = {
                pos = vector3(-1188.25,-772.88,17.33),
                label = '👞',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Shoes',
                        name = 'shoes_1',
                        from = -1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Shoes color',
                        name = 'shoes_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 34.66
                }
            },
            hats = {
                pos = vector3(-1190.88,-771.61,17.33),
                label = '👒 ',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Hats',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,

                    },
                    {
                        label = 'Hat color',
                        name = 'helmet_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 46.66
                }
            },
            pants = {
                pos = vector3(-1188.0,-764.68,17.32),
                label = '👖',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Pants',
                        name = 'pants_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Pants color',
                        name = 'pants_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 127.19
                }
            },
            glasses = {
                pos = vector3(-1195.17,-769.83,17.32),
                label = '👓',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                        blacklist = {
                            26,27,
                        }
                    },
                    {
                        label = 'Glasses color',
                        name = 'glasses_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 191.5
                }
            },
            tshirt = {
                pos = vector3(-1196.72,-780.13,17.33),
                label = '👕',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt color',
                        name = 'tshirt_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Torso 1',
                        name = 'torso_1',
                        from = -1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,

                    },
                    {
                        label = 'Torso 2',
                        name = 'torso_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Bulletproof Vests',
                        name = 'bproof_1',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Bulletproof Vest Varities',
                        name = 'bproof_2',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Arms',
                        name = 'arms',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Chains',
                        name = 'chain_1',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Chain color',
                        name = 'chain_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 38.66
                }
            }
        }
    },
    {
        position = vector3(-3176.96,1045.31,20.86),
        label = 'Suburban - Clothes',
        sprite = 73,
        color = 59,

        sections = {
            boots = {
                pos = vector3(-3176.96,1045.31,20.86),
                label = '👞',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Shoes',
                        name = 'shoes_1',
                        from = -1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Shoes color',
                        name = 'shoes_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 242.66
                }
            },
            hats = {
                pos = vector3(-3174.22,1045.9,20.86),
                label = '👒 ',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Hats',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,

                    },
                    {
                        label = 'Hat color',
                        name = 'helmet_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 254.66
                }
            },
            pants = {
                pos = vector3(-3173.77,1038.34,20.86),
                label = '👖',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Pants',
                        name = 'pants_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Pants color',
                        name = 'pants_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 337.19
                }
            },
            glasses = {
                pos = vector3(-1369.34,1046.35,20.86),
                label = '👓',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                        blacklist = {
                            26,27,
                        }
                    },
                    {
                        label = 'Glasses color',
                        name = 'glasses_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 41.5
                }
            },
            tshirt = {
                pos = vector3(-3173.57,1056.11,20.86),
                label = '👕',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt color',
                        name = 'tshirt_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Torso 1',
                        name = 'torso_1',
                        from = -1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,

                    },
                    {
                        label = 'Torso 2',
                        name = 'torso_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Bulletproof Vests',
                        name = 'bproof_1',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Bulletproof Vest Varities',
                        name = 'bproof_2',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Arms',
                        name = 'arms',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Chains',
                        name = 'chain_1',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Chain color',
                        name = 'chain_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 245.66
                }
            }
        }
    },
    {
        position = vector3(-1100.05,2703.59,19.11),
        label = 'Binco - Clothes',
        sprite = 73,
        color = 59,
        sections = {
            boots = {
                pos = vector3(-1100.05,2703.59,19.11),
                label = '👞',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Shoes',
                        name = 'shoes_1',
                        from = -1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Shoes color',
                        name = 'shoes_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 42.66
                }
            },
            hats = {
                pos = vector3(-1108.31,2707.01,19.11),
                label = '👒 ',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Hats',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hat color',
                        name = 'helmet_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 305.66
                }
            },
            pants = {
                pos = vector3(-1109.48,2710.53,19.12),
                label = '👖',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Pants',
                        name = 'pants_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Pants color',
                        name = 'pants_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 225.66
                }
            },
            glasses = {
                pos = vector3(-1100.14,2711.7,19.11),
                label = '👓',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                        blacklist = {
                            26,27,
                        }
                    },
                    {
                        label = 'Glasses color',
                        name = 'glasses_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 224.99
                }
            },
            tshirt = {
                pos = vector3(-1106.73,2705.6,19.11),
                label = '👕',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt color',
                        name = 'tshirt_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Torso 1',
                        name = 'torso_1',
                        from = -1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,

                    },
                    {
                        label = 'Torso 2',
                        name = 'torso_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Bulletproof Vests',
                        name = 'bproof_1',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Bulletproof Vest Varities',
                        name = 'bproof_2',
                        from = -1,
                        to = 500,
                        current = 0,
                        price = 0,
                    },
                    {
                        label = 'Arms',
                        name = 'arms',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Chains',
                        name = 'chain_1',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Chain color',
                        name = 'chain_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 309.66
                }
            }
        }
    },
    {
        position = vector3(-1210.92,-1531.72,4.25),
        label = 'Vespuci - Glasses',
        sprite = 73,
        color = 15,
        sections = {
            glasses = {
                pos = vector3(-1210.92,-1531.72,4.25),
                label = '👓',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                        blacklist = {
                            26,27,
                        }
                    },
                    {
                        label = 'Glasses color',
                        name = 'glasses_2',
                        from = -1,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 100.66
                }
            },
        }
    },
    {
        position = vector3(-1337.235, -1278.237, 4.864502),
        label = 'Vespuci - Mask',
        sprite = 362,
        color = 60,
        sections = {
            glasses = {
                pos = vector3(-1337.235, -1278.237, 4.864502),
                label = '🙈',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Mask',
                        name = 'mask_1',
                        from = -1,
                        to = 160,
                        current = -1,
                        reset = {
                            'mask_2'
                        },
                        price = 50,
                        blacklist = {
                            26,27,
                        }
                    },
                    {
                        label = 'Mask color',
                        name = 'mask_2',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 100.66
                }
            },
        }
    },
    {
        position = vector3(-1226.68,-1445.17,4.28),
        label = 'Vespuci - Bags',
        sprite = 440,
        color = 60,
        sections = {
            bags = {
                pos = vector3(-1226.68,-1445.17,4.28),
                label = '🎒',
                help = 'Press ~INPUT_CONTEXT~ to open shop menu',
                components = {
                    {
                        label = 'Bags',
                        name = 'bags_1',
                        from = -1,
                        to = 160,
                        current = -1,
                        reset = {
                            'bags_2'
                        },
                        price = 120,
                    },
                    {
                        label = 'Bags color',
                        name = 'bags_2',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 211.66
                }
            },
        }
    },
    {
        position = vector3(-814.3, -183.8, 36.6),
        label = 'Barber Shop',
        sprite = 71,
        color = 60,
        sections = {
            bags = {
                pos = vector3(-814.3, -183.8, 37.6),
                label = '✂️',
                help = 'Press ~INPUT_CONTEXT~ to change your hair!',
                components = {
                    {
                        label = 'Hair Style',
                        name = 'hair_1',
                        from = -1,
                        to = 160,
                        current = 0,
                        price = 120,
                    },
                    {
                        label = 'Hair Texture',
                        name = 'hair_2',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Hair Color',
                        name = 'hair_color_1',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Hair Highlights',
                        name = 'hair_color_2',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Beard Style',
                        name = 'beard_1',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Beard Thickness',
                        name = 'beard_2',
                        from = -1,
                        to = 10,
                        current = 10,
                        price = 10,
                    },
                    {
                        label = 'Beard Color',
                        name = 'beard_3',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Style',
                        name = 'eyebrows_1',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Thickness',
                        name = 'eyebrows_2',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Color',
                        name = 'eyebrows_3',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 100.66
                }
            },
        }
    },
    {
        position = vector3(136.8, -1708.4, 28.3),
        label = 'Barber Shop',
        sprite = 71,
        color = 60,
        sections = {
            bags = {
                pos = vector3(136.8, -1708.4, 29.3),
                label = '✂️',
                help = 'Press ~INPUT_CONTEXT~ to change your hair!',
                components = {
                    {
                        label = 'Hair Style',
                        name = 'hair_1',
                        from = -1,
                        to = 160,
                        current = 0,
                        price = 120,
                    },
                    {
                        label = 'Hair Texture',
                        name = 'hair_2',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Hair Color',
                        name = 'hair_color_1',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Hair Highlights',
                        name = 'hair_color_2',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Beard Style',
                        name = 'beard_1',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Beard Thickness',
                        name = 'beard_2',
                        from = -1,
                        to = 10,
                        current = 10,
                        price = 10,
                    },
                    {
                        label = 'Beard Color',
                        name = 'beard_3',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Style',
                        name = 'eyebrows_1',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Thickness',
                        name = 'eyebrows_2',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Color',
                        name = 'eyebrows_3',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 100.66
                }
            },
        }
    },
    {
        position = vector3(-627.6, -233.2, 38.0),
        label = 'Jewlery Shop',
        sprite = 617,
        color = 38,
        sections = {
            bags = {
                pos = vector3(-627.6, -233.2, 38.0),
                label = '💍',
                help = 'Press ~INPUT_CONTEXT~ to change your jewlery!',
                components = {
                    {
                        label = 'Bracelets Style',
                        name = 'bracelets_1',
                        from = -1,
                        to = 160,
                        current = 0,
                        price = 120,
                    },
                    {
                        label = 'Bracelets Color',
                        name = 'bracelets_2',
                        from = -1,
                        to = 160,
                        current = 0,
                        price = 120,
                    },
                    {
                        label = 'Watches Style',
                        name = 'watches_1',
                        from = -1,
                        to = 160,
                        current = 0,
                        price = 120,
                    },
                    {
                        label = 'Watches Color',
                        name = 'watches_2',
                        from = -1,
                        to = 160,
                        current = 0,
                        price = 120,
                    },
                    {
                        label = 'Ear Accessories', 
                        name = 'ears_1',
                        from = -1,
                        to = 160,
                        current = 0,
                        price = 120,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.2
                    },
                    taskHeading = 80.66
                }
            },
        }
    },
    {
        position = vector3(-1282.6, -1116.8, 6.0),
        label = 'Barber Shop',
        sprite = 71,
        color = 60,
        sections = {
            bags = {
                pos = vector3(-1282.6, -1116.8, 7.0),
                label = '✂️',
                help = 'Press ~INPUT_CONTEXT~ to change your hair!',
                components = {
                    {
                        label = 'Hair Style',
                        name = 'hair_1',
                        from = -1,
                        to = 160,
                        current = 0,
                        price = 120,
                    },
                    {
                        label = 'Hair Texture',
                        name = 'hair_2',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Hair Color',
                        name = 'hair_color_1',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Hair Highlights',
                        name = 'hair_color_2',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Beard Style',
                        name = 'beard_1',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Beard Thickness',
                        name = 'beard_2',
                        from = -1,
                        to = 10,
                        current = 10,
                        price = 10,
                    },
                    {
                        label = 'Beard Color',
                        name = 'beard_3',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Style',
                        name = 'eyebrows_1',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Thickness',
                        name = 'eyebrows_2',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Color',
                        name = 'eyebrows_3',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 100.66
                }
            },
        }
    },
    {
        position = vector3(1931.5, 3729.7, 31.8), 
        label = 'Barber Shop',
        sprite = 71,
        color = 60,
        sections = {
            bags = {
                pos = vector3(1931.5, 3729.7, 32.8),
                label = '✂️',
                help = 'Press ~INPUT_CONTEXT~ to change your hair!',
                components = {
                    {
                        label = 'Hair Style',
                        name = 'hair_1',
                        from = -1,
                        to = 160,
                        current = 0,
                        price = 120,
                    },
                    {
                        label = 'Hair Texture',
                        name = 'hair_2',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Hair Color',
                        name = 'hair_color_1',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Hair Highlights',
                        name = 'hair_color_2',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Beard Style',
                        name = 'beard_1',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Beard Thickness',
                        name = 'beard_2',
                        from = -1,
                        to = 10,
                        current = 10,
                        price = 10,
                    },
                    {
                        label = 'Beard Color',
                        name = 'beard_3',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Style',
                        name = 'eyebrows_1',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Thickness',
                        name = 'eyebrows_2',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Color',
                        name = 'eyebrows_3',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 100.66
                }
            },
        }
    },
    {
        position = vector3(1212.435, -472.7473, 66.19775), 
        label = 'Barber Shop',
        sprite = 71,
        color = 60,
        sections = {
            bags = {
                pos = vector3(1212.435, -472.7473, 66.19775),
                label = '✂️',
                help = 'Press ~INPUT_CONTEXT~ to change your hair!',
                components = {
                    {
                        label = 'Hair Style',
                        name = 'hair_1',
                        from = -1,
                        to = 160,
                        current = 0,
                        price = 120,
                    },
                    {
                        label = 'Hair Texture',
                        name = 'hair_2',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Hair Color',
                        name = 'hair_color_1',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Hair Highlights',
                        name = 'hair_color_2',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Beard Style',
                        name = 'beard_1',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Beard Thickness',
                        name = 'beard_2',
                        from = -1,
                        to = 10,
                        current = 10,
                        price = 10,
                    },
                    {
                        label = 'Beard Color',
                        name = 'beard_3',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Style',
                        name = 'eyebrows_1',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Thickness',
                        name = 'eyebrows_2',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Color',
                        name = 'eyebrows_3',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 100.66
                }
            },
        }
    },
    {
        position = 	vector3(-32.9, -152.3, 56.1),
        label = 'Barber Shop',
        sprite = 71,
        color = 60,
        sections = {
            bags = {
                pos = 	vector3(-32.9, -152.3, 57.1),
                label = '✂️',
                help = 'Press ~INPUT_CONTEXT~ to change your hair!',
                components = {
                    {
                        label = 'Hair Style',
                        name = 'hair_1',
                        from = -1,
                        to = 160,
                        current = 0,
                        price = 120,
                    },
                    {
                        label = 'Hair Texture',
                        name = 'hair_2',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Hair Color',
                        name = 'hair_color_1',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Hair Highlights',
                        name = 'hair_color_2',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Beard Style',
                        name = 'beard_1',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Beard Thickness',
                        name = 'beard_2',
                        from = -1,
                        to = 10,
                        current = 10,
                        price = 10,
                    },
                    {
                        label = 'Beard Color',
                        name = 'beard_3',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Style',
                        name = 'eyebrows_1',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Thickness',
                        name = 'eyebrows_2',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Color',
                        name = 'eyebrows_3',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 100.66
                }
            },
        }
    },
    {
        position = vector3(-278.1, 6228.5, 30.7),
        label = 'Barber Shop',
        sprite = 71,
        color = 60,
        sections = {
            bags = {
                pos = vector3(-278.1, 6228.5, 31.7),
                label = '✂️',
                help = 'Press ~INPUT_CONTEXT~ to change your hair!',
                components = {
                    {
                        label = 'Hair Style',
                        name = 'hair_1',
                        from = -1,
                        to = 160,
                        current = 0,
                        price = 120,
                    },
                    {
                        label = 'Hair Texture',
                        name = 'hair_2',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Hair Color',
                        name = 'hair_color_1',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Hair Highlights',
                        name = 'hair_color_2',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Beard Style',
                        name = 'beard_1',
                        from = -1,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Beard Thickness',
                        name = 'beard_2',
                        from = -1,
                        to = 10,
                        current = 10,
                        price = 10,
                    },
                    {
                        label = 'Beard Color',
                        name = 'beard_3',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Style',
                        name = 'eyebrows_1',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Thickness',
                        name = 'eyebrows_2',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                    {
                        label = 'Eyebrows Color',
                        name = 'eyebrows_3',
                        from = -1,
                        to = 200,
                        current = 0,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 100.66
                }
            },
        }
    },
}
