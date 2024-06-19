local QBCore = exports['qb-core']:GetCoreObject()

-- Function to remove items from the player's inventory
RegisterNetEvent('t3_pawnjob:Server:RemoveItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
end)

-- Function to handle crafting jewelry
RegisterNetEvent('t3_pawnjob:server:CraftJewelry', function(jewelry)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local outputAmount = Config.Jewelry[jewelry].output_amount
    Player.Functions.AddItem(jewelry, outputAmount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[jewelry], "add")
end)

-- Callback to check if the player has the necessary materials
QBCore.Functions.CreateCallback('t3_pawnjob:server:Materials', function(source, cb, materials)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local hasMaterials = true
    for k, v in pairs(materials) do
        local item = player.Functions.GetItemByName(v.item)
        if not item or item.amount < v.amount then
            hasMaterials = false
            break
        end
    end
    cb(hasMaterials)
end)

-- Check if the player is the boss
QBCore.Functions.CreateCallback('t3_pawnjob:server:IsBoss', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local job = Player.PlayerData.job
    cb(job.isboss)
end)

-- Version check function
local function CheckVersion()
    PerformHttpRequest('https://raw.githubusercontent.com/UrbanLegends-RP/t3_pawnjob/main/version.txt', function(err, newestVersion, headers)
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
        if not newestVersion then print("Currently unable to run a version check.") return end
        local advice = "^1You are currently running an outdated version^7, ^1please update^7"
        if newestVersion:gsub("%s+", "") == currentVersion:gsub("%s+", "") then advice = '^6You are running the latest version.^7'
        else print("^3Version Check^7: ^2Current^7: "..currentVersion.." ^2Latest^7: "..newestVersion) end
        print(advice)
    end)
end
CheckVersion()
