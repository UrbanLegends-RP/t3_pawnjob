Config = {}

Config.CoreName = "qb-core" -- Core name
Config.Job = "pawn" -- Job
Config.JimPayments = true -- Using jim-payments?
Config.Target = "qb-target" -- Name of your resource qb-target
Config.Input = "qb-input" -- Name of your resource qb-input
Config.Inv = "qb" -- Inventory system 
Config.InvLink = "ps-inventory/html/images/" -- Your directory images inventory
Config.Bossmenu = "qb-bossmenu:client:OpenMenu" -- Your trigger to open boss menu

Config.CraftLocations = {
    vector3(1697.43, 3779.25, 34.61), -- Example coordinates for crafting jewelry
    vector3(1697.54, 3783.32, 34.61), -- Another crafting spot
}

Config.StorageLocations = {
    vector3(1700.75, 3787.56, 34.97), -- Example coordinates for storage
    vector3(1697.28, 3785.22, 35.12), -- Another storage spot
}

Config.BillingLocation = vector3(-622.0, -231.0, 38.05) -- Example coordinates for billing
Config.BossMenuLocation = vector3(1706.99, 3788.94, 34.94) -- Example coordinates for boss menu

-- Extra
--Config.BossStashLocation = vector3(1706.99, 3788.94, 34.94) -- Boss stash location

Config.Billing = {
    EnableCommand = false,
    Command = "pawnjobbill",
}

Config.Stash = {
    StashInvTrigger = "inventory:client:SetCurrentStash",
    OpenInvTrigger = "inventory:server:OpenInventory",
    NameOfStash = "Pawn_Storage",
    MaxWeighStash = 50000,
    MaxSlotsStash = 20,
}

Config.Items = {
    [1] = { name = "gold_ring", price = 0, amount = 10, info = {}, type = "item", slot = 1 },
    [2] = { name = "silver_ring", price = 0, amount = 10, info = {}, type = "item", slot = 2 },
    [3] = { name = "diamond_necklace", price = 0, amount = 10, info = {}, type = "item", slot = 3 },
    [4] = { name = "gold_bar", price = 0, amount = 10, info = {}, type = "item", slot = 4 },
    [5] = { name = "silver_bar", price = 0, amount = 10, info = {}, type = "item", slot = 5 },
    [6] = { name = "diamond", price = 0, amount = 10, info = {}, type = "item", slot = 6 },
}

-- Craft Items
Config.Jewelry = {
    -- Rings
    ["gold_ring"] = { 
        hash = "gold_ring", 
        label = "Gold Ring",
        output_amount = 1, 
        materials = {
            [1] = { item = "goldore", amount = 2 },
        }
    },
    ["silver_ring"] = { 
        hash = "silver_ring", 
        label = "Silver Ring",
        output_amount = 1,  
        materials = {
            [1] = { item = "silverore", amount = 2 },
        }
    },
    ["diamond_ring"] = { 
        hash = "diamond_ring", 
        label = "Diamond Ring",
        output_amount = 1, 
        materials = {
            [1] = { item = "goldore", amount = 1 },
            [2] = { item = "diamond", amount = 1 },
        }
    },
    -- Necklaces
    ["diamond_necklace"] = { 
        hash = "diamond_necklace", 
        label = "Diamond Necklace",
        output_amount = 1, 
        materials = {
            [1] = { item = "goldore", amount = 2 },
            [2] = { item = "diamond", amount = 1 },
        }
    },
    -- Watches
    ["rolex"] = { 
        hash = "rolex", 
        label = "Rolex Watch",
        output_amount = 1, 
        materials = {
            [1] = { item = "goldore", amount = 3 },
            [2] = { item = "diamond", amount = 2 },
        }
    },
    -- Chains
    ["goldchain"] = { 
        hash = "goldchain", 
        label = "Gold Chain",
        output_amount = 1, 
        materials = {
            [1] = { item = "goldore", amount = 2 },
        }
    },
    ["tenkgoldchain"] = { 
        hash = "tenkgoldchain", 
        label = "10k Gold Chain",
        output_amount = 1, 
        materials = {
            [1] = { item = "goldore", amount = 5 },
        }
    },
}
