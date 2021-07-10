ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	local HouseGarages = {}
	local fetchSqlQuery = [[
		SELECT
			*
		FROM
		houselocations
	]]
	exports.ghmattimysql:execute(fetchSqlQuery, {}, function(result)
		
		if result[1] ~= nil then
			for k, v in pairs(result) do
				local owned = false
				if tonumber(v.owned) == 1 then
					owned = true
				end
				local garage = v.garage ~= nil and json.decode(v.garage) or {}
				Config.Houses[v.name] = {
					coords = json.decode(v.coords),
					owned = v.owned,
					price = v.price,
					locked = true,
					adress = v.label, 
					tier = v.tier,
					garage = garage,
					decorations = {},
				}
				HouseGarages[v.name] = {
					label = v.label,
					takeVehicle = garage,
				}
			end
		end
		TriggerClientEvent("qb-garages:client:houseGarageConfig", -1, HouseGarages)
		TriggerClientEvent("qb-houses:client:setHouseConfig", -1, Config.Houses)
	end)
end)

local houseowneridentifier = {}
local houseownercid = {}
local housekeyholders = {}

RegisterServerEvent('qb-houses:server:setHouses')
AddEventHandler('qb-houses:server:setHouses', function()
	local src = source
	TriggerClientEvent("qb-houses:client:setHouseConfig", src, Config.Houses)
end)

RegisterServerEvent('qb-houses:server:addNewHouse')
AddEventHandler('qb-houses:server:addNewHouse', function(street, coords, price, tier)
	local src = source
	local street = street:gsub("%'", "")
	local price = tonumber(price)
	local tier = tonumber(tier)
	local houseCount = GetHouseStreetCount(street)
	local name = street:lower() .. tostring(houseCount)
	local label = street .. " " .. tostring(houseCount)
	exports.ghmattimysql:execute("INSERT INTO houselocations (name, label, coords, owned, price, tier) VALUES (@name, @label, @coords, @owned, @price, @tier)",{['@name'] = name, ['label'] = label, ['coords'] = json.encode(coords), ['owned']= 0,['price'] = price,['tier'] = tier})
	Config.Houses[name] = {
		coords = coords,
		owned = false,
		price = price,
		locked = true,
		adress = label, 
		tier = tier,
		garage = {},
		decorations = {},
	}
	TriggerClientEvent("qb-houses:client:setHouseConfig", -1, Config.Houses)
	TriggerClientEvent('notification', src, 'Bir ev ekledin:'..label, 1)
end)

-- RegisterServerEvent('qb-houses:server:addNewHouse')
-- AddEventHandler('qb-houses:server:addNewHouse', function(street, coords, price, tier)
-- 	local src = source
-- 	local street = street:gsub("%'", "")
-- 	local price = tonumber(price)
-- 	local tier = tonumber(tier)
-- 	local houseCount = GetHouseStreetCount(street)
-- 	local name = street:lower() .. tostring(houseCount)
-- 	local label = street .. " " .. tostring(houseCount)
-- 	exports.ghmattimysql:execute(false, "INSERT INTO `houselocations` (`name`, `label`, `coords`, `owned`, `price`, `tier`) VALUES ('"..name.."', '"..label.."', '"..json.encode(coords).."', 0,"..price..", "..tier..")")
-- 	Config.Houses[name] = {
-- 		coords = coords,
-- 		owned = false,
-- 		price = price,
-- 		locked = true,
-- 		adress = label, 
-- 		tier = tier,
-- 		garage = {},
-- 		decorations = {},
-- 	}
-- 	TriggerClientEvent("qb-houses:client:setHouseConfig", -1, Config.Houses)
-- 	TriggerClientEvent('notification', src, 'Bir ev ekledin:'..label)
-- end)

RegisterServerEvent('qb-houses:server:addGarage')
AddEventHandler('qb-houses:server:addGarage', function(house, coords)
	local src = source
	exports.ghmattimysql:execute("UPDATE `houselocations` SET `garage` = '"..json.encode(coords).."' WHERE `name` = '"..house.."'")
	local garageInfo = {
		label = Config.Houses[house].adress,
		takeVehicle = coords,
	}
	TriggerClientEvent("qb-garages:client:addHouseGarage", -1, house, garageInfo)
	TriggerClientEvent('notification', src, 'Bir garaj eklediniz:'..garageInfo.label, 1)
end)

RegisterServerEvent('qb-houses:server:viewHouse')
AddEventHandler('qb-houses:server:viewHouse', function(house)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	
	

	local houseprice   	= Config.Houses[house].price
	local brokerfee 	= (houseprice / 100 * 5)
	local bankfee 		= (houseprice / 100 * 10) 
	local taxes 		= (houseprice / 100 * 6)
	exports.ghmattimysql:execute("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {
		['@identifier'] = xPlayer.identifier,
		['@firstname'] = firstname,
		['@lastname'] = lastname

	}, function(result)
		if (result ~= nil) then
		  TriggerClientEvent('qb-houses:client:viewHouse', src, houseprice, brokerfee, bankfee, taxes, firstname, lastname)
		 
	      else
		   TriggerClientEvent('notification', src, ('Birseyler ters gitti cocuk adam'), 2)
		end
   end)
end)

RegisterServerEvent('qb-houses:server:buyHouse')
AddEventHandler('qb-houses:server:buyHouse', function(house)
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local price   	= Config.Houses[house].price
	local HousePrice = math.ceil(price * 1.21)
	local bankBalance = xPlayer.getAccount('bank').money

	if (bankBalance >= HousePrice) then
		exports.ghmattimysql:execute("INSERT INTO player_houses (house, identifier, keyholders) VALUES (@house,@identifier,@keyholders)",{['@house']= house, ['identifier']=xPlayer.identifier,['@keyholders'] = json.encode(keyyeet) })
		houseowneridentifier[house] = xPlayer.identifier
		housekeyholders[house] = {
			[1] = xPlayer.identifier
		}
		exports.ghmattimysql:execute('SELECT houselocations SET owned = @owned WHERE name = @name',{['owned']= 1, ['name'] = house})
		TriggerClientEvent('qb-houses:client:SetClosestHouse', src)
	     xPlayer.removeAccountMoney('bank', HousePrice) -- 21% Extra house costs
	else
		TriggerClientEvent('notification', src, 'Yeterli paran yok..', 1)
	end
end)

RegisterServerEvent('qb-houses:server:lockHouse')
AddEventHandler('qb-houses:server:lockHouse', function(bool, house)
	TriggerClientEvent('qb-houses:client:lockHouse', -1, bool, house)
end)

RegisterServerEvent('qb-houses:server:SetRamState')
AddEventHandler('qb-houses:server:SetRamState', function(bool, house)
	Config.Houses[house].IsRaming = bool
	TriggerClientEvent('qb-houses:server:SetRamState', -1, bool, house)
end)

--------------------------------------------------------------

--------------------------------------------------------------

ESX.RegisterServerCallback('qb-houses:server:hasKey', function(source, cb, house)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local retval = false
	if xPlayer ~= nil then 
		local identifier = xPlayer.identifier
		
		if hasKey(identifier, house) then
			retval = true
			
		elseif xPlayer.job.name == "realestate" then
			retval = true
			
		else
			retval = false
			
		end
		
	end
	
	cb(retval)
end)

ESX.RegisterServerCallback('qb-houses:server:isOwned', function(source, cb, house)
	if houseowneridentifier[house] ~= nil  then
		
		cb(true)
	else
		
		cb(false)
	end
end)

ESX.RegisterServerCallback('qb-houses:server:getHouseOwner', function(source, cb, house)
	cb(houseowneridentifier[house])
end)

ESX.RegisterServerCallback('qb-houses:server:getHouseKeyHolders', function(source, cb, house)
	local retval = {}
	local xPlayer = ESX.GetPlayerFromId(src)
	if housekeyholders[house] ~= nil then 
		for i = 1, #housekeyholders[house], 1 do
			if xPlayer.identifier ~= housekeyholders[house][i] then
				exports.ghmattimysql:execute( "SELECT firstname, lastname FROM users WHERE identifier = @identifier ",{['@identifier'] = housekeyholders[house][i]}, function(result)
					if (result[1] ~= nil) then 
						table.insert(retval, {
							firstname = json.decode(result2[1].firstname),
							lastname = json.decode(result2[1].lastname),
							identifier = housekeyholders[house][i],
						})
					end
					cb(retval)
				end)
			end
		end
	else
		cb(nil)
	end
end)

function hasKey(identifier, house)
	if houseowneridentifier[house] ~= nil  then
		if houseowneridentifier[house] == identifier  then
			return true
		else
			if housekeyholders[house] ~= nil then 
				for i = 1, #housekeyholders[house], 1 do
					if housekeyholders[house][i] == identifier then
						return true
					end
				end
			end
		end
	end
	return false
end

--[[function getOfflinePlayerData(citizenid)
	exports['ghmattimysql']:execute("SELECT `charinfo` FROM `players` WHERE `citizenid` = '"..citizenid.."'", function(result)
		Citizen.Wait(100)
		if result[1] ~= nil then 
			local charinfo = json.decode(result[1].charinfo)
			return charinfo
		else
			return nil
		end
	end)
end--]]

RegisterServerEvent('qb-houses:server:giveKey')
AddEventHandler('qb-houses:server:giveKey', function(house, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	table.insert(housekeyholders[house], xPlayer.identifier)
	exports.ghmattimysql:execute('UPDATE player_houses SET keyholders = @keyholders WHERE house =@house',{['@keyholders'] = json.encode(housekeyholders[house]), ['@house'] = house} )
end)

RegisterServerEvent('qb-houses:server:removeHouseKey')
AddEventHandler('qb-houses:server:removeHouseKey', function(house, citizenData)
	local src = source
	local newHolders = {}
	if housekeyholders[house] ~= nil then 
		for k, v in pairs(housekeyholders[house]) do
			if housekeyholders[house][k] ~= citizenData.identifier then
				table.insert(newHolders, housekeyholders[house][k])
			end
		end
	end
	housekeyholders[house] = newHolders
	TriggerClientEvent('notification', src, citizenData.firstname ..''.. citizenData.lastname ..' anahtarları kaldırdı.', 1)
	exports.ghmattimysql:execute('UPDATE player_houses SET keyholders = @keyholders WHERE house =@house',{['@keyholders'] = json.encode(housekeyholders[house]), ['@house'] = house} )
end)

function typeof(var)
    local _type = type(var);
    if(_type ~= "table" and _type ~= "userdata") then
        return _type;
    end
    local _meta = getmetatable(var);
    if(_meta ~= nil and _meta._NAME ~= nil) then
        return _meta._NAME;
    else
        return _type;
    end
end

local housesLoaded = false

Citizen.CreateThread(function()
	while true do
		if not housesLoaded then
			local fetchSqlQuery1 = [[
		SELECT
			*
		FROM
		player_houses
	    ]]
		exports.ghmattimysql:execute(fetchSqlQuery1, {}, function(houses)
				if houses ~= nil then
					for _,house in pairs(houses) do
						houseowneridentifier[house.house] = house.identifier
						housekeyholders[house.house] = json.decode(house.keyholders)
					end
				end
			end)
			housesLoaded = true
		end
		Citizen.Wait(7)
	end
end)

RegisterServerEvent('qb-houses:server:OpenDoor')
AddEventHandler('qb-houses:server:OpenDoor', function(target, house)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(target)
    if xPlayer ~= nil then
        TriggerClientEvent('qb-houses:client:SpawnInApartment', xPlayer.source, house)
    end
end)

RegisterServerEvent('qb-houses:server:RingDoor')
AddEventHandler('qb-houses:server:RingDoor', function(house)
    local src = source
    TriggerClientEvent('qb-houses:client:RingDoor', -1, src, house)
end)

RegisterServerEvent('qb-houses:server:savedecorations')
AddEventHandler('qb-houses:server:savedecorations', function(house, decorations)
	local src = source
	exports.ghmattimysql:execute('UPDATE player_houses SET decorations=@decorations  WHERE house =@house',{['@decorations']= json.encode(decorations), ['@house']= house})
	TriggerClientEvent("qb-houses:server:sethousedecorations", -1, house, decorations)
end)

ESX.RegisterServerCallback('qb-houses:server:getHouseDecorations', function(source, cb, house)
	local retval = nil
	exports.ghmattimysql:execute("SELECT * FROM player_houses WHERE house =  @house",{['@house']= house}, function(result)
		if result[1] ~= nil then
			if result[1].decorations ~= nil then
				retval = json.decode(result[1].decorations)
			end
		end
		cb(retval)
	end)
end)

ESX.RegisterServerCallback('qb-houses:server:getHouseLocations', function(source, cb, house)
	local retval = nil
	exports.ghmattimysql:execute("SELECT * FROM player_houses WHERE house = @house",{['@house']=house},function(result)
		
		if result[1] ~= nil then
			retval = result[1]
		end
		cb(retval)
	end)
end)

ESX.RegisterServerCallback('qb-houses:server:getHouseKeys', function(source, cb)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local cid = xPlayer.identifier
end)

function mysplit (inputstr, sep)
	if sep == nil then
			sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
	end
	return t
end

ESX.RegisterServerCallback('qb-houses:server:getOwnedHouses', function( source, cb)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
  if xPlayer~= nil then
	   exports.ghmattimysql:execute('SELECT * FROM player_houses WHERE identifier = @identifier ', {
		  ['@identifier'] = xPlayer.identifier
	      }, function(houses)
		  local ownedHouses = {}
		  for i=1, #houses, 1 do
		      table.insert(ownedHouses, houses[i].house)
	       end

			if houses ~= nil then
			 cb(ownedHouses)
		    else
			  cb(nil)
		    end
	   end)
   end
	
end)

ESX.RegisterServerCallback('qb-houses:server:getSavedOutfits', function(source, cb)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	
		exports.ghmattimysql:execute('SELECT * FROM player_outfits WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier}, function(result)
			if result[1] ~= nil then
				cb(result)
			else
				cb(nil)
			end
		end)
	
end)

RegisterCommand("decorate", function(source, args)
	TriggerClientEvent("qb-houses:client:decorate", source)
end)

function GetHouseStreetCount(street)
	local count = 1
	exports.ghmattimysql:execute("SELECT * FROM houselocations WHERE name =@name", {['@name']= street}, function(result)
		if result[1] ~= nil then 
			for i = 1, #result, 1 do
				count = count + 1
			end
		end
		return count
	end)
	return count
end

--[[RegisterServerEvent('qb-houses:server:LogoutLocation')
AddEventHandler('qb-houses:server:LogoutLocation', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local MyItems = Player.PlayerData.items
	exports.ghmattimysql:execute("UPDATE `players` SET `inventory` = '"..QBCore.EscapeSqli(json.encode(MyItems)).."' WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'")
	QBCore.Player.Logout(src)
    TriggerClientEvent('qb-multicharacter:client:chooseChar', src)
end)--]]

RegisterServerEvent('qb-houses:server:giveHouseKey')
AddEventHandler('qb-houses:server:giveHouseKey', function(target, house)
	local src = source
	local tPlayer = ESX.GetPlayerFromId(target)
	
	if tPlayer ~= nil then
		if housekeyholders[house] ~= nil then
			for _, identifier in pairs(housekeyholders[house]) do
				if identifier == tPlayer.identifier then
					TriggerClientEvent('notification', src, 'This person already has the keys to this house', 2)
					return
				end
			end		
			table.insert(housekeyholders[house], tPlayer.identifier)
			exports.ghmattimysql:execute('UPDATE player_houses SET keyholders = @keyholders WHERE house =@house',{['@keyholders'] = json.encode(housekeyholders[house]), ['@house'] = house} )
			TriggerClientEvent('qb-houses:client:refreshHouse', tPlayer.source)
			TriggerClientEvent('notification', tPlayer.source, 'Anahtarlara sahipsin. Ev Adresi: '..Config.Houses[house].adress..' !', 2)
		else
			local sourceTarget = ESX.GetPlayerFromId(src)
			housekeyholders[house] = {
				[1] = sourceTarget.identifier
			}
			table.insert(housekeyholders[house], tPlayer.identifier)
			exports.ghmattimysql:execute('UPDATE player_houses SET keyholders = @keyholders WHERE house =@house',{['@keyholders'] = json.encode(housekeyholders[house]), ['@house'] = house} )
			TriggerClientEvent('qb-houses:client:refreshHouse', tPlayer.source)
			TriggerClientEvent('notification', tPlayer.source, 'Anahtarlara sahipsin. Ev Adresi: '..Config.Houses[house].adress , 2)
		end
	else
		TriggerClientEvent('notification', tPlayer.source, 'Birseyler ters gitti. Tekrar dene' , 2)
	end
end)

RegisterServerEvent('test:test')
AddEventHandler('test:test', function(msg)
	print(msg)
end)

RegisterServerEvent('qb-houses:server:setLocation')
AddEventHandler('qb-houses:server:setLocation', function(coords, house, type)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	if type == 1 then
		exports.ghmattimysql:execute('UPDATE player_houses SET stash =@stash WHERE house =@house ', {['@stash']=json.encode(coords), ['@house'] = house})
	elseif type == 2 then
		exports.ghmattimysql:execute('UPDATE player_houses SET outfit =@outfit WHERE house =@house ', {['@outfit']=json.encode(coords), ['@house'] = house})
	elseif type == 3 then
		exports.ghmattimysql:execute('UPDATE player_houses SET logoutout =@logoutout WHERE house =@house ', {['@logoutout']=json.encode(coords), ['@house'] = house})
	end

	TriggerClientEvent('qb-houses:client:refreshLocations', -1, house, json.encode(coords), type)
end)

RegisterCommand("createhouse", function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = tonumber(args[1])
	local tier = tonumber(args[2])
	if xPlayer.job.name == "realestate" then
		TriggerClientEvent("qb-houses:client:createHouses", source, price, tier)
	end
end)

RegisterCommand("addgarage", function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == "realestate" then
		TriggerClientEvent("qb-houses:client:addGarage", source)
	end
end)

-- RegisterServerEvent('qb-houses:server:SetInsideMeta')
-- AddEventHandler('qb-houses:server:SetInsideMeta', function(insideId, bool)
--     local src = source
--     local xPlayer =  ESX.GetPlayerFromId(src)
--     local user = xPlayer.identifier
-- 	if bool then
-- 		exports.ghmattimysql:execute('UPDATE player_houses SET insideId= @insideId WHERE insideId = @insideId',{['@insideId'] = insideId})
--     else
-- 		exports.ghmattimysql:execute('UPDATE player_houses SET insideId= @insideId WHERE insideId = @insideId',{['@insideId'] = nil})
--     end
-- end)



function escape_sqli(source)
    local replacements = { ['"'] = '\\"', ["'"] = "\\'" }
    return source:gsub( "['\"]", replacements ) -- or string.gsub( source, "['\"]", replacements )
end

ESX.RegisterServerCallback('qb-phone_new:server:MeosGetPlayerHouses', function(source, cb, input)
	local src = source
	if input ~= nil then
		local search = escape_sqli(input)
		local searchData = {}

		exports.ghmattimysql:execute('SELECT * FROM `users` WHERE `identifier` = "'..search..'" OR `charinfo` LIKE "%'..search..'%"', function(result)
			if result[1] ~= nil then
				exports.ghmattimysql:execute("SELECT * FROM `player_houses` WHERE `identifier` = '"..result[1].identifier.."'", function(houses)
					if houses[1] ~= nil then
						for k, v in pairs(houses) do
							table.insert(searchData, {
								name = v.house,
								keyholders = keyholders,
								owner = v.citizenid,
								price = Config.Houses[v.house].price,
								label = Config.Houses[v.house].adress,
								tier = Config.Houses[v.house].tier,
								garage = Config.Houses[v.house].garage,
								charinfo = json.decode(result[1].charinfo),
								coords = {
									x = Config.Houses[v.house].coords.enter.x,
									y = Config.Houses[v.house].coords.enter.y,
									z = Config.Houses[v.house].coords.enter.z,
								}
							})
						end

						cb(searchData)
					end
				end)
			else
				cb(nil)
			end
		end)
	else
		cb(nil)
	end
end)

--[[QBCore.Functions.CreateUseableItem("police_stormram", function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)

	if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
		TriggerClientEvent("qb-houses:client:HomeInvasion", source)
	else
		TriggerClientEvent('QBCore:Notify', source, "Sadece polisler icin komut sacmalama", "error")
	end
end)--]]

RegisterServerEvent('qb-houses:server:SetHouseRammed')
AddEventHandler('qb-houses:server:SetHouseRammed', function(bool, house)
	Config.Houses[house].IsRammed = bool
	TriggerClientEvent('qb-houses:client:SetHouseRammed', -1, bool, house)
end)

RegisterCommand("enter", function(source, args)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	
 
    TriggerClientEvent('qb-houses:client:EnterHouse', src)
end)

RegisterCommand("ring",  function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
 
    TriggerClientEvent('qb-houses:client:RequestRing', src)
end)


