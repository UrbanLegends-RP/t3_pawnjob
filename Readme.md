```markdown
# t3_pawnjob

## Overview
`t3_pawnjob` is a pawnshop job script for FiveM servers using the QBCore framework. This script allows players to perform various tasks within a pawnshop, including crafting jewelry, managing storage, and accessing a boss menu. It uses `qb-target` for interactive zones and `qb-menu` for crafting menus.

## Features
- Craft various pieces of jewelry.
- Manage storage for crafted items.
- Boss menu for job management.
- Configurable through `config.lua`.

## Installation

### Requirements
- [QBCore Framework](https://github.com/qbcore-framework/qb-core)
- [oxmysql](https://github.com/overextended/oxmysql)
- [qb-target](https://github.com/qbcore-framework/qb-target)
- [qb-menu](https://github.com/qbcore-framework/qb-menu)
- [PolyZone](https://github.com/mkafrin/PolyZone)
- [ox_lib](https://github.com/overextended/ox_lib)

### Steps
1. **Clone the Repository:**
   ```bash
   git clone https://github.com/YourGitHubUsername/t3_pawnjob.git
   ```

2. **Add to Server Resources:**
   Move the `t3_pawnjob` folder to your `resources` directory.

3. **Add to Server Configuration:**
   Add the following line to your `server.cfg`:
   ```plaintext
   ensure t3_pawnjob
   ```

4. **Ensure Dependencies:**
   Ensure that the required dependencies are installed and configured properly.

### Configuration
Modify the `config.lua` file to suit your server's needs.

```lua
Config = {}

Config.CoreName = "qb-core"
Config.Job = "pawn"
Config.JimPayments = true
Config.Target = "qb-target"
Config.Input = "qb-input"
Config.Inv = "qb"
Config.InvLink = "ps-inventory/html/images/"
Config.Bossmenu = "qb-bossmenu:client:OpenMenu"

Config.CraftLocations = {
    vector3(1697.43, 3779.25, 34.61),
    vector3(1697.54, 3783.32, 34.61),
}

Config.StorageLocations = {
    vector3(1700.75, 3787.56, 34.97),
    vector3(1697.28, 3785.22, 35.12),
}

Config.BillingLocation = vector3(-622.0, -231.0, 38.05)
Config.BossMenuLocation = vector3(1706.99, 3788.94, 34.94)
Config.BossStashLocation = vector3(1706.99, 3788.94, 34.94)

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

Config.Jewelry = {
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
    ["diamond_necklace"] = { 
        hash = "diamond_necklace", 
        label = "Diamond Necklace",
        output_amount = 1, 
        materials = {
            [1] = { item = "goldore", amount = 2 },
            [2] = { item = "diamond", amount = 1 },
        }
    },
    ["rolex"] = { 
        hash = "rolex", 
        label = "Rolex Watch",
        output_amount = 1, 
        materials = {
            [1] = { item = "goldore", amount = 3 },
            [2] = { item = "diamond", amount = 2 },
        }
    },
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
```

## Usage
### Crafting Jewelry
1. Approach a crafting location (configured in `config.lua`).
2. Press the interaction key to open the crafting menu.
3. Select the item you want to craft. The required materials will be displayed in the menu.

### Managing Storage
1. Approach a storage location (configured in `config.lua`).
2. Press the interaction key to open the storage.

### Boss Menu
1. Approach the boss menu location (configured in `config.lua`).
2. Press the interaction key to open the boss menu.

### Billing
1. Approach the billing location (configured in `config.lua`).
2. Press the interaction key to handle billing.

## Credits
- Script developed by T3D.
- Uses QBCore Framework.
- Dependencies: oxmysql, qb-target, qb-menu, PolyZone, ox_lib.

## License
This project is licensed under the MIT License.
```