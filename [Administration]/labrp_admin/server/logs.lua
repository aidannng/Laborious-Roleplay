local connecting_webhook = {url = "https://discord.com/api/webhooks/844681591091757117/dv-1Zm99fqvmFDIkf3ebBZSaMk8O_caYQSbS1ZHSecjXMSugUwcukXQXFZFdy58w3L-J",image = "https://i.iodine.gg/i5fba.png"}
local chat_webhook = {url = "https://discord.com/api/webhooks/844680544963788830/yHEb6ueMGt8kIOE_HZ_zOHEahtYW-1aJVSqMOeyJHss2YWnyJbvWK-dAYAh8ZXXPcV81",image =  "https://i.iodine.gg/i5fba.png"}

AddEventHandler("chatMessage", function(source, author, text)
	local player = source
    PerformHttpRequest(chat_webhook.url, 
    function(err, text, header) end, 
    'POST', 
    json.encode({username = author .. " (ID: " .. player .. ") ", content = text, avatar_url=chat_webhook.image }), {['Content-Type'] = 'application/json'}) 
end)

AddEventHandler('playerJoining', function()
	local player = source
    local steamIdentifier
    local identifiers = GetPlayerIdentifiers(player)
	for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end
	PerformHttpRequest(connecting_webhook.url, 
    function(err, text, header) end, 
    'POST', 
    json.encode({username = author, content = "`User Connecting:` **" .. GetPlayerName(source) .. "**(" .. steamIdentifier .. ") is connecting to the server with **ID " .. player .. "** ", avatar_url=connecting_webhook.image }), {['Content-Type'] = 'application/json'}) 
end)

AddEventHandler('playerDropped', function(Reason)
	local player_id = source
	PerformHttpRequest(connecting_webhook.url, 
    function(err, text, header) end, 
    'POST', 
    json.encode({username = author, content = "`User Disconnected:` **" .. GetPlayerName(source) .. "(ID: " .. player_id .. ")** has disconnected from the server for: **" .. Reason .. "**", avatar_url=connecting_webhook.image }), {['Content-Type'] = 'application/json'}) 
end)