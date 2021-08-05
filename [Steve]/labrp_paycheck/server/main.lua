ESX		= nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.UseEsExtendedType then
	RegisterServerEvent('brinn_paycheck:AddMoneyEs_Extended')
	AddEventHandler('brinn_paycheck:AddMoneyEs_Extended',function(xPlayer, value)
		if xPlayer ~= nil then
			MySQL.Async.fetchAll('SELECT `collectmoney` FROM users WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier
			}, function(result)
				local paycheckbd = {}
				if result[1].collectmoney ~= nil then
					paycheckbd = json.decode(result[1].collectmoney)
				end
			MySQL.Async.fetchAll("UPDATE users SET collectmoney = @collectmoney WHERE identifier = @identifier",{
				['@identifier'] = xPlayer.identifier,
				['@collectmoney'] = paycheckbd + (value)
			})
			end)
		else 
			print(('Someone is trying to do something shady. [LABRP_PAYCHECK]'):format(xPlayer.identifier))
		end
	end)
end

RegisterServerEvent('brinn_paycheck:AddMoney')
AddEventHandler('brinn_paycheck:AddMoney',function(source, value)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		MySQL.Async.fetchAll('SELECT `collectmoney` FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			local paycheckbd = {}
			if result[1].collectmoney ~= nil then
				paycheckbd = json.decode(result[1].collectmoney)
			end
		MySQL.Async.fetchAll("UPDATE users SET collectmoney = @collectmoney WHERE identifier = @identifier",{
			['@identifier'] = xPlayer.identifier,
			['@collectmoney'] = paycheckbd + (value)
		})
		end)
	else 
		print(('Someone is trying to do something shady. [LABRP_PAYCHECK]'):format(xPlayer.identifier))
	end
end)



 RegisterNetEvent("brinn_paycheck:Payout")
 AddEventHandler("brinn_paycheck:Payout", function()
	local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		MySQL.Async.fetchAll('SELECT `collectmoney` FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
				local paycheckbd = 0
				if result[1].collectmoney ~= nil then
					paycheckbd = json.decode(result[1].collectmoney)
				end
				if paycheckbd > 0 then
					MySQL.Async.execute("UPDATE users SET collectmoney = @collectmoney WHERE identifier = @identifier",{
						['@identifier'] = xPlayer.identifier,
						['@collectmoney'] = 0
					})
					if Config.ReceiveInCash == true then
						xPlayer.addMoney(paycheckbd)
					else
						xPlayer.addAccountMoney('bank', paycheckbd)
					end
					local msg3 = 'You collect a paycheck of '..paycheckbd..'$'
					local type3 = 'success'
					TriggerClientEvent('brinn_paycheck:notification',_source,msg3,type3)
				else
					local msg4 = 'You dont have anything to collect.'
					local type4 = 'error'
					TriggerClientEvent('brinn_paycheck:notification',_source,msg4,type4)
				end
		end)
	else
		print(('Someone is trying to do something shady. [LABRP_PAYCHECK]'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent("paycheck:getamount")
AddEventHandler("paycheck:getamount", function()
   local _source = source
   local xPlayer  = ESX.GetPlayerFromId(_source)
   if xPlayer ~= nil then
	   MySQL.Async.fetchAll('SELECT `collectmoney` FROM users WHERE identifier = @identifier', {
		   ['@identifier'] = xPlayer.identifier
	   }, function(result)
			   local paycheckbd = 0
			   if result[1].collectmoney ~= nil then
				   paycheckbd = json.decode(result[1].collectmoney)
			   end
			   TriggerClientEvent('paycheck:pendingmoney', _source, paycheckbd)
	   end)
   else
	   print(('Someone is trying to do something shady. [LABRP_PAYCHECK]'):format(xPlayer.identifier))
   end
end)