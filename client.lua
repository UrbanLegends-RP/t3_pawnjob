local QBCore = exports['qb-core']:GetCoreObject()

-- Events for player load and notifications
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local player = QBCore.Functions.GetPlayerData()
    PlayerJob = player.job
    onDuty = player.job.onduty
end)

RegisterNetEvent('t3_pawnjob:Client:Notify')
AddEventHandler("t3_pawnjob:Client:Notify", function(msg, type)
    Notify(msg, type)
end)

-- Function to check item availability
if Config.Inv == "ox" then
    function HasItem(src, items, amount)
        local count = exports.ox_inventory:Search(src, 'count', items)
        return count >= (amount or 1)
    end
elseif Config.Inv == "qb" then
    function HasItem(source, items, amount)
        local amount = amount or 1
        local count = 0
        local Player = QBCore.Functions.GetPlayer(source)
        for _, itemData in pairs(Player.PlayerData.items) do
            if itemData and (itemData.name == items) then
                count = count + itemData.amount
            end
        end
        return count >= amount
    end
end

-- Event for handling inventory interaction
AddEventHandler("t3_pawnjob:Client:Storage", function(data, id)
    if Config.Inv == "ox" then 
        exports.ox_inventory:openInventory('stash', tostring(data.id))
    elseif Config.Inv == "qb" then 
        TriggerEvent(Config.Stash.StashInvTrigger, data.id)
        TriggerServerEvent(Config.Stash.OpenInvTrigger, "stash", data.id, {
            maxweight = Config.Stash.MaxWeighStash,
            slots = Config.Stash.MaxSlotsStash,
        })
    end
end)

-- Handlers for Ox inventory actions
if Config.Inv == "ox" then
    AddEventHandler('ox_inventory:openedInventory', function(playerId, inventoryId)
        print("Player " .. tostring(playerId) .. " has opened inventory " .. inventoryId)
    end)

    AddEventHandler('ox_inventory:closedInventory', function(playerId, inventoryId)
        print("Player " .. tostring(playerId) .. " has closed inventory " .. inventoryId)
    end)
end

for i = 1, 4 do
    AddEventHandler("t3_pawnjob:Client:OpenTray0" .. i, function()
        local tray = 'tray0' .. i
        if Config.Inv == "ox" then
            exports.ox_inventory:openInventory('stash', tray)
        elseif Config.Inv == "qb" then
            TriggerEvent(Config.Stash.StashInvTrigger, tray)
            TriggerServerEvent(Config.Stash.OpenInvTrigger, "stash", tray, {
                maxweight = 50000,
                slots = 20,
            })
        end
    end)
end

AddEventHandler("t3_pawnjob:Client:Storage", function()
    if Config.Inv == "ox" then
        exports.ox_inventory:openInventory('stash', 'Storage01')
    elseif Config.Inv == "qb" then
        TriggerEvent(Config.Stash.StashInvTrigger, "Storage01")
        TriggerServerEvent(Config.Stash.OpenInvTrigger, "stash", "Storage01", {
            maxweight = 50000,
            slots = 20,
        })
    end
end)

-- Payment handling based on billing config
RegisterNetEvent('t3_pawnjob:Client:Bill', function()
    if Config.JimPayments then
        TriggerEvent("jim-payments:client:Charge", Config.Job)
    else
        local dialog = exports[Config.Input]:ShowInput({
            header = Language.Input.Header,
            submitText = Language.Input.Submit,
            inputs = {
                { type = 'number', isRequired = true, name = 'id', text = Language.Input.Paypal },
                { type = 'number', isRequired = true, name = 'amount', text = Language.Input.Amount }
            }
        })
        if dialog and dialog.id and dialog.amount then
            TriggerServerEvent("t3_pawnjob:Server:Billing", dialog.id, dialog.amount)
        end
    end
end)

-- Command registration for billing
if Config.Billing.EnableCommand then
    RegisterCommand(Config.Billing.Command, function()
        if Config.JimPayments then
            TriggerEvent("jim-payments:client:Charge", Config.Job)
        else
            local dialog = exports[Config.Input]:ShowInput({
                header = Language.Input.Header,
                submitText = Language.Input.Submit,
                inputs = {
                    { type = 'number', isRequired = true, name = 'id', text = Language.Input.Paypal },
                    { type = 'number', isRequired = true, name = 'amount', text = Language.Input.Amount }
                }
            })
            if dialog and dialog.id and dialog.amount then
                TriggerServerEvent("t3_pawnjob:Server:Billing", dialog.id, dialog.amount)
            end
        end
    end)
end

-- Function to start an animation
local function startAnimation(dict, anim)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -8.0, -1, 1, 0, false, false, false)
end

-- Function to stop the animation
local function stopAnimation()
    ClearPedTasks(PlayerPedId())
end

-- Function to get the required materials as a string
local function GetRequiredMaterials(materials)
    local required = ""
    for _, v in ipairs(materials) do
        required = required .. QBCore.Shared.Items[v.item].label .. " x" .. v.amount .. ", "
    end
    return required:sub(1, -3) -- Remove the trailing comma and space
end

-- Define the Craft functions for Jewelry
function CraftGoldRing()
    startAnimation("amb@world_human_stand_mobile@male@text@base", "base")
    QBCore.Functions.Progressbar("crafting_gold_ring", "Crafting Gold Ring...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        QBCore.Functions.TriggerCallback('t3_pawnjob:server:Materials', function(hasMaterials)
            if hasMaterials then
                TriggerServerEvent('t3_pawnjob:server:CraftJewelry', "gold_ring")
            else
                QBCore.Functions.Notify(Language.Notify.NoMaterials, "error")
            end
            stopAnimation()
        end, Config.Jewelry["gold_ring"].materials)
    end, function() -- Cancel
        stopAnimation()
        QBCore.Functions.Notify(Language.Notify.CraftingCancelled, "error")
    end)
end

function CraftSilverRing()
    startAnimation("amb@world_human_stand_mobile@male@text@base", "base")
    QBCore.Functions.Progressbar("crafting_silver_ring", "Crafting Silver Ring...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        QBCore.Functions.TriggerCallback('t3_pawnjob:server:Materials', function(hasMaterials)
            if hasMaterials then
                TriggerServerEvent('t3_pawnjob:server:CraftJewelry', "silver_ring")
            else
                QBCore.Functions.Notify(Language.Notify.NoMaterials, "error")
            end
            stopAnimation()
        end, Config.Jewelry["silver_ring"].materials)
    end, function() -- Cancel
        stopAnimation()
        QBCore.Functions.Notify(Language.Notify.CraftingCancelled, "error")
    end)
end

function CraftDiamondNecklace()
    startAnimation("amb@world_human_stand_mobile@male@text@base", "base")
    QBCore.Functions.Progressbar("crafting_diamond_necklace", "Crafting Diamond Necklace...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        QBCore.Functions.TriggerCallback('t3_pawnjob:server:Materials', function(hasMaterials)
            if hasMaterials then
                TriggerServerEvent('t3_pawnjob:server:CraftJewelry', "diamond_necklace")
            else
                QBCore.Functions.Notify(Language.Notify.NoMaterials, "error")
            end
            stopAnimation()
        end, Config.Jewelry["diamond_necklace"].materials)
    end, function() -- Cancel
        stopAnimation()
        QBCore.Functions.Notify(Language.Notify.CraftingCancelled, "error")
    end)
end

-- Define the Boss Stash function
function OpenBossStash()
    QBCore.Functions.TriggerCallback('t3_pawnjob:server:IsBoss', function(isBoss)
        if isBoss then
            TriggerEvent(Config.Stash.StashInvTrigger, "BossStash")
            TriggerServerEvent(Config.Stash.OpenInvTrigger, "stash", "BossStash", {
                maxweight = Config.Stash.MaxWeighStash,
                slots = Config.Stash.MaxSlotsStash,
            })
        else
            QBCore.Functions.Notify(Language.Notify.NotAuthorized, "error")
        end
    end)
end

-- Function to open the crafting menu
local function OpenCraftingMenu()
    local menuOptions = {
        {
            header = "Craft Gold Ring",
            txt = "Required: " .. GetRequiredMaterials(Config.Jewelry["gold_ring"].materials),
            params = { event = "t3_pawnjob:Client:CraftGoldRing" }
        },
        {
            header = "Craft Silver Ring",
            txt = "Required: " .. GetRequiredMaterials(Config.Jewelry["silver_ring"].materials),
            params = { event = "t3_pawnjob:Client:CraftSilverRing" }
        },
        {
            header = "Craft Diamond Necklace",
            txt = "Required: " .. GetRequiredMaterials(Config.Jewelry["diamond_necklace"].materials),
            params = { event = "t3_pawnjob:Client:CraftDiamondNecklace" }
        }
    }

    exports['qb-menu']:openMenu(menuOptions)
end

-- Add target zones
for _, loc in ipairs(Config.CraftLocations) do
    exports[Config.Target]:AddBoxZone("CraftJewelry"..tostring(loc.x)..tostring(loc.y), vector3(loc.x, loc.y, loc.z), 1.0, 1.0, {
        name = "CraftJewelry"..tostring(loc.x)..tostring(loc.y),
        heading = 0,
        debugPoly = false,
        minZ = loc.z - 1.0,
        maxZ = loc.z + 1.0
    }, {
        options = {
            {
                action = function() OpenCraftingMenu() end,
                icon = "fa-solid fa-ring",
                label = "Open Crafting Menu",
                job = Config.Job
            }
        },
        distance = 2.0
    })
end

for _, loc in ipairs(Config.StorageLocations) do
    exports[Config.Target]:AddBoxZone("Storage"..tostring(loc.x)..tostring(loc.y), vector3(loc.x, loc.y, loc.z), 1.0, 1.0, {
        name = "Storage"..tostring(loc.x)..tostring(loc.y),
        heading = 0,
        debugPoly = false,
        minZ = loc.z - 1.0,
        maxZ = loc.z + 1.0
    }, {
        options = {
            {
                event = "t3_pawnjob:Client:Storage",
                icon = "fas fa-box",
                label = "Jewelry Storage",
                job = Config.Job
            }
        },
        distance = 2.0
    })
end

exports[Config.Target]:AddBoxZone("Billing", Config.BillingLocation, 1.0, 1.0, {
    name = "Billing",
    heading = 90.0,
    debugPoly = false,
    minZ = Config.BillingLocation.z - 1.0,
    maxZ = Config.BillingLocation.z + 1.0
}, {
    options = {
        {
            event = "t3_pawnjob:Client:Bill",
            icon = "fa-solid fa-money-bill",
            label = "Billing",
            job = Config.Job
        },
    },
    distance = 2.0
})

exports[Config.Target]:AddBoxZone("BossMenu", Config.BossMenuLocation, 1.0, 1.0, {
    name = "BossMenu",
    heading = 0,
    debugPoly = false,
    minZ = Config.BossMenuLocation.z - 1.0,
    maxZ = Config.BossMenuLocation.z + 1.0
}, {
    options = {
        {
            event = Config.Bossmenu,
            icon = "fa-solid fa-clipboard-list",
            label = "Boss Menu",
            job = Config.Job
        },
    },
    distance = 2.0
})

exports[Config.Target]:AddBoxZone("BossStash", Config.BossStashLocation, 1.0, 1.0, {
    name = "BossStash",
    heading = 0,
    debugPoly = false,
    minZ = Config.BossStashLocation.z - 1.0,
    maxZ = Config.BossStashLocation.z + 1.0
}, {
    options = {
        {
            action = function() OpenBossStash() end,
            icon = "fas fa-box",
            label = "Boss Stash",
            job = Config.Job
        }
    },
    distance = 2.0
})

-- Event handlers for crafting jewelry
RegisterNetEvent('t3_pawnjob:Client:CraftGoldRing', CraftGoldRing)
RegisterNetEvent('t3_pawnjob:Client:CraftSilverRing', CraftSilverRing)
RegisterNetEvent('t3_pawnjob:Client:CraftDiamondNecklace', CraftDiamondNecklace)
