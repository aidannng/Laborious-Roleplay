ESX = nil
local PlayerData = {}
local pedspawneado = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)



RegisterNetEvent('openpawnshop')
AddEventHandler('openpawnshop', function()
	TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Pawnshop",
            txt = ""
        },
		{
            id = 2,
            header = "Jewellery",
            txt = "Rings | Chain's | Watch's",
            params = {
                event = "pawnshop:jewellery",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
        {
            id = 3,
            header = "Materials",
            txt = "Rubber | Copper | Aluminium | Scrap Metal",
            params = {
                event = "pawnshop:material",
                args = {
                    number = 2,
                    id = 3
                }
            }
        },
        {
            id = 4,
            header = "Electronic's",
            txt = "Apple Phone | Nokia | Samsung | Electronic's",
            params = {
                event = "pawnshop:electronic",
                args = {
                    number = 3,
                    id = 4
                }
            }
        },
    })
end)

AddEventHandler('pawnshop:jewellery',function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Jewellery",
            txt = ""
        },
		{
			id = 2,
			header = "Casio Watch",
			txt = "$30 - $70",
			params = {
				event = "sellcasio",
				args = {
					number = 1,
					id = 2
				}
			}
		},
		{
			id = 3,
			header = "Wedding Ring",
			txt = "$150 - $280",
			params = {
				event = "sellwring",
				args = {
					number = 2,
					id = 3
				}
			}
		},
		{
			id = 4,
			header = "2CT Chain",
			txt = "$70 - $95",
			params = {
				event = "sell2chain",
				args = {
					number = 3,
					id = 4
				}
			}
		},
        {
			id = 5,
			header = "5CT Chain",
			txt = "$100 - $125",
			params = {
				event = "sell5chain",
				args = {
					number = 4,
					id = 5
				}
			}
		},
        {
			id = 6,
			header = "8CT Chain",
			txt = "$140 - $190",
			params = {
				event = "sell8chain",
				args = {
					number = 5,
					id = 6
				}
			}
		},
        {
			id = 7,
			header = "10CT Chain",
			txt = "$250 - $400",
			params = {
				event = "sell10chain",
				args = {
					number = 6,
					id = 7
				}
			}
		},
        {
			id = 8,
			header = "Rolex",
			txt = "$700 - $1500",
			params = {
				event = "sellrolex",
				args = {
					number = 7,
					id = 8
				}
			}
		},
        {
			id = 9,
			header = "Go Back",
			txt = "",
			params = {
				event = "openpawnshop",
				args = {
					number = 8,
					id = 9
				}
			}
		}
	})
end)

AddEventHandler('pawnshop:material',function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Materials",
            txt = ""
        },
		{
			id = 2,
			header = "Scrap Metal",
			txt = "$45 - $60",
			params = {
				event = "sellscrap",
				args = {
					number = 1,
					id = 2
				}
			}
		},
		{
			id = 3,
			header = "Aluminium",
			txt = "$35 - $45",
			params = {
				event = "sellaluminium",
				args = {
					number = 2,
					id = 3
				}
			}
		},
		{
			id = 4,
			header = "Copper",
			txt = "$25 - $35",
			params = {
				event = "sellcopper",
				args = {
					number = 3,
					id = 4
				}
			}
		},
        {
			id = 5,
			header = "Rubber",
			txt = "$25 - $35",
			params = {
				event = "sellrubber",
				args = {
					number = 4,
					id = 5
				}
			}
		},
        {
			id = 6,
			header = "Go Back",
			txt = "",
			params = {
				event = "openpawnshop",
				args = {
					number = 5,
					id = 6
				}
			}
		}
	})
end)

AddEventHandler('pawnshop:electronic',function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Electronic's",
            txt = ""
        },
		{
			id = 2,
			header = "Apple Phone",
			txt = "$175 - $300",
			params = {
				event = "selliphone",
				args = {
					number = 1,
					id = 2
				}
			}
		},
		{
			id = 3,
			header = "Nokia",
			txt = "$25 - $40",
			params = {
				event = "sellnokia",
				args = {
					number = 2,
					id = 3
				}
			}
		},
		{
			id = 4,
			header = "Samsung S8",
			txt = "$150 - $220",
			params = {
				event = "sellsamsung",
				args = {
					number = 3,
					id = 4
				}
			}
		},
        {
			id = 5,
			header = "Electronic",
			txt = "$45 - $70",
			params = {
				event = "sellelectronic",
				args = {
					number = 4,
					id = 5
				}
			}
		},
        {
			id = 6,
			header = "Go Back",
			txt = "",
			params = {
				event = "openpawnshop",
				args = {
					number = 5,
					id = 6
				}
			}
		}
	})
end)



-- Server Triggers -- 

RegisterNetEvent('sellcasio')
AddEventHandler('sellcasio', function()
    TriggerServerEvent('pawnshop:sellcasio')
end)

RegisterNetEvent('sellwring')
AddEventHandler('sellwring', function()
    TriggerServerEvent('pawnshop:sellwring')
end)

RegisterNetEvent('sell2chain')
AddEventHandler('sell2chain', function()
    TriggerServerEvent('pawnshop:sell2chain')
end)

RegisterNetEvent('sell5chain')
AddEventHandler('sell5chain', function()
    TriggerServerEvent('pawnshop:sell5chain')
end)

RegisterNetEvent('sell8chain')
AddEventHandler('sell8chain', function()
    TriggerServerEvent('pawnshop:sell8chain')
end)

RegisterNetEvent('sell10chain')
AddEventHandler('sell10chain', function()
    TriggerServerEvent('pawnshop:sell10chain')
end)

RegisterNetEvent('sellrolex')
AddEventHandler('sellrolex', function()
    TriggerServerEvent('pawnshop:sellrolex')
end)

RegisterNetEvent('selliphone')
AddEventHandler('selliphone', function()
    TriggerServerEvent('pawnshop:selliphone')
end)

RegisterNetEvent('sellnokia')
AddEventHandler('sellnokia', function()
    TriggerServerEvent('pawnshop:sellnokia')
end)
RegisterNetEvent('sellsamsung')
AddEventHandler('sellsamsung', function()
    TriggerServerEvent('pawnshop:sellsamsung')
end)
RegisterNetEvent('sellelectronic')
AddEventHandler('sellelectronic', function()
    TriggerServerEvent('pawnshop:sellelectronic')
end)







RegisterNetEvent('sellscrap')
AddEventHandler('sellscrap', function()
    TriggerServerEvent('pawnshop:sellscrap')
end)

RegisterNetEvent('sellaluminium')
AddEventHandler('sellaluminium', function()
    TriggerServerEvent('pawnshop:sellaluminium')
end)

RegisterNetEvent('sellcopper')
AddEventHandler('sellcopper', function()
    TriggerServerEvent('pawnshop:sellcopper')
end)

RegisterNetEvent('sellrubber')
AddEventHandler('sellrubber', function()
    TriggerServerEvent('pawnshop:sellrubber')
end)

RegisterNetEvent('sellelectronics')
AddEventHandler('sellelectronics', function()
    TriggerServerEvent('pawnshop:sellelectronics')
end)



exports['labrp_Eye']:AddBoxZone("smallcrafting", vector3(2514.356, 4215.771, 39.02417), 1.7, 0.9, {
	name="smallcrafting",
	heading=55,
	debugPoly=false,
	minZ=38.55,
	maxZ=40.05
    }, {
        options = {
            {
                event = 'smallcrafting',
                icon = 'fas fa-hammer',
                label = 'Crafting Bench'
            },

        },
        job = {"all"},
        distance = 2.5
    })


RegisterNetEvent('smallcrafting')
AddEventHandler('smallcrafting', function()
    exports['br-menu']:SetTitle("Small Crafting")    
    
    exports['br-menu']:AddButton("Advanced Lockpick" , "Materials : 5 Scrap Metal" ,'craftadlock' ,'' , 'menutwo')
    exports['br-menu']:AddButton("Casio Watch" , "Materials : 2 Batteries | 5 Plastic" ,'craftcasio' ,'' , 'menutwo')
    
end)

RegisterNetEvent('craftadlock')
AddEventHandler('craftadlock', function()
    TriggerServerEvent('craft:adlock')
end)

RegisterNetEvent('craftcasio')
AddEventHandler('craftcasio', function()
    TriggerServerEvent('craft:casio')
end)