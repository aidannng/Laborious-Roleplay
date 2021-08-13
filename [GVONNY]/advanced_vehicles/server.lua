ESX 					= nil
TriggerEvent(Config.ESX.ESXSHAREDOBJECT, function(obj) ESX = obj end)

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

Citizen.CreateThread(function()
	Wait(5000)
	if Config.createTable == true then
		MySQL.Async.execute([[
			CREATE TABLE IF NOT EXISTS `advanced_vehicles` (
				`vehicle` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				`user_id` VARCHAR(55) NOT NULL,
				`plate` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				`km` DOUBLE UNSIGNED NOT NULL DEFAULT '0',
				`vehicle_handling` LONGTEXT NOT NULL COLLATE 'utf8mb4_general_ci',
				`nitroAmount` INT(11) NOT NULL DEFAULT '0',
				`nitroRecharges` INT(11) NOT NULL DEFAULT '0',
				PRIMARY KEY (`vehicle`, `user_id`, `plate`) USING BTREE
			)
			COLLATE='utf8mb4_general_ci'
			ENGINE=InnoDB;

			CREATE TABLE IF NOT EXISTS `advanced_vehicles_inspection` (
				`vehicle` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				`user_id` VARCHAR(55) NOT NULL,
				`plate` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				`item` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				`km` INT(10) UNSIGNED NOT NULL DEFAULT '0',
				`value` DOUBLE UNSIGNED NOT NULL DEFAULT '0',
				`timer` INT(10) UNSIGNED NOT NULL DEFAULT '0',
				PRIMARY KEY (`vehicle`, `user_id`, `plate`, `item`) USING BTREE
			)
			COLLATE='utf8mb4_general_ci'
			ENGINE=InnoDB;

			CREATE TABLE IF NOT EXISTS `advanced_vehicles_services` (
				`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
				`vehicle` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				`user_id` VARCHAR(55) NOT NULL,
				`plate` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				`item` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
				`name` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
				`km` INT(11) UNSIGNED NOT NULL DEFAULT '0',
				`img` VARCHAR(255) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
				`timer` INT(10) UNSIGNED NOT NULL DEFAULT '0',
				PRIMARY KEY (`id`) USING BTREE,
				INDEX `vehicle` (`vehicle`) USING BTREE,
				INDEX `user_id` (`user_id`) USING BTREE,
				INDEX `plate` (`plate`) USING BTREE
			)
			COLLATE='utf8mb4_general_ci'
			ENGINE=InnoDB;
			
			CREATE TABLE IF NOT EXISTS `advanced_vehicles_upgrades` (
				`vehicle` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				`user_id` VARCHAR(55) NOT NULL,
				`plate` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				`class` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				`item` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				PRIMARY KEY (`vehicle`, `user_id`, `plate`, `class`) USING BTREE
			)
			COLLATE='utf8mb4_general_ci'
			ENGINE=InnoDB;
		]])
	end
end)

local vehiclesHandlingsOriginal = {}

RegisterServerEvent('advanced_vehicles:getVehicleData')
AddEventHandler('advanced_vehicles:getVehicleData', function(vehicleDataClient)
	local source = source
	MySQL.Async.fetchAll("SELECT owner as user_id FROM owned_vehicles WHERE plate = @vehicle_plate", {['@vehicle_plate'] = vehicleDataClient.plate}, function(vehiclequery)
		if vehiclequery[1] then
			local owner_id = vehiclequery[1].user_id
			local vehicleData = getVehicleData(vehicleDataClient,owner_id)
			TriggerClientEvent('advanced_vehicles:LixeiroCB', source, {[1] = vehicleData})
		else
			TriggerClientEvent('advanced_vehicles:LixeiroCB', source, false)
		end
	end)
end)

RegisterServerEvent('advanced_vehicles:setVehicleData')
AddEventHandler('advanced_vehicles:setVehicleData', function(vehicleData,vehicleHandling)
	local source = source
	MySQL.Async.fetchAll("SELECT owner as user_id FROM owned_vehicles WHERE plate = @vehicle_plate", {['@vehicle_plate'] = vehicleData.plate}, function(vehiclequery)
		if vehiclequery[1] then
			local owner_id = vehiclequery[1].user_id
			vehicleData.km = string.format("%.2f",(vehicleData.km/1000))
			local sql = "UPDATE `advanced_vehicles` SET km = @km, vehicle_handling = @vehicleHandling, nitroAmount = @nitroAmount, nitroRecharges = @nitroRecharges WHERE vehicle = @vehicle AND user_id = @user_id AND plate = @plate";
			MySQL.Sync.execute(sql, {['@km'] = vehicleData.km, ['@vehicleHandling'] = json.encode(vehicleHandling), ['@nitroAmount'] = vehicleData.nitroAmount, ['@nitroRecharges'] = vehicleData.nitroRecharges, ['@vehicle'] = vehicleData.name, ['@user_id'] = owner_id, ['@plate'] = vehicleData.plate});
		end
	end)
end)

RegisterServerEvent('advanced_vehicles:setGlobalVehicleHandling')
AddEventHandler('advanced_vehicles:setGlobalVehicleHandling', function(name,handlings)
	if not vehiclesHandlingsOriginal[name] then vehiclesHandlingsOriginal[name] = {} end
	vehiclesHandlingsOriginal[name] = handlings
	TriggerClientEvent('advanced_vehicles:setGlobalVehicleHandling', -1, name, handlings)
end)

local cancelled = false
local cooldown = {}
RegisterServerEvent('advanced_vehicles:makeAction')
AddEventHandler('advanced_vehicles:makeAction', function(vehicleData,data,firstStep)
	local source = source
	if cooldown[source] == nil then
		cooldown[source] = true
		local xPlayer = ESX.GetPlayerFromId(source)
		local user_id = xPlayer.identifier
		MySQL.Async.fetchAll("SELECT owner as user_id FROM owned_vehicles WHERE plate = @vehicle_plate", {['@vehicle_plate'] = vehicleData.plate}, function(vehiclequery)
			if vehiclequery[1] then
				local owner_id = vehiclequery[1].user_id
				if data.action == 'Repair' then
					local maintenance = {}
					if Config.maintenance[vehicleData.name] then
						maintenance = Config.maintenance[vehicleData.name][data.idname]
					else
						maintenance = Config.maintenance['default'][data.idname]
					end
					if xPlayer.getInventoryItem(maintenance.repair_item.name).count >= maintenance.repair_item.amount then
						if firstStep then
							TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
						else
							TriggerClientEvent("progress",source,maintenance.repair_item.time*1000,Lang[Config.lang]['service_progress'])
							cancelled = false
							Citizen.Wait(maintenance.repair_item.time*1000)

							if cancelled == false and xPlayer.getInventoryItem(maintenance.repair_item.name).count >= maintenance.repair_item.amount then
								xPlayer.removeInventoryItem(maintenance.repair_item.name,maintenance.repair_item.amount)
								local sql = "INSERT INTO `advanced_vehicles_services` (vehicle,user_id,plate,item,name,km,img,timer) VALUES (@vehicle,@user_id,@plate,@item,@name,@km,@img,@timer)";
								MySQL.Sync.execute(sql, {['@user_id'] = owner_id, ['@vehicle'] = vehicleData.name, ['@plate'] = vehicleData.plate, ['@item'] = data.idname, ['@name'] = data.name, ['@km'] = math.floor(vehicleData.km/1000), ['@img'] = data.img, ['@timer'] = os.time()});
								local sql = "REPLACE INTO `advanced_vehicles_inspection` (vehicle,user_id,plate,item,km,value,timer) VALUES (@vehicle,@user_id,@plate,@item,@km,@value,@timer)";
								MySQL.Sync.execute(sql, {['@user_id'] = owner_id, ['@vehicle'] = vehicleData.name, ['@plate'] = vehicleData.plate, ['@item'] = data.idname, ['@km'] = math.floor(vehicleData.km/1000), ['@value'] = 100, ['@timer'] = os.time()});

								TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
								TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = Lang[Config.lang]['service_done'], style = { ['background-color'] = '#18b70b', ['color'] = '#FFFFFF' } })
								TriggerClientEvent('repair:tires', source)

								--TriggerClientEvent("advanced_vehicles:Notify",source,"sucesso",Lang[Config.lang]['service_done'])
								SendWebhookMessage(Config.webhook,Lang[Config.lang]['service_action']:format(data.idname,vehicleData.name,math.floor(vehicleData.km/1000),owner_id,user_id..os.date("\n["..Lang[Config.lang]['logs_date'].."]: %d/%m/%Y ["..Lang[Config.lang]['logs_hour'].."]: %H:%M:%S")))
							else
								TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
								TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Lang[Config.lang]['service_cancel'], style = {} })

								--TriggerClientEvent("advanced_vehicles:Notify",source,"negado",Lang[Config.lang]['service_cancel'])

							end
						end
					else
						--TriggerClientEvent('advanced_vehicles:Notify', source, "negado", Lang[Config.lang]['not_enough_items']:format(maintenance.repair_item.amount,maintenance.repair_item.name))
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Lang[Config.lang]['not_enough_items']:format(maintenance.repair_item.amount,maintenance.repair_item.name), style = {} })

					end
				elseif data.action == 'Inspection' then
					if Config.itemToInspect == false or xPlayer.getInventoryItem(Config.itemToInspect).count >= 1 then
						local maintenance = {}
						if Config.maintenance[vehicleData.name] then
							maintenance = Config.maintenance[vehicleData.name][data.idname]
						else
							maintenance = Config.maintenance['default'][data.idname]
						end
						if firstStep then
							TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
						else
							TriggerClientEvent("progress",source,maintenance.repair_item.time*1000,Lang[Config.lang]['inpect_progress'])
							cancelled = false
							Citizen.Wait(maintenance.repair_item.time*1000)

							if cancelled == false then
								local percentage = 0
								km_to_next_service = math.ceil(((vehicleData.km - ((maintenance.lifespan*1000) + ((vehicleData.services[data.idname][1] or 0)*1000)))/1000)*-1)
								if km_to_next_service > 0 then
									percentage = (km_to_next_service*100)/maintenance.lifespan
								end
								percentage = string.format("%.2f",percentage)

								local sql = "REPLACE INTO `advanced_vehicles_inspection` (vehicle,user_id,plate,item,km,value,timer) VALUES (@vehicle,@user_id,@plate,@item,@km,@value,@timer)";
								MySQL.Sync.execute(sql, {['@user_id'] = owner_id, ['@vehicle'] = vehicleData.name, ['@plate'] = vehicleData.plate, ['@item'] = data.idname, ['@km'] = math.floor(vehicleData.km/1000), ['@value'] = percentage, ['@timer'] = os.time()});

								TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
								TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = Lang[Config.lang]['inpect_done'], style = { ['background-color'] = '#18b70b', ['color'] = '#FFFFFF' } })

								--TriggerClientEvent("advanced_vehicles:Notify",source,"sucesso",Lang[Config.lang]['inpect_done'])
							else
								TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
								TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Lang[Config.lang]['inpect_cancel'], style = {} })

								--TriggerClientEvent("advanced_vehicles:Notify",source,"negado",Lang[Config.lang]['inpect_cancel'])
							end
						end
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Lang[Config.lang]['no_scanner'], style = {} })

						--TriggerClientEvent('advanced_vehicles:Notify', source, "negado", Lang[Config.lang]['no_scanner'])
					end
				elseif data.action == 'Upgrade' then
					local upgrades = {}
					if Config.upgrades[vehicleData.name] then
						upgrades = Config.upgrades[vehicleData.name][data.idname]
					else
						upgrades = Config.upgrades['default'][data.idname]
					end
					if xPlayer.getInventoryItem(upgrades.item.name).count >= upgrades.item.amount then
						if firstStep then
							TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
						else
							TriggerClientEvent("progress",source,upgrades.item.time*1000,Lang[Config.lang]['upgrade_progress'])
							cancelled = false
							Citizen.Wait(upgrades.item.time*1000)

							if cancelled == false and xPlayer.getInventoryItem(upgrades.item.name).count >= upgrades.item.amount then
								xPlayer.removeInventoryItem(upgrades.item.name,upgrades.item.amount)
								if upgrades.improvements.type == 'nitrous' then
									local sql = "UPDATE `advanced_vehicles` SET `nitroAmount` = @nitroAmount, `nitroRecharges` = @nitroRecharges WHERE  `vehicle` = @vehicle AND `user_id` = @user_id AND `plate` = @plate;";
									MySQL.Sync.execute(sql, {['@user_id'] = owner_id, ['@vehicle'] = vehicleData.name, ['@plate'] = vehicleData.plate, ['@nitroAmount'] = Config.NitroAmount, ['@nitroRecharges'] = Config.NitroRechargeAmount});
								else
									TriggerClientEvent("advanced_vehicles:upgradeCar",source,upgrades.improvements,data.idname)
								end

								local sql = "REPLACE INTO `advanced_vehicles_upgrades` (vehicle,user_id,plate,class,item) VALUES (@vehicle,@user_id,@plate,@class,@item)";
								MySQL.Sync.execute(sql, {['@user_id'] = owner_id, ['@vehicle'] = vehicleData.name, ['@plate'] = vehicleData.plate, ['@class'] = upgrades.class, ['@item'] = data.idname});

								TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
								--TriggerClientEvent("advanced_vehicles:Notify",source,"sucesso",Lang[Config.lang]['upgrade_done'])

								TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = Lang[Config.lang]['upgrade_done'], style = { ['background-color'] = '#18b70b', ['color'] = '#FFFFFF' } })

								SendWebhookMessage(Config.webhook,Lang[Config.lang]['upgrade_action']:format(data.idname,vehicleData.name,math.floor(vehicleData.km/1000),owner_id,user_id..os.date("\n["..Lang[Config.lang]['logs_date'].."]: %d/%m/%Y ["..Lang[Config.lang]['logs_hour'].."]: %H:%M:%S")))
							else
								TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
								--TriggerClientEvent("advanced_vehicles:Notify",source,"negado",Lang[Config.lang]['upgrade_cancel'])
								TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Lang[Config.lang]['upgrade_cancel'], style = {} })

							end
						end
					else
						--TriggerClientEvent('advanced_vehicles:Notify', source, "negado", Lang[Config.lang]['not_enough_items']:format(upgrades.item.amount,upgrades.item.name))
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Lang[Config.lang]['not_enough_items']:format(upgrades.item.amount,upgrades.item.name), style = {} })

					end
				elseif data.action == 'Downgrade' then
					local upgrades = {}
					if Config.upgrades[vehicleData.name] then
						upgrades = Config.upgrades[vehicleData.name][data.idname]
					else
						upgrades = Config.upgrades['default'][data.idname]
					end
					local sql = "SELECT item FROM `advanced_vehicles_upgrades` WHERE vehicle = @vehicle AND user_id = @user_id AND plate = @plate AND class = @class";
					local query = MySQL.Sync.fetchAll(sql, {['@user_id'] = owner_id, ['@vehicle'] = vehicleData.name, ['@plate'] = vehicleData.plate, ['@class'] = upgrades.class});
					if query[1] and query[1].item == data.idname then
						if firstStep then
							TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
						else
							TriggerClientEvent("progress",source,upgrades.item.time*1000,Lang[Config.lang]['downgrade_progress'])
							cancelled = false
							Citizen.Wait(upgrades.item.time*1000)

							local sql = "SELECT item FROM `advanced_vehicles_upgrades` WHERE vehicle = @vehicle AND user_id = @user_id AND plate = @plate AND class = @class";
							local query = MySQL.Sync.fetchAll(sql, {['@user_id'] = owner_id, ['@vehicle'] = vehicleData.name, ['@plate'] = vehicleData.plate, ['@class'] = upgrades.class});
							if query[1] and query[1].item == data.idname then
								if cancelled == false then
									if upgrades.improvements.type == 'nitrous' then
										local sql = "SELECT nitroAmount, nitroRecharges FROM `advanced_vehicles` WHERE vehicle = @vehicle AND user_id = @user_id AND plate = @plate";
										local query = MySQL.Sync.fetchAll(sql, {['@user_id'] = owner_id, ['@vehicle'] = vehicleData.name, ['@plate'] = vehicleData.plate});
										if query[1] and query[1].nitroAmount >= Config.NitroAmount and query[1].nitroRecharges >= Config.NitroRechargeAmount then
											local sql = "UPDATE `advanced_vehicles` SET nitroAmount = @nitroAmount, nitroRecharges = @nitroRecharges WHERE vehicle = @vehicle AND user_id = @user_id AND plate = @plate";
											MySQL.Sync.execute(sql, {['@nitroAmount'] = 0, ['@nitroRecharges'] = 0, ['@vehicle'] = vehicleData.name, ['@user_id'] = owner_id, ['@plate'] = vehicleData.plate});
										else
											--TriggerClientEvent("advanced_vehicles:Notify",source,"negado",Lang[Config.lang]['downgrade_used_nitro'])
											TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Lang[Config.lang]['downgrade_used_nitro'], style = {} })

											TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
											return
										end
									end

									TriggerClientEvent("advanced_vehicles:removeUpgrade",source,upgrades.improvements)

									local sql = "DELETE FROM `advanced_vehicles_upgrades` WHERE vehicle = @vehicle AND user_id = @user_id AND plate = @plate AND class = @class";
									MySQL.Sync.execute(sql, {['@user_id'] = owner_id, ['@vehicle'] = vehicleData.name, ['@plate'] = vehicleData.plate, ['@class'] = upgrades.class});

									xPlayer.addInventoryItem(upgrades.item.name, upgrades.item.amount)
									TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
									--TriggerClientEvent("advanced_vehicles:Notify",source,"sucesso",Lang[Config.lang]['downgrade_done'])
									TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = Lang[Config.lang]['downgrade_done'], style = { ['background-color'] = '#18b70b', ['color'] = '#FFFFFF' } })

									SendWebhookMessage(Config.webhook,Lang[Config.lang]['downgrade_action']:format(data.idname,vehicleData.name,math.floor(vehicleData.km/1000),owner_id,user_id..os.date("\n["..Lang[Config.lang]['logs_date'].."]: %d/%m/%Y ["..Lang[Config.lang]['logs_hour'].."]: %H:%M:%S")))
								else
									TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
									--TriggerClientEvent("advanced_vehicles:Notify",source,"negado",Lang[Config.lang]['downgrade_canceled'])
									TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Lang[Config.lang]['downgrade_canceled'], style = {} })

								end
							else
								TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Lang[Config.lang]['downgrade_error'], style = {} })

								--TriggerClientEvent('advanced_vehicles:Notify', source, "negado", Lang[Config.lang]['downgrade_error'])
							end
						end
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Lang[Config.lang]['downgrade_error'], style = {} })

						--TriggerClientEvent('advanced_vehicles:Notify', source, "negado", Lang[Config.lang]['downgrade_error'])
					end
				elseif Config.repair[data.repair] then
					local missingItems = false
					local items = ""
					for k,v in pairs(Config.repair[data.repair].items) do
						if xPlayer.getInventoryItem(k).count < v then
							missingItems = true
							if items == "" then
								items = v.."x "..k
							else
								items = items..", "..v.."x "..k
							end
						end
					end
					if not missingItems then
						if firstStep then
							TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
						else
							for k,v in pairs(Config.repair[data.repair].items) do
								xPlayer.removeInventoryItem(k,v)
							end
							TriggerClientEvent("progress",source,Config.repair[data.repair].time*1000,Lang[Config.lang]['repair_progress'])
							cancelled = false
		
							Citizen.Wait(Config.repair[data.repair].time*1000)
							if cancelled == false then
								TriggerClientEvent("advanced_vehicles:repairCar",source,data.repair)
								--TriggerClientEvent("advanced_vehicles:Notify",source,"sucesso",Lang[Config.lang]['repair_done'])
								TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = Lang[Config.lang]['repair_done'], style = { ['background-color'] = '#18b70b', ['color'] = '#FFFFFF' } })

								SendWebhookMessage(Config.webhook,Lang[Config.lang]['repair_action']:format(data.repair,vehicleData.name,math.floor(vehicleData.km/1000),owner_id,user_id..os.date("\n["..Lang[Config.lang]['logs_date'].."]: %d/%m/%Y ["..Lang[Config.lang]['logs_hour'].."]: %H:%M:%S")))
							else
								--TriggerClientEvent("advanced_vehicles:Notify",source,"negado",Lang[Config.lang]['repair_cancel'])
								TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Lang[Config.lang]['repair_cancel'], style = {} })

							end
							TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
						end
					else
						--TriggerClientEvent('advanced_vehicles:Notify', source, "negado", Lang[Config.lang]['not_enough_items_2']:format(items))
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Lang[Config.lang]['not_enough_items_2']:format(items), style = {} })

					end
				else
					print('Undefined action '..data.action )
				end
			end
			cooldown[source] = nil
		end)
	end
end)

RegisterServerEvent('advanced_vehicles:removeNitroUpgrade')
AddEventHandler('advanced_vehicles:removeNitroUpgrade', function(vehicleData)
	local source = source
	MySQL.Async.fetchAll("SELECT owner as user_id FROM owned_vehicles WHERE plate = @vehicle_plate", {['@vehicle_plate'] = vehicleData.plate}, function(vehiclequery)
		local owner_id = vehiclequery[1].user_id
		local upgrades = {}
		if Config.upgrades[vehicleData.name] then
			upgrades = Config.upgrades[vehicleData.name]
		else
			upgrades = Config.upgrades['default']
		end
		for k,v in pairs(upgrades) do 
			if v.improvements.type == 'nitrous' then
				local sql = "DELETE FROM `advanced_vehicles_upgrades` WHERE vehicle = @vehicle AND user_id = @user_id AND plate = @plate AND class = @class";
				MySQL.Sync.execute(sql, {['@user_id'] = owner_id, ['@vehicle'] = vehicleData.name, ['@plate'] = vehicleData.plate, ['@class'] = v.class});
				local sql = "UPDATE `advanced_vehicles` SET nitroAmount = @nitroAmount, nitroRecharges = @nitroRecharges WHERE vehicle = @vehicle AND user_id = @user_id AND plate = @plate";
				MySQL.Sync.execute(sql, {['@nitroAmount'] = 0, ['@nitroRecharges'] = 0, ['@vehicle'] = vehicleData.name, ['@user_id'] = owner_id, ['@plate'] = vehicleData.plate});

				local vehicleData = getVehicleData(vehicleData,owner_id)
				TriggerClientEvent('advanced_vehicles:LixeiroCB', source, {[1] = vehicleData})
			end
		end
	end)
end)

function getVehicleData(vehicleDataClient,user_id)
	local services = {}
	local query_services = {}
	local inspection = {}
	local upgrades = {}
	local sql = "SELECT km, vehicle_handling, nitroAmount, nitroRecharges FROM `advanced_vehicles` WHERE vehicle = @vehicle AND user_id = @user_id AND plate = @plate";
	local query = MySQL.Sync.fetchAll(sql, {['@vehicle'] = vehicleDataClient.name, ['@user_id'] = user_id, ['@plate'] = vehicleDataClient.plate});

	if not query or not query[1] then
		local sql = "INSERT INTO `advanced_vehicles` (user_id,vehicle,plate,vehicle_handling) VALUES (@user_id,@vehicle,@plate,@vehicle_handling)";
		MySQL.Sync.execute(sql, {['@vehicle'] = vehicleDataClient.name, ['@user_id'] = user_id, ['@plate'] = vehicleDataClient.plate, ['@vehicle_handling'] = '{}'});

		local sql = "SELECT km, vehicle_handling, nitroAmount, nitroRecharges FROM `advanced_vehicles` WHERE vehicle = @vehicle AND user_id = @user_id AND plate = @plate";
		query = MySQL.Sync.fetchAll(sql, {['@vehicle'] = vehicleDataClient.name, ['@user_id'] = user_id, ['@plate'] = vehicleDataClient.plate});
	else
		local sql = "SELECT item, name, km, timer, img FROM `advanced_vehicles_services` WHERE vehicle = @vehicle AND user_id = @user_id AND plate = @plate ORDER BY timer DESC";
		query_services = MySQL.Sync.fetchAll(sql, {['@vehicle'] = vehicleDataClient.name, ['@user_id'] = user_id, ['@plate'] = vehicleDataClient.plate});
		local cont = {}
		for k,v in pairs(query_services) do
			if not services[v.item] then services[v.item] = {} end
			services[v.item][cont[v.item] or 1] = v.km
			cont[v.item] = (cont[v.item] or 1) + 1
		end

		local sql = "SELECT item, km, value, timer FROM `advanced_vehicles_inspection` WHERE vehicle = @vehicle AND user_id = @user_id AND plate = @plate";
		local query_inspection = MySQL.Sync.fetchAll(sql, {['@vehicle'] = vehicleDataClient.name, ['@user_id'] = user_id, ['@plate'] = vehicleDataClient.plate});
		for k,v in pairs(query_inspection) do
			inspection[v.item] = v
		end

		local sql = "SELECT item FROM `advanced_vehicles_upgrades` WHERE vehicle = @vehicle AND user_id = @user_id AND plate = @plate";
		local query_upgrades = MySQL.Sync.fetchAll(sql, {['@vehicle'] = vehicleDataClient.name, ['@user_id'] = user_id, ['@plate'] = vehicleDataClient.plate});
		for k,v in pairs(query_upgrades) do
			upgrades[v.item] = v
		end
	end

	vehicleData = query[1]
	vehicleData.services = services
	vehicleData.servicesNUI = query_services
	vehicleData.inspectionNUI = inspection
	vehicleData.upgradesNUI = upgrades
	vehicleData.plate = vehicleDataClient.plate
	vehicleData.name = vehicleDataClient.name
	vehicleData.veh = vehicleDataClient.veh
	vehicleData.km = vehicleData.km*1000
	vehicleData.loaded = true
	return vehicleData
end

RegisterNetEvent('advanced_vehicles:__sync')
AddEventHandler('advanced_vehicles:__sync', function (boostEnabled, purgeEnabled, lastVehicle)
  -- Fix for source reference being lost during loop below.
  local source = source

  for _, player in ipairs(GetPlayers()) do
    if player ~= tostring(source) then
      TriggerClientEvent('advanced_vehicles:__update', player, source, boostEnabled, purgeEnabled, lastVehicle)
    end
  end
end)

local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function dec(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
    end))
end

function print_table(node)
	if type(node) == 'table' then
		-- to make output beautiful
		local function tab(amt)
			local str = ""
			for i=1,amt do
				str = str .. "\t"
			end
			return str
		end

		local cache, stack, output = {},{},{}
		local depth = 1
		local output_str = "{\n"

		while true do
			local size = 0
			for k,v in pairs(node) do
				size = size + 1
			end

			local cur_index = 1
			for k,v in pairs(node) do
				if (cache[node] == nil) or (cur_index >= cache[node]) then
				
					if (string.find(output_str,"}",output_str:len())) then
						output_str = output_str .. ",\n"
					elseif not (string.find(output_str,"\n",output_str:len())) then
						output_str = output_str .. "\n"
					end

					-- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
					table.insert(output,output_str)
					output_str = ""
				
					local key
					if (type(k) == "number" or type(k) == "boolean") then
						key = "["..tostring(k).."]"
					else
						key = "['"..tostring(k).."']"
					end

					if (type(v) == "number" or type(v) == "boolean") then
						output_str = output_str .. tab(depth) .. key .. " = "..tostring(v)
					elseif (type(v) == "table") then
						output_str = output_str .. tab(depth) .. key .. " = {\n"
						table.insert(stack,node)
						table.insert(stack,v)
						cache[node] = cur_index+1
						break
					else
						output_str = output_str .. tab(depth) .. key .. " = '"..tostring(v).."'"
					end

					if (cur_index == size) then
						output_str = output_str .. "\n" .. tab(depth-1) .. "}"
					else
						output_str = output_str .. ","
					end
				else
					-- close the table
					if (cur_index == size) then
						output_str = output_str .. "\n" .. tab(depth-1) .. "}"
					end
				end

				cur_index = cur_index + 1
			end

			if (#stack > 0) then
				node = stack[#stack]
				stack[#stack] = nil
				depth = cache[node] == nil and depth + 1 or depth - 1
			else
				break
			end
		end

		-- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
		table.insert(output,output_str)
		output_str = table.concat(output)

		print(output_str)
	else
		print(node)
	end
end