ESX = nil

local display = false
local timer = false
local callerSrc = nil
local receiverSrc = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

local isTyping = false
function setTyping(bool)
    isTyping = bool
    while isTyping do
        Citizen.Wait(3)
        DisableAllControlActions(2) 
        DisableControlAction(0, 0, true)
        DisableControlAction(0, 21, true)
        DisableControlAction(0, 22, true)			
        DisableControlAction(0, 249, true) -- N for PTT
        DisableControlAction(0, 20, true) -- Z for proximity
        DisableControlAction(0, 30, true) -- movement
        DisableControlAction(0, 31, true) -- movement
        DisableControlAction(0, 199, true) -- pause
        DisableControlAction(0, 303, true)
        DisableControlAction(0, 79, true)
		DisableControlAction(0, 305, true)
		DisableControlAction(0, 82, true)
		DisableControlAction(0, 182, true)
    end
end

RegisterNUICallback("set-input-focus", function(data)
    setTyping(data.focus)
end)

function SetDisplay(bool)
	display = bool
	--<bool> allow mouse, <bool> focus nui
	SetNuiFocus(bool, bool)
	--SetNuiFocusKeepInput(bool)
    SendNUIMessage({
		type="ui",
		status = bool,
	})
    if(bool) then
        Citizen.CreateThread(function()
            while display do
                Citizen.Wait(3)
                DisableControlAction(0, 1, true) -- LookLeftRight
                DisableControlAction(0, 2, true) -- LookUpDown
                DisableControlAction(0, 200, true) -- Escacpe/Pause
                DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
                DisableControlAction(0, 288, true) -- F1 Radial
                DisableControlAction(0, 245, true)
                DisablePlayerFiring(PlayerId(), true) -- Disable weapon firing
                DisableControlAction(0, 24, true) -- disable attack
                DisableControlAction(0, 25, true) -- disable aim
                DisableControlAction(1, 37, true) -- disable weapon select
                DisableControlAction(0, 47, true) -- disable weapon
                DisableControlAction(0, 58, true) -- disable weapon
                DisableControlAction(0, 140, true) -- disable melee
                DisableControlAction(0, 141, true) -- disable melee
                DisableControlAction(0, 142, true) -- disable melee
                DisableControlAction(0, 143, true) -- disable melee
                DisableControlAction(0, 263, true) -- disable melee
                DisableControlAction(0, 264, true) -- disable melee
                DisableControlAction(0, 257, true) -- disable melee
                DisableControlAction(0, 211, true)

                EnableControlAction(0, 21, true)
                EnableControlAction(0, 22, true)			
                EnableControlAction(0, 249, true) -- N for PTT
                EnableControlAction(0, 20, true) -- Z for proximity
                EnableControlAction(0, 30, true) -- movement
                EnableControlAction(0, 31, true) -- movement
            end
        end)
    end
end

RegisterCommand("phone", function(source)
    TriggerEvent("labrp-phone:open")
end)

RegisterNetEvent("labrp-phone:open")
AddEventHandler("labrp-phone:open", function()
    if(not display) then
        TriggerEvent('labrp_phone:anim')
        TriggerEvent("labrp-phone:update:status-bar:time")
        TriggerEvent("labrp-phone:time", true)
    
        ESX.TriggerServerCallback("labrp-phone:get:user-phone-number", function(phone)
            if phone and #phone>0 then
                mynumber = phone[1].phone_number
            end
        end)
    
        SetDisplay(true)

        TriggerEvent("labrp-phone:lockscreen-timer", true)
    end
end)

RegisterNUICallback("set-phone-active", function()
    TriggerEvent("labrp-phone:lockscreen-timer", false)
end)

local isActive = false
local lockscreenTimer = 10000
RegisterNetEvent("labrp-phone:lockscreen-timer")
AddEventHandler("labrp-phone:lockscreen-timer", function(bool)
    isActive = bool
    if(isActive) then
        lockscreenTimer = 10000
    end
    while isActive do
        lockscreenTimer = lockscreenTimer - 100
        if(lockscreenTimer == 0) then
            lockscreenTimer = 10000
            isActive = false

            if(display) then
                TriggerEvent('labrp_phone:anim')
            end

            SetDisplay(false)
            TriggerEvent("labrp-phone:time", false)
            TriggerServerEvent("labrp-phone:server:end-call")
        end
        Citizen.Wait(100)
    end
end)


RegisterNetEvent("labrp-phone:open:app", function(app)
    if(not display) then
        --TriggerEvent('labrp_phone:anim')
    end

    SendNUIMessage({
        openApp=true,
        app=app,
    })

    TriggerEvent("labrp-phone:update:status-bar:time")
    TriggerEvent("labrp-phone:time", true)

    ESX.TriggerServerCallback("labrp-phone:get:user-phone-number", function(phone)
        if phone and #phone>0 then
            mynumber = phone[1].phone_number
        end
    end)

    --SetDisplay(true)

    TriggerEvent("labrp-phone:lockscreen-timer", true)
    
    if(app == "incoming-call") then
        ringing(true)
    elseif(app == "call-connected") then
        ringing(false)
    end
end)

RegisterNUICallback("exit", function(data)
    if(display) then
        TriggerEvent('labrp_phone:anim')
    end
	SetDisplay(false)
    TriggerEvent("labrp-phone:time", false)
end)

RegisterNetEvent("labrp-phone:update:status-bar:time")
AddEventHandler("labrp-phone:update:status-bar:time", function()
    local hour = GetClockHours()
    local minutes = GetClockMinutes()

    SendNUIMessage({
        updateStatusBarTime=true,
        hour=hour,
        minutes=minutes,
    })
end)

RegisterNetEvent("labrp-phone:time")
AddEventHandler("labrp-phone:time", function(bool)
    timer = bool
    while timer do
        Citizen.Wait(500)
        TriggerEvent("labrp-phone:update:status-bar:time")
    end
end)

--##########################
--###      CONTACTS      ###
--##########################

RegisterNUICallback("add-contact", function(data)
    TriggerServerEvent("labrp-phone:add:contact", data.name, data.number)
end)

RegisterNUICallback("get-contacts", function()
    ESX.TriggerServerCallback('labrp-phone:get:contacts', function(contacts)
        if contacts and #contacts>0 then
            for x=1,#contacts,1 do
                SendNUIMessage({
                    addToContactList=true,
                    order=x,
                    name=contacts[x].name,
                    number=contacts[x].number,
                    favorite=contacts[x].favorite
                })
            end
        end
    end)
end)

RegisterNUICallback("favorite-contact", function(data)
    TriggerServerEvent("labrp-phone:favorite:contact", data.number, data.favorite)
end)

RegisterNUICallback("delete-contact", function(data)
    TriggerServerEvent("labrp-phone:delete:contact", data.number)
end)

RegisterNUICallback("get-contact-from-number", function(data)
    ESX.TriggerServerCallback('labrp-phone:check:is-contact', function(contact)
        if contact ~= data.number then
            SendNUIMessage({
                updateMessageContact = true,
                name=contact,
            })
        end
    end, data.number)
end)

RegisterNUICallback("share-contact", function(data)
    local closestPlayer = ESX.Game.GetClosestPlayer()

    if closestPlayer ~= -1 then
        TriggerServerEvent("labrp-phone:add:share-contact", data.number, data.name, GetPlayerServerId(closestPlayer))
    end
end)

--##########################
--###      VEHICLES      ###
--##########################

RegisterNUICallback("get-vehicles", function()
    ESX.TriggerServerCallback('labrp-phone:get:vehicles', function(vehicles)
        if vehicles and #vehicles>0 then
            for x=1,#vehicles,1 do
                SendNUIMessage({
                    addToVehicleList=true,
                    order=x,
                    model=vehicles[x].name,
                    plate=vehicles[x].plate,
                    garage=vehicles[x].garage
                })
            end
        end
    end)
end)

--##########################
--###      MESSAGES      ###
--##########################

RegisterNUICallback("get-messages", function()
    print("getting messages")
    ESX.TriggerServerCallback("labrp-phone:get:user-phone-number", function(phone)
        if phone and #phone>0 then
            local mynumber = phone[1].phone_number
            TriggerServerEvent("labrp-phone:get:messages", mynumber)
        end
    end)
end)

RegisterNetEvent("labrp-phone:add-to:messages-list")
AddEventHandler("labrp-phone:add-to:messages-list", function(name, number, isContact, order, isRead, message)
    print("adding")
    ESX.TriggerServerCallback("labrp-phone:get:user-phone-number", function(phone)
        if phone and #phone>0 then
            local mynumber = phone[1].phone_number

            local sent = false
            if(mynumber ~= number) then
                sent = true
            end
            SendNUIMessage({
                addToMessageList=true,
                isContact=isContact,
                order=order,
                number=number,
                name=name,
                isRead=isRead,
                sent=sent,
                message=message
            })
        end
    end)    
end)

RegisterNUICallback("get-message-texts", function(data)
    ESX.TriggerServerCallback("labrp-phone:get:user-phone-number", function(phone)
        if phone and #phone>0 then
            local mynumber = phone[1].phone_number

            ESX.TriggerServerCallback('labrp-phone:get:message-texts', function(messages)
                if messages and #messages>0 then
                    for x=1,#messages,1 do
                        local sender = messages[x].sender
                        if(sender == mynumber) then
                            SendNUIMessage({
                                addToTextList=true,
                                sender=true,
                                order=x,
                                message=messages[x].message,
                            })
                        else
                            SendNUIMessage({
                                addToTextList=true,
                                sender=false,
                                order=x,
                                message=messages[x].message
                            })
                        end
                    end
                end
            end, mynumber, data.number)
        end
    end)
end)

RegisterNUICallback("send-text-message", function(data)
    print("sending text")
    ESX.TriggerServerCallback("labrp-phone:get:user-phone-number", function(phone)
        if phone and #phone>0 then
            local mynumber = phone[1].phone_number
            TriggerServerEvent("labrp-phone:send:text-message", mynumber, data.number, data.message)
        end
    end)
end)

RegisterNUICallback("delete-message-history", function(data)
    ESX.TriggerServerCallback("labrp-phone:get:user-phone-number", function(phone)
        if phone and #phone>0 then
            local mynumber = phone[1].phone_number
            TriggerServerEvent("labrp-phone:delete:message-history", mynumber, data.number)
        end
    end)
end)

--##########################
--###        PHONE       ###
--##########################

local isCalling = false
local callTimer = 10000
RegisterNetEvent("labrp-phone:update:change-calling")
AddEventHandler("labrp-phone:update:change-calling", function(bool)
    isCalling = bool
    while isCalling do
        callTimer = callTimer - 100
        if(callTimer == 0) then
            TriggerEvent("labrp-phone:update:caller-unavailable")
            isCalling = false
            callTimer = 10000

            ESX.TriggerServerCallback("labrp-phone:get:user-phone-number", function(phone)
                if phone and #phone>0 then
                    local mynumber = phone[1].phone_number
                    TriggerServerEvent("labrp-phone:update:call-to-inactive", mynumber)
                end
            end)
        end
        Citizen.Wait(100)
    end
end)

RegisterNUICallback("start-call", function(data)
    ESX.TriggerServerCallback('labrp-phone:check:is-contact', function(contact)
        SendNUIMessage({
            updateCallingContact = true,
            name=contact,
            number=data.number
        })
    end, data.number)

    ESX.TriggerServerCallback('labrp-phone:get:src-from-number', function(src)
        if src ~= nil then
            exports['pma-voice']:addPlayerToCall(src)
        end
    end, data.number)

    ESX.TriggerServerCallback("labrp-phone:get:user-phone-number", function(phone)
        if phone and #phone>0 then
            local mynumber = phone[1].phone_number
            TriggerServerEvent("labrp-phone:open:start-call", data.number, mynumber)
            ringing(true)
        end
    end)
end)

RegisterNUICallback("end-call", function()
    TriggerServerEvent("labrp-phone:server:end-call")
end)

RegisterNetEvent("labrp-phone:client:end-call")
AddEventHandler("labrp-phone:client:end-call", function(src)
    exports['pma-voice']:removePlayerFromCall(src)
    SendNUIMessage({
        endCall=true,
    })
    ringing(false)
end)

RegisterNetEvent("labrp-phone:update:caller-name")
AddEventHandler("labrp-phone:update:caller-name", function(number)
    ESX.TriggerServerCallback('labrp-phone:check:is-contact', function(contact)
        SendNUIMessage({
            updateCallingContact = true,
            name=contact,
            number=number,
        })
    end, number)
end)

RegisterNetEvent("labrp-phone:update:caller-unavailable")
AddEventHandler("labrp-phone:update:caller-unavailable", function()
    ringing(false)
    SendNUIMessage({
        updateCallingUnavailable=true
    })
end)

RegisterNUICallback("call-accepted", function(data)
    ESX.TriggerServerCallback("labrp-phone:get:user-phone-number", function(phone)
        if phone and #phone>0 then
            local mynumber = phone[1].phone_number

            ESX.TriggerServerCallback('labrp-phone:get:src-from-number', function(src)
                if src ~= nil then
                    receiverSrc = src
                    exports['pma-voice']:addPlayerToCall(src)
                end
            end, mynumber)
        
            TriggerServerEvent("labrp-phone:update:call-accepted", data.number, mynumber)
            ringing(false)
        end
    end)    
end)

local isringing = false
function ringing(bool)
    isringing = bool
    local x = 1
    while isringing do
        if(x < 4) then
            SendNUIMessage({
                updateCallingHeader = true,
                x=x,
            })
            x = x + 1
        else
            x = 1
        end
        Citizen.Wait(500)
    end
end

RegisterNUICallback("get-call-history", function()
    ESX.TriggerServerCallback("labrp-phone:get:user-phone-number", function(phone)
        if phone and #phone>0 then
            local mynumber = phone[1].phone_number

            ESX.TriggerServerCallback('labrp-phone:get:call-history', function(calls)
                if(calls and #calls>0) then
                    for x=1,#calls,1 do
                        local wasCaller=false
                        if(calls[x].caller==mynumber) then
                            wasCaller=true
                        end
        
                        local wasAnswered=false
                        if(calls[x].accepted ~= 0) then
                            wasAnswered=true
                        end
        
                        local name = nil
                        if(wasCaller) then
                            ESX.TriggerServerCallback('labrp-phone:check:is-contact', function(contact)
                                if contact ~= mynumber then
                                    name=contact
                                end
                                SendNUIMessage({
                                    addToCallHistory=true,
                                    wasCaller=wasCaller,
                                    wasAnswered=wasAnswered,
                                    name=name,
                                    receiver=calls[x].receiver,
                                    caller=calls[x].caller,
                                })
                            end, calls[x].receiver)
                        else
                            ESX.TriggerServerCallback('labrp-phone:check:is-contact', function(contact)
                                if contact ~= mynumber then
                                    name=contact
                                end
                                SendNUIMessage({
                                    addToCallHistory=true,
                                    wasCaller=wasCaller,
                                    wasAnswered=wasAnswered,
                                    name=name,
                                    receiver=calls[x].receiver,
                                    caller=calls[x].caller,
                                })
                            end, calls[x].caller)
                        end 
        
                        Citizen.Wait(10)
                    end
                end
            end, mynumber)
        end
    end)
end)

RegisterNUICallback("get-favorite-contacts", function()
    ESX.TriggerServerCallback('labrp-phone:get:favorite-contacts', function(contacts)
        if(contacts and #contacts>0) then
            for x=1,#contacts,1 do
                SendNUIMessage({
                    addToFavoriteContacts=true,
                    name=contacts[x].name,
                    number=contacts[x].number,
                })
            end
        end
    end)
end)

--##########################
--###        INFO        ###
--##########################

RegisterNUICallback("get-personal-info", function()
    ESX.TriggerServerCallback("labrp-phone:get:user-phone-number", function(phone)
        if phone and #phone>0 then
            SendNUIMessage({
                updatePersonalPhone=true,
                number=phone[1].phone_number
            })
        end
    end)

    ESX.TriggerServerCallback("labrp-phone:get:licenses", function(licenses)
        if licenses and #licenses>0 then
            for x=1,#licenses,1 do
                SendNUIMessage({
                    addToLicenses=true,
                    type=licenses[x].type,
                    label=licenses[x].label
                })
            end
        end
    end)

    ESX.TriggerServerCallback("labrp-phone:get:bank-accounts", function(accounts)
        if accounts and #accounts>0 then
            for x=1,#accounts,1 do
                SendNUIMessage({
                    addToBankAccounts=true,
                    account=accounts[x].account,
                    balance=accounts[x].balance
                })
            end
        end
    end)

    ESX.TriggerServerCallback("labrp-phone:get:paycheck", function(paycheck)
        if paycheck then
            SendNUIMessage({
                updatePaycheck=true,
                amount=paycheck,
            })
        end
    end)
end)

--##########################
--###       TWITTER      ###
--##########################

RegisterNUICallback("add-tweet", function(data)
    TriggerServerEvent("labrp-phone:add:tweet", data.tweet)
end)

RegisterNUICallback("get-tweets", function()
    local isadmin = false
    ESX.TriggerServerCallback("labrp-phone:get:user-group", function(group)
        if(group == "staff" or group == "headadmin" or group == "management") then
            isadmin = true
        end
    end)
    ESX.TriggerServerCallback("labrp-phone:get:tweets", function(tweets)
        if tweets then
            for x=1,#tweets,1 do
                ESX.TriggerServerCallback("labrp-phone:get:if-tweet-liked", function(liked)
                    SendNUIMessage({
                        addToTweets=true,
                        id=tweets[x].id,
                        handle=tweets[x].handle,
                        text=tweets[x].text,
                        likes=tweets[x].likes,
                        isAdmin=isadmin,
                        likedTweet=liked
                    })
                end, tweets[x].id)
                Citizen.Wait(15)
            end
        end
    end)
end)

RegisterNUICallback("like-tweet", function(data)
    TriggerServerEvent("labrp-phone:like:tweet", data.liked, data.tweet)
end)

RegisterNUICallback("delete-tweet", function(data)
    TriggerServerEvent("labrp-phone:delete:tweet", data.tweet)
end)

--##########################
--###    YELLOW PAGES    ###
--##########################

RegisterNUICallback("add-yellow-pages-ad", function(data)
    ESX.TriggerServerCallback("labrp-phone:get:user-phone-number", function(phone)
        if phone and #phone>0 then
            local mynumber = phone[1].phone_number
            TriggerServerEvent("labrp-phone:add:yellow-pages-ad", data.message, mynumber)
        end
    end)
end)

RegisterNUICallback("get-yellow-pages", function()
    local isadmin = false
    ESX.TriggerServerCallback("labrp-phone:get:user-group", function(group)
        if(group == "staff" or group == "headadmin" or group == "management") then
            isadmin = true
        end
    end)
    ESX.TriggerServerCallback("labrp-phone:get:yellow-pages", function(ads)
        if ads and #ads>0 then
            for x=1,#ads,1 do
                ESX.TriggerServerCallback("labrp-phone:get:if-own-yellow-page", function(poster)
                    SendNUIMessage({
                        addToYellowPages=true,
                        isAdmin=isadmin,
                        id=ads[x].id,
                        name=ads[x].name,
                        number=ads[x].number,
                        isPoster=poster,
                        message=ads[x].message
                    })
                end, ads[x].id)
                Citizen.Wait(10)
            end
        end
    end)
end)

RegisterNUICallback("delete-yellow-pages-ad", function(data)
    TriggerServerEvent("labrp-phone:delete:yellow-pages-ad", data.ad)
end)

--##########################
--###        PING       ###
--##########################

RegisterNUICallback("ping-player", function(data)
    local coords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("labrp-phone:server:ping-player", data.id, coords.x, coords.y)
end)

RegisterNUICallback("ping-contact", function(data)
    local coords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("labrp-phone:server:ping-contact", data.number, coords.x, coords.y)
end)

RegisterNetEvent("labrp-phone:client:ping-player")
AddEventHandler("labrp-phone:client:ping-player", function(x, y)
    SetNewWaypoint(x, y)
end)

RegisterNUICallback("accept-ping", function(data)
    TriggerServerEvent("labrp-phone:server:accept-ping", data.id)
end)

--##########################
--###        BOSS        ###
--##########################

local bossApp = false
RegisterNUICallback("check-if-boss", function()
    ESX.TriggerServerCallback('labrp-phone:check:if-boss', function(job)
        if job ~= nil then
            if(not bossApp) then
                SendNUIMessage({
                    addBossApp=true,
                    label=job[1].label,
                    name=job[1].job_name,
                })
                bossApp = true
            end
        else 
            SendNUIMessage({
                removeBossApp=true,
            })
            bossApp=false
        end
    end)
end)

RegisterNUICallback("get-boss-menu", function()
    ESX.TriggerServerCallback('labrp-phone:get:boss-menu-grades', function(grades)
        if(grades and #grades>0) then
            for x=1,#grades,1 do
                local isBoss = false
                if(x == 1) then
                    isBoss = true
                end
                SendNUIMessage({
                    addGradeToBossMenu=true,
                    label=grades[x].label,
                    grade=grades[x].grade,
                })

                ESX.TriggerServerCallback('labrp-phone:get:boss-menu-employees', function(employees)
                    if(employees and #employees>0) then
                        for y=1,#employees,1 do
                            SendNUIMessage({
                                addEmployeeToBossMenu=true,
                                isBoss=isBoss,
                                firstname=employees[y].firstname,
                                lastname=employees[y].lastname,
                                identifier=employees[y].identifier,
                                grade=employees[y].job_grade,
                                job=grades[x].job_name,
                            })
                        end
                    end
                end, grades[x].job_name, grades[x].grade)
            end
        end
    end)
end)

RegisterNUICallback("boss-menu-promote", function(data)
    TriggerServerEvent("labrp-phone:update:boss-menu-promote", data.identifier, data.grade, data.job)
end)

RegisterNUICallback("boss-menu-fire", function(data)
    TriggerServerEvent("labrp-phone:update:boss-menu-fire", data.identifier, data.job)
end)

RegisterNUICallback("boss-menu-hire", function(data)
    TriggerServerEvent("labrp-phone:update:boss-menu-hire", data.id)
end)

--##########################
--###    NOTIFICATIONS   ###
--##########################

RegisterNUICallback("get-notifications", function()
    ESX.TriggerServerCallback('labrp-phone:get:notifications', function(apps)
        if(apps and #apps>0) then
            for x=1,#apps,1 do
                SendNUIMessage({
                    addAppToLockscreen=true,
                    app=apps[x].app,
                })

                ESX.TriggerServerCallback('labrp-phone:get:app-notifications', function(notifications)
                    if(notifications and #notifications>0) then
                        for y=1,#notifications,1 do
                            SendNUIMessage({
                                addNotificationToApp=true,
                                id=notifications[y].id,
                                app=apps[x].app,
                                text=notifications[y].text,
                            })
                        end
                    end
                end, apps[x].app)
            end
        end
    end)
end)

RegisterNUICallback("clear-notification", function(data)
    TriggerServerEvent("labrp-phone:delete:notification", data.id)
end)

RegisterNUICallback("clear-notifications", function(data)
    TriggerServerEvent("labrp-phone:remove:notifications", data.app)
end)

--##########################
--###      MULTI JOB     ###
--##########################

RegisterNUICallback("get-multi-jobs", function()
    ESX.TriggerServerCallback('labrp-phone:get:current-player-job', function(job)
        if(job ~= nil) then
            ESX.TriggerServerCallback('labrp-phone:get:multi-jobs', function(jobs)
                if(jobs and #jobs>0) then
                    for x=1,#jobs,1 do
                        local active = false
                        if(job == jobs[x].job) then
                            active = true
                        end
                        SendNUIMessage({
                            addToMultiJob=true,
                            isActive=active,
                            job=jobs[x].job,
                            grade=jobs[x].job_grade,
                            jobLabel=jobs[x].job_label,
                            gradeLabel=jobs[x].grade_label,
                        })
                    end
                end
            end)
        end
    end)
end)

RegisterNUICallback("multi-job-set-unemployed", function()
    TriggerServerEvent("labrp-phone:set:job-unemployed")
end)

RegisterNUICallback("multi-job-set-job", function(data)
    TriggerServerEvent("labrp-phone:set:multi-job", data.job, data.grade)
end)

--##########################
--###        NOTES       ###
--##########################

RegisterNUICallback("add-note", function(data)
    TriggerServerEvent("labrp-phone:add:note", data.title, data.text)
end)

RegisterNUICallback("get-notes", function()
    ESX.TriggerServerCallback('labrp-phone:get:notes', function(notes)
        if(notes and #notes>0) then
            for x=1,#notes,1 do
                SendNUIMessage({
                    addToNotes=true,
                    id=notes[x].id,
                    title=notes[x].title
                })
            end
        end
    end)
end)

RegisterNUICallback("get-note", function(data)
    ESX.TriggerServerCallback('labrp-phone:get:note', function(note)
        if(note and #note>0) then
            SendNUIMessage({
                editNote=true,
                id=note[1].id,
                title=note[1].title,
                text=note[1].text
            })
        end
    end, data.id)
end)

RegisterNUICallback("update-note", function(data)
    TriggerServerEvent("labrp-phone:update:note", data.id, data.text)
end)

RegisterNUICallback("delete-note", function(data)
    TriggerServerEvent("labrp-phone:delete:note", data.id)
end)

RegisterNUICallback("share-note", function(data)
    local closestPlayer = ESX.Game.GetClosestPlayer()

    if closestPlayer ~= -1 then
        TriggerServerEvent("labrp-phone:add:share-note", data.id, GetPlayerServerId(closestPlayer))
    end
end)