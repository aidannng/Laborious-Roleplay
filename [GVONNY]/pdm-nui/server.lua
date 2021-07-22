ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)

        --MySQL.Async.fetchAll("SELECT a.plate, a.x, a.y, a.z, a.rotation, b.model FROM pdm_showroom a, bbvehicles b WHERE a.plate = b.plate", {}, function(vehicles)
        --[[ MySQL.Async.fetchAll("SELECT slot_id FROM pdm_showroom", {}, function(vehicles)
            if(vehicles ~= nil and #vehicles > 0) then
                for x=1,#vehicles,1 do
                    MySQL.Async.execute("UPDATE pdm_shoroom SET plate = NULL WHERE slot_id = @slotid", {['@slotid'] = vehicles[x].slot_id})
                end
            end
        end) ]]
    end
end)

local discord_webhook = {url = "https://discord.com/api/webhooks/863790069059813406/RGXqIdef_TAWX8L1WxI04yFUc35-9cCrkx9-SQFf6vJNbSBildiYnJ0b85UTfJQXTdwK",image = "https://i.iodine.gg/i5fba.png"}

RegisterServerEvent("getallvehicles")
AddEventHandler("getallvehicles", function()
    local src = source

    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name
    local jobgrade = tonumber(xPlayer.job.grade)

    if(job == 'cardealer' and jobgrade > 2) then
        MySQL.Async.fetchAll("SELECT DISTINCT(category) FROM vehicles ORDER BY category", {} ,function(result)
            if(#result > 0) then
                for x=1,#result,1 do 
                    TriggerClientEvent("pdm:purchaselist", src, result[x].category, x)

                    MySQL.Async.fetchAll("SELECT name, model, price, category FROM vehicles WHERE category = @category AND stock > 0", {['@category'] = result[x].category} ,function(result2)
                        for y=1, #result2,1 do
                            TriggerClientEvent('pdm:addtopurchaselist', src, result2[y].category, result2[y].model, result2[y].name, result2[y].price)
                        end
                    end)
                end
            end
        end)
    end
end)


RegisterServerEvent("purchase")
AddEventHandler("purchase", function(model, price, plate)
    local src = source

    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name
    local jobgrade = tonumber(xPlayer.job.grade)
    if(job == "cardealer" and jobgrade > 2) then 
        MySQL.Async.fetchAll("SELECT amount FROM jobs WHERE name = 'cardealer'", {} ,function(result)
            local balance = result[1].amount - price

            MySQL.Async.execute("UPDATE jobs SET amount = @money WHERE name = 'cardealer'", {['@money'] = balance})
        end)

        MySQL.Async.fetchAll("SELECT stock FROM vehicles WHERE model = @model", {['@model'] = model}, function(result2)
            local stock = tonumber(result2[1].stock)
            if(stock > 0) then
                stock = stock - 1
            end

            local markup = tonumber(price) * (1 + tonumber(.6))
        
            MySQL.Async.execute("UPDATE vehicles SET stock = @stock WHERE model = @model", {['@stock'] = stock, ['@model'] = model})
            MySQL.Async.execute("INSERT INTO cardealer_vehicles SET plate = @plate, price = @price, test_drive = false", {['@plate'] = plate, ['@price'] = markup})
            
            PerformHttpRequest(discord_webhook.url, 
            function(err, text, header) end, 
            'POST', 
            json.encode({username = "LABRP | PDM Logs", content = "**" .. xPlayer.getName() .. "**(".. xPlayer.identifier .. ") has purchased a **" .. model .. "** with the plate **" .. plate .. "** for **$" .. price .. "** and is now in the PDM stock.", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 

        end)
    end
end)

RegisterServerEvent('pdmbuy')
AddEventHandler('pdmbuy', function(props, stats, model)
    local src = source
    MySQL.Async.execute("INSERT INTO bbvehicles (identifier, plate, model, props, stats, state) VALUES ('PDM', '"..props.plate.."', '"..model.."', '"..json.encode(props).."', '"..stats.."', 'PDM')")
end)

RegisterServerEvent("getallstock")
AddEventHandler("getallstock", function()
    local src = source

    local canshowcar = false
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name
    local jobgrade = tonumber(xPlayer.job.grade)

    if(job == 'cardealer' and jobgrade > 0) then
        canshowcar = true
    end

    MySQL.Async.fetchAll("SELECT a.plate, a.price, a.test_drive, c.name FROM cardealer_vehicles a, bbvehicles b, vehicles c WHERE a.plate = b.plate AND b.model = c.model ORDER BY c.name", {} ,function(result)
        if(#result>0) then
            for x=1,#result,1 do 
                local plate = result[x].plate
                local price = result[x].price
                local finance = price * .25
                local name = result[x].name
                local testdrive = result[x].test_drive

                TriggerClientEvent("pdm:addtostocklist", src, name, plate, price, canshowcar, finance, testdrive)
            end 
        end
    end)
end)

RegisterServerEvent("getvehiclemodels")
AddEventHandler("getvehiclemodels", function(category)
    local src = source
    MySQL.Async.fetchAll("SELECT name, model FROM vehicles WHERE category = @category ORDER BY name", {['@category'] = category},function(result)
        if(#result>0) then
            for x=1,#result,1 do
                local name = result[x].name
                local model = result[x].model
                TriggerClientEvent("pdm:addtomodeldropdown", src, model, name)
            end
        end
    end)
end)

RegisterServerEvent("getshowroom")
AddEventHandler("getshowroom", function()
    local src = source
    local cantestdrive = false

    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name
    local jobgrade = tonumber(xPlayer.job.grade)

    if(job == "cardealer" and jobgrade > 0) then
        cantestdrive = true
    end

    MySQL.Async.fetchAll("SELECT a.slot_id as slot_id, a.plate as plate, c.name as name FROM pdm_showroom a, bbvehicles b, vehicles c WHERE a.plate = b.plate and b.model = c.model ORDER BY slot_id", {} ,function(result)
        if(#result ~= nil) then
            for x=1,#result,1 do
                local slot_id = result[x].slot_id
                local plate = result[x].plate
                local name = result[x].name
                TriggerClientEvent("pdm:addtoshowroomlist", src, slot_id, plate, name, cantestdrive)
            end
        end
    end)
end)

RegisterServerEvent("removefromshowroom")
AddEventHandler("removefromshowroom", function(slotid)
    local src = source
    MySQL.Async.execute("UPDATE pdm_showroom SET plate = NULL WHERE slot_id = @slotid", {['@slotid'] = slotid})
    TriggerClientEvent("pdm:refreshshowroom", src)

    MySQL.Async.fetchAll("SELECT x, y, z, slot_id, plate FROM pdm_showroom WHERE slot_id = @slot",{['@slot']=slotid}, function(result)
        local slot = result[1].slot_id
        --local x = result[1].x
        --local y = result[1].y
        --local z = result[1].z

        MySQL.Async.execute("UPDATE pdm_showroom SET plate = NULL WHERE slot_id = @slotid", {['@slotid'] = slot})
        
        --print("plain remove from showroom")
        --print("server trigger despawn vehicle from showroom")
        --print("============================================")
        --TriggerClientEvent("pdm:despawnvehicle", src, x, y, z)
        TriggerClientEvent("pdm:despawnvehicle", src, slot)
    end)
end)

RegisterServerEvent("clearslot")
AddEventHandler("clearslot", function(slotid)
    local src = source
    MySQL.Async.execute("UPDATE pdm_showroom SET plate = NULL WHERE slot_id = @slotid", {['@slotid'] = slotid})
    TriggerClientEvent("pdm:refreshshowroom", src)
end)

RegisterServerEvent("movetoshowroom")
AddEventHandler("movetoshowroom", function(slotid, plate)
    --print("start moving to showroom")
    local src = source
    local oldslot

    --check if any slots have the plate already in the showroom
    MySQL.Async.fetchAll("SELECT x, y, z, slot_id, plate FROM pdm_showroom WHERE plate = @plate",{['@plate']=plate}, function(result)
        --if plate is already in showroom
        --print("is plate in showroom already:")
        --print(result ~= nil and #result>0)
        if(result ~= nil and #result>0) then
            local slot = result[1].slot_id

            oldslot = slot
            local x = result[1].x
            local y = result[1].y
            local z = result[1].z
            
            --if new plate is the same as the plate
            if(plate == result[1].plate) then
                TriggerClientEvent("mythic_notify:client:SendAlert", src, { type = 'error', text = "This vehicle is on the floor already", })

                --MySQL.Async.execute("UPDATE pdm_showroom SET plate = NULL WHERE slot_id = @slotid", {['@slotid'] = slot})
                --print("this vehicle is already in a slot")
                --print("despawn vehicle from current slot")
                --TriggerClientEvent("pdm:despawnvehicle", src, x, y, z)
            else
                print("doing this")
            end
        else
            --TriggerClientEvent("mythic_notify:client:SendAlert", src, { type = 'inform', text = "vehicle is not on the floor", })
            MySQL.Async.fetchAll("SELECT a.slot_id, a.x, a.y, a.z, a.plate, a.rotation, b.model FROM pdm_showroom a, bbvehicles b WHERE a.slot_id = @slotid AND b.plate = @plate",{['@slotid'] = slotid, ['@plate'] = plate}, function(result2)
                if(result2 ~= nil and #result2>0) then
                    local x = result2[1].x
                    local y = result2[1].y
                    local z = result2[1].z
                    local model = result2[1].model
                    local slot = result2[1].slot_id
                    local rotation = result2[1].rotation
                    
                    if(result2[1].plate ~= nil) then
                        --print(slot .. ". " .. result2[1].plate)
                        --print("there is a different car in the new slot already")
                        TriggerClientEvent("mythic_notify:client:SendAlert", src, { type = 'error', text = "There is a vehicle in that slot already", })
                    else
                        MySQL.Async.execute("UPDATE pdm_showroom SET plate = @plate WHERE slot_id = @slotid", {['@plate']= plate, ['@slotid'] = slotid})
                        --print("loading new car in selected slot")
                        --print("spawn vehicle in showroom")
                        --print("========================================")
                        TriggerClientEvent("pdm:spawnvehicle", src, x, y, z, model, plate, rotation)
                    end
                end
            end)
        end
    end)    
end)

RegisterServerEvent("createbill")
AddEventHandler("createbill", function(luckynumber, plate, price, termlength)
    local src = source
    local creator = ESX.GetPlayerFromId(src)
    local ower = ESX.GetPlayerFromId(luckynumber)

    if(ower ~= nil) then
        MySQL.Async.fetchAll("SELECT a.id, b.model FROM cardealer_vehicles a, bbvehicles b WHERE a.plate = @plate and b.plate = @plate", {['@plate'] = plate}, function(result)
            if(result ~= nil) then
                local model = result[1].model
                if(tonumber(termlength) > 0) then
                    local downpayment = math.floor(tonumber(price) *.25);
                    price = price - downpayment
            
                    local cash = math.floor(tonumber(ower.getInventoryItem('money').count))
            
                    if(cash >= downpayment) then
                        local termamount = price / termlength
            
                        MySQL.Async.execute("INSERT INTO billing (identifier, sender, target_type, target, label, amount, term_length, term_amount, term_payment, has_paid, term_days_left, days_overdue) VALUES (@ower, @biller, 'finance', 'cardealer', 'Vehicle Purchase', @price, @termlength, @termamount, '0', @haspaid, '28', '0')",{
                            ['@ower'] = ower.identifier,
                            ['@biller'] = creator.identifier,
                            ['@price'] = price,
                            ['@termlength'] = termlength,
                            ['@haspaid'] = false,
                            ['@termamount'] = termamount,
                        })
            
                        ower.removeInventoryItem('money', downpayment)
            
                        MySQL.Async.fetchAll("SELECT amount FROM jobs WHERE name = 'cardealer'", {}, function(result)
                            local balance = result[1].amount
                            balance = balance + downpayment
            
                            MySQL.Async.execute("UPDATE jobs SET amount = @money WHERE name = 'cardealer'", {['@money'] = balance})
                        end)

                        MySQL.Async.execute("UPDATE bbvehicles SET identifier = @identifier, state = 'unknown' WHERE plate = @plate", {['@identifier'] = ower.identifier, ['@plate'] = plate})
                        MySQL.Async.execute("DELETE FROM cardealer_vehicles WHERE plate = @plate", {['@plate'] = plate})
                        MySQL.Async.fetchAll("SELECT slot_id, x, y, z FROM pdm_showroom WHERE plate = @plate", {['@plate'] = plate}, function(result2)
                            if(result2 ~= nil and #result2 > 0) then
                                local slot = result2[1].slot_id
                                local x = result2[1].x
                                local y = result2[1].y
                                local z = result2[1].z

                                MySQL.Async.execute("UPDATE pdm_showroom SET plate = NULL WHERE plate = @plate", {['@plate'] = plate})
                                --print("removing car from showroom on purchase")
                                --TriggerClientEvent("pdm:despawnvehicle", src, x, y, z)
                            end
                        end)

                        MySQL.Async.fetchAll("SELECT model, plate FROM bbvehicles WHERE plate = @plate",{['@plate'] = plate}, function(vehicle)
                            if(vehicle ~= nil) then
                                local model = vehicle[1].model
                                local plate = vehicle[1].plate

                                --print("moving purchased car to back of garage")
                                --print("======================================")
                                TriggerClientEvent("vehicleshop.spawnVehicle", ower.source, model, plate)
                            end
                        end)
                        
                        TriggerClientEvent("pdm:refreshbilllist", src)

                        PerformHttpRequest(discord_webhook.url, 
                        function(err, text, header) end, 
                        'POST', 
                        json.encode({username = "LABRP | PDM Logs", content = "**" .. creator.getName() .. "**(".. creator.identifier .. ") has made a new bill for **" .. ower.getName() .. "**(" .. ower.identifier .. ") for a total of **$" .. price .. "** ", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
            
                    else
                        TriggerClientEvent("pdm:billerror", src, "Customer has insufficient funds")
                    end
                else
                    local cash = math.floor(tonumber(ower.getInventoryItem('money').count))

                    if(cash >= tonumber(price)) then
                        ower.removeInventoryItem('money', tonumber(price))

                        MySQL.Async.fetchAll("SELECT amount FROM jobs WHERE name = 'cardealer'", {}, function(result)
                            local balance = result[1].amount
                            balance = balance + tonumber(price)
            
                            MySQL.Async.execute("UPDATE jobs SET amount = @money WHERE name = 'cardealer'", {['@money'] = balance})
                        end)

                        MySQL.Async.execute("UPDATE bbvehicles SET identifier = @identifier, state = 'unknown' WHERE plate = @plate", {['@identifier'] = ower.identifier, ['@plate'] = plate})
                        MySQL.Async.execute("DELETE FROM cardealer_vehicles WHERE plate = @plate", {['@plate'] = plate})
                        MySQL.Async.fetchAll("SELECT slot_id, x, y, z FROM pdm_showroom WHERE plate = @plate", {['@plate'] = plate}, function(result2)
                            if(result2 ~= nil and #result2 > 0) then
                                local slot = result2[1].slot_id
                                local x = result2[1].x
                                local y = result2[1].y
                                local z = result2[1].z

                                MySQL.Async.execute("UPDATE pdm_showroom SET plate = NULL WHERE plate = @plate", {['@plate'] = plate})
                                --print("removing car from showroom on purchase")
                                --TriggerClientEvent("pdm:despawnvehicle", src, x, y, z)
                            end
                        end)

                        MySQL.Async.fetchAll("SELECT model, plate FROM bbvehicles WHERE plate = @plate",{['@plate'] = plate}, function(vehicle)
                            if(vehicle ~= nil) then
                                local model = vehicle[1].model
                                local plate = vehicle[1].plate

                                --print("moving purchased car to back of garage")
                                --print("======================================")
                                TriggerClientEvent("vehicleshop.spawnVehicle", ower.source, model, plate)
                            end
                        end)

                        TriggerClientEvent("pdm:refreshbilllist", src)
                        PerformHttpRequest(discord_webhook.url, 
                        function(err, text, header) end, 
                        'POST', 
                        json.encode({username = "LABRP | PDM Logs", content = "**" .. creator.getName() .. "**(".. creator.identifier .. ") has sold a **" .. model ..  "** for $**".. price .."** with the plate **" .. plate .. "** in full to **" .. ower.getName() .. "**(" .. ower.identifier .. ")", avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 

                    else
                        TriggerClientEvent("pdm:billerror", src, "Customer has insufficient funds")
                    end
                end
            else
                TriggerClientEvent("pdm:billerror", src, "Plate is not registered in stock")
            end
        end)
    else
        TriggerClientEvent("pdm:billerror", src, "Lucky number is not in city")
    end
end)

RegisterServerEvent("getbills")
AddEventHandler("getbills", function()
    local src = source
    MySQL.Async.fetchAll("SELECT ower.firstname, ower.lastname, creator.firstname as employeefirstname, creator.lastname as employeelastname, billing.amount, billing.term_length, billing.days_overdue FROM users ower, billing, users creator  WHERE target = 'cardealer' and billing.identifier = ower.identifier AND billing.sender = creator.identifier AND billing.amount > 0",{}, function(result2)
        if(result2 ~= nil and #result2>0) then
            for x=1,#result2,1 do

                local firstname = result2[x].firstname
                local lastname = result2[x].lastname
                local employeefirstname = result2[x].employeefirstname
                local employeelastname = result2[x].employeelastname
                local amount = result2[x].amount
                local termlength = result2[x].term_length
                local daysoverdue = result2[x].days_overdue

                TriggerClientEvent("pdm:addtobillinglist", src, firstname, lastname, employeefirstname, employeelastname, amount, termlength, daysoverdue)
            end
        end
    end)
end)

RegisterServerEvent("spawntestdrive")
AddEventHandler("spawntestdrive", function(slot)
    --print("starting test drive")
    local src = source
    MySQL.Async.fetchAll("SELECT a.plate, b.model FROM pdm_showroom a, bbvehicles b WHERE a.slot_id = @slotid and a.plate = b.plate",{['@slotid'] = slot}, function(result2)
        --print(result2 ~= nil and #result2>0)
        if(result2 ~= nil and #result2>0) then
            local model = result2[1].model
            local plate = result2[1].plate

            MySQL.Async.execute("UPDATE cardealer_vehicles SET test_drive = true WHERE plate = @plate", {['@plate'] = plate})
            
            --print("spawn vehicle in back of garage")
            --print("===============================")
            TriggerClientEvent("pdm:spawntestdrive", src, -26.2022, -1083.02, 26.78613, model, plate, 50.0)
        end
    end)
end)

RegisterServerEvent("endtestdrive")
AddEventHandler("endtestdrive", function(plate)
    local src = source
    MySQL.Async.execute("UPDATE cardealer_vehicles SET test_drive = false WHERE plate = @plate", {['@plate'] = plate})
    
    --print("despawn vehicle in back of garage from test drive")
    --print("=================================================")
    --TriggerClientEvent("pdm:despawnvehicle", src, -26.2022, -1083.02, 26.78613)
    TriggerClientEvent("pdm:refreshstocklist", src)
end)

RegisterServerEvent("pdmgetbossinfo")
AddEventHandler("pdmgetbossinfo", function()
    local src = source
    local isowner = false

    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name
    local jobgrade = tonumber(xPlayer.job.grade)

    if(job == "cardealer" and jobgrade > 4) then
        isowner = true
    end

    local balance = 0
    Citizen.Wait(50)
    MySQL.Async.fetchAll("SELECT amount FROM jobs WHERE name = 'cardealer'", {}, function(money)
        if(money and #money > 0) then
            balance = money[1].amount
        end
    end)
    Citizen.Wait(50)
    MySQL.Async.fetchAll("SELECT a.grade, b.firstname, b.lastname, b.identifier FROM job_grades a, users b WHERE a.job_name = 'cardealer' and b.job = 'cardealer' and b.job_grade = a.grade ORDER BY a.grade", {}, function(employees)
        if(employees and #employees > 0) then
            for x=1,#employees,1 do
                TriggerClientEvent("pdm:addemployeetolist", src, employees[x].grade, employees[x].firstname, employees[x].lastname, employees[x].identifier, isowner, balance)
            end
        end
    end)
end)

RegisterServerEvent("pdmpromote")
AddEventHandler("pdmpromote", function(identifier, grade)
    local src = source
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    local newgrade = tonumber(grade) + 1
    if(newgrade < 6) then
        if(xPlayer ~= nil) then
            xPlayer.setJob('cardealer', newgrade)
        end
        MySQL.Async.execute("UPDATE users SET job_grade = @grade WHERE identifier = @identifier", {['@grade'] = newgrade, ['@identifier'] = identifier})
    else
        TriggerClientEvent("mythic_notify:client:SendAlert", src, { type = 'error', text = "You can not promote past owner", })
    end
end)

RegisterServerEvent("pdmdemote")
AddEventHandler("pdmdemote", function(identifier, grade)
    local src = source
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    local newgrade = tonumber(grade) - 1
    if(newgrade > -1) then
        if(xPlayer ~= nil) then
            xPlayer.setJob('cardealer', newgrade)
        end
        MySQL.Async.execute("UPDATE users SET job_grade = @grade WHERE identifier = @identifier", {['@grade'] = newgrade, ['@identifier'] = identifier})
    else
        TriggerClientEvent("mythic_notify:client:SendAlert", src, { type = 'error', text = "You must fire this person", })
    end
end)

RegisterServerEvent("pdmhire")
AddEventHandler("pdmhire", function(luckynumber)
    local xPlayer = ESX.GetPlayerFromId(luckynumber)
    if(xPlayer ~= nil) then
        xPlayer.setJob('cardealer', 0)
    end
    print(xPlayer.identifier)
    MySQL.Async.execute("UPDATE users SET job = 'cardealer', job_grade = 0 WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier})
end)

RegisterServerEvent("pdmfire")
AddEventHandler("pdmfire", function(identifier)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    local newgrade = grade
    if(xPlayer ~= nil) then
        xPlayer.setJob('unemployed', 0)
        MySQL.Async.execute("UPDATE users SET job = 'unemployed', job_grade = 0 WHERE identifier = @identifier", {['@identifier'] = identifier})
    else
        TriggerClientEvent("mythic_notify:client:SendAlert", src, { type = 'error', text = "Player is not in city", })
    end
end)

RegisterServerEvent("pdmpay")
AddEventHandler("pdmpay", function(identifier, amount)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    xPlayer.addAccountMoney('bank', tonumber(amount))

    MySQL.Async.fetchAll("SELECT amount FROM jobs WHERE name = 'cardealer'", {}, function(result)
        local balance = result[1].amount
        balance = balance - amount

        MySQL.Async.execute("UPDATE jobs SET amount = @money WHERE name = 'cardealer'", {['@money'] = balance})
    end)
end)

RegisterServerEvent("pdmdeposit")
AddEventHandler("pdmdeposit", function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeAccountMoney('bank', tonumber(amount))

    MySQL.Async.fetchAll("SELECT amount FROM jobs WHERE name = 'cardealer'", {}, function(result)
        local balance = result[1].amount
        balance = balance + amount

        MySQL.Async.execute("UPDATE jobs SET amount = @money WHERE name = 'cardealer'", {['@money'] = balance})
    end)
end)

RegisterServerEvent("pdmwithdraw")
AddEventHandler("pdmwithdraw", function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addAccountMoney('bank', tonumber(amount))

    MySQL.Async.fetchAll("SELECT amount FROM jobs WHERE name = 'cardealer'", {}, function(result)
        local balance = result[1].amount
        balance = balance - amount

        MySQL.Async.execute("UPDATE jobs SET amount = @money WHERE name = 'cardealer'", {['@money'] = balance})
    end)
end)