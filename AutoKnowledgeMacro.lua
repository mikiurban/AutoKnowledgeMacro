local MACRO_NAME = "AutoKnowledgeMacro"
if DLAPI then DLAPI.DebugLog(MACRO_NAME, "OK~"..MACRO_NAME.." loading...") end
SLASH_AUTOKNOWLEDGEMACRO1, SLASH_AUTOKNOWLEDGEMACRO2 = '/autokm', '/akm'
local BAGS = {
  Enum.BagIndex.Backpack,
  Enum.BagIndex.Bag_1,
  Enum.BagIndex.Bag_2,
  Enum.BagIndex.Bag_3,
  Enum.BagIndex.Bag_4
}
local ALCHEMY_PK_ITEMS = {
  -- MID Treasures
  238532, -- Vial of Eversong Oddities
  238533, -- Vial of Voidstorm Oddities
  238534, -- Vial of Rootlands Oddities
  238535, -- Vial of Zul'Aman Oddities
  238536, -- Freshly Plucked Peacebloom
  238537, -- Measured Ladle
  238538, -- Pristine Potion
  238539, -- Failed Experiment
  -- Thalassian Treatise
  245755, -- Thalassian Treatise on Alchemy
  -- Work Orders
  246320, -- Flicker of Midnight Alchemy Knowledge
  246321, -- Glimmer of Midnight Alchemy Knowledge
  -- Secret
  255828, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Alchemy
  -- Chests
  259188, -- Lightbloomed Spore Sample
  259189, -- Aged Cruor
  -- Faction Vendor
  262645, -- Beyond the Event Horizon: Alchemy
  -- Weekly quest  
  263454, -- Thalassian Alchemist's Notebook
}
local BLACKSMITH_PK_ITEMS = {
  -- MID Treasures
  238540, -- Deconstructed Forge Techniques
  238541, -- Silvermoon Smithing Kit
  238542, -- Carefully Racked Spear
  238543, -- Metalworking Cheat Sheet
  238544, -- Voidstorm Defense Spear
  238545, -- Rutaani Floratender's Sword
  238546, -- Sin'dorei Master's Forgemace
  238547, -- Silvermoon Blacksmith's Hammer
  -- Thalassian Treatise
  245763, -- Thalassian Treatise on Blacksmithing
  -- Work Orders
  246322, -- Flicker of Midnight Blacksmithing Knowledge
  246323, -- Glimmer of Midnight Blacksmithing Knowledge
  -- Secret
  255829, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Blacksmithing
  -- Chests
  259190, -- Thalassian Whestone
  259191, -- Infused Quenching Oil
  -- Faction Vendor
  262644, -- Beyond the Event Horizon: Blacksmithing
  -- Weekly Quest
  263455, -- Thalassian Blacksmith's Journal
}
local ENCHANTING_PK_ITEMS = {
  -- MID Treasures
  238548, -- Enchanted Amani Mask
  238549, -- Enchanted Sunfire Silk
  238550, -- Pure Void Crystal
  238551, -- Everblazing Sunmote
  238552, -- Entropic Shard
  238553, -- Primal Essence Orb
  238554, -- Loa-Blessed Dust
  238555, -- Sin'dorei Enchanting Rod
  -- Thalassian Treatise
  245759, -- Thalassian Treatise on Enchanting
  -- Work Orders
  246324, -- Flicker of Midnight Enchanting Knowledge
  246325, -- Glimmer of Midnight Enchanting Knowledge
  -- Chel the Chip
  250445, -- Echo of Abundance: Enchanting 
  -- Secret
  255830, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Enchanting
  -- Faction Vendor
  257600, -- Skill Issue: Enchanting
  -- Chests
  259192, -- Voidstorm Ashes
  259193, -- Lost Thalassian Vellum
  -- Weekly Quest
  263464, -- Thalassian Enchanter's Folio
  -- Disenchanting
  267654, -- Swirling Arcane Essence
  268655, -- Brimming Mana Shard
}
local ENGINEERING_PK_ITEMS = {
  -- MID Treasures
  238556, -- One Engineer's Junk
  238557, -- Miniaturized Transport Skiff
  238558, -- Manual of Mistakes and Mishaps
  238559, -- Expeditious Pylon
  238560, -- Ethereal Stormwrench
  238561, -- Offline Helper Bot
  238562, -- What To Do When Nothing Works
  238563, -- Handy Wrench
  -- Thalassian Treatise
  245809, -- Thalassian Treatise on Engineering
  -- Work Orders
  246326, -- Flicker of Midnight Engineering Knowledge
  246327, -- Glimmer of Midnight Engineering Knowledge
  -- Secrets
  255831, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Engineering
  -- Chests
  259194, -- Dance Gear
  259195, -- Dawn Capacitor
  -- Faction Vendor
  262646, -- Beyond the Event Horizon: Engineering
  -- Weekly Quest
  263456, -- Thalassian Engineer's Notepad 
}
local HERBALISM_PK_ITEMS = {
  -- Weekly Profession Drops
  238465, -- Thalassian Phoenix Plume
  238466, -- Thalassian Phoenix Tail
  238467, -- Thalassian Phoenix Ember
  -- MID Treasures
  238468, -- Bloomed Bud
  238469, -- Sweeping Harvester's Scythe
  238470, -- Simple Leaf Pruners
  238471, -- Lightbloom Root
  238472, -- A Spade
  238473, -- Harvester's Sickle
  238474, -- Peculiar Lotus
  238475, -- Planting Shovel
  -- Thalassian Treatise
  245761, -- Thalassian Treatise on Herbalism
  -- Vendor (Chel the Chip)
  250443, -- Echo of Abundance: Herbalism
  -- Secret
  255832, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Herbalism
  -- Faction Vendor
  258410, -- Traditions of the Haranir: Herbalism
  -- Weekly quest
  263462, -- Thalassian Herbalist's Notes
}
local INSCRIPTION_PK_ITEMS = {
  -- MID Treasures
  238572, -- Void-Touched Quill
  238573, -- Leather-Bound Techniques
  238574, -- Spare Ink
  238575, -- Intrepid Explorer's Marker
  238576, -- Leftover Sanguithorn Pigment
  238577, -- Half-Baked Techniques
  238578, -- Songwriter's Pen
  238579, -- Songwriter's Quill
  -- Thalassian Treatise
  245757, -- Thalassian Treatise on Inscription
  -- Work orders
  246328, -- Flicker of Midnight Inscription Knowledge
  246329, -- Glimmer of Midnight Inscription Knowledge
  -- Secret
  255833, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Inscription
  -- Faction Vendor
  258411, -- Traditions of the Haranir: Inscription
  -- Chests
  259196, -- Brilliant Phoenix Ink
  259197, -- Loa-Blessed Rune
  -- Weekly quest
  263457, -- Thalassian Scribe's Journal
}
local JEWELCRAFTING_PK_ITEMS = {
  -- MID Treasures
  238580, -- Sin'dorei Masterwork Chisel
  238581, -- Speculative Voidstorm Crystal
  238582, -- Dual-Function Magnifiers
  238583, -- Poorly Rounded Vial
  238584, -- Shattered Glass
  238585, -- Vintage Soul Gem
  238586, -- Ethereal Gem Pliers
  238587, -- Sin'dorei Gem Faceters
  -- Thalassian Treatise
  245760, -- Thalassian Treatise on Jewelcrafting
  -- Work Orders
  246330, -- Flicker of Midnight Jewelcrafting Knowledge
  246331, -- Glimmer of Midnight Jewelcrafting Knowledge
  -- Secret
  255834, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Jewelcrafting
  -- Faction Vendor
  257599, -- Skill Issue: Jewelcrafting
  -- Chests
  259198, -- Void-Touched Eversong Diamond Fragments
  259199, -- Harandar Stone Sample
  -- Weekly Quest
  263458, -- Thalassian Jewelcrafter's Notebook
}
local LEATHERWORKING_PK_ITEMS = {
  -- MID Treasures  
  238588, -- Amani Leatherworker's Tool
  238589, -- Ethereal Leatherworking Knife
  238590, -- Prestigiously Racked Hide
  238591, -- Bundle of Tanner's Trinkets
  238592, -- Patterns: Beyond the Void
  238593, -- Haranir Leatherworking Mallet
  238594, -- Haranir Leatherworking Knife
  238595, -- Artisan's Considered Order
  -- Thalassian Treatise
  245758, -- Thalassian Treatise on Leatherworking
  -- Work Orders
  246332, -- Flicker of Midnight Leatherworking Knowledge
  246333, -- Glimmer of Midnight Leatherworking Knowledge
  -- Faction Vendor
  250922, -- Whisper of the Loa: Leatherworking
  -- Secret
  255835, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Leatherworking
  -- Chests
  259200, -- Amani Tanning Oil
  259201, -- Thalassian Mana Oil
  -- Weekly quest
  263459, -- Thalassian Leatherworker's Journal
}
local MINING_PK_ITEMS = {
  -- Weekly Profession Drops
  237496, -- Igneous Rock Specimen
  237506, -- Septarian Nodule
  237507, -- Cloudy Quartz
  -- MID Treasures
  238596, -- Miner's Guide to Voidstorm
  238597, -- Spelunker's Lucky Charm
  238598, -- Lost Voidstorm Satchel
  238599, -- Solid Ore Punchers
  238600, -- Glimmering Void Pearl
  238601, -- Amani Expert's Chisel
  238602, -- Star Metal Deposit
  238603, -- Spare Expedition Torch
  -- Thalassian Treatise
  245762, -- Thalassian Treatise on Mining
  -- Vendor (Chel the Chip)
  250444, -- Echo of Abundance: Mining
  -- Faction Vendor
  250924, -- Whisper of the Loa: Mining
  -- Secret
  255836, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Mining
  -- Weekly Quest
  263463, -- Thalassian Miner's Notes
}
local SKINNING_PK_ITEMS = {
  -- Profession drops
  238625, -- Fine Void-Tempered Hide
  238626, -- Mana-Infused Bone
  238627, -- Manafused Sample
  -- MID Treasures
  238628, -- Lightbloom Afflicted Hide
  238629, -- Cadre Skinning Knife
  238630, -- Primal Hide
  238631, -- Voidstorm Leather Sample
  238632, -- Amani Tanning Oil
  238633, -- Sin'dorei Tanning Oil
  238634, -- Amani Skinning Knife
  238635, -- Thalassian Skinning Knife
  -- Thalassian Treatise
  245828, -- Thalassian Treatise on Skinning
  -- Vendor (Chel the Chip)
  250360, -- Echo of Abundance: Skinning
  250923, -- Whisper of the Loa: Skinning
  -- Weekly Quest
  263461, -- Thalassian Skinner's Notes
}
local TAILORING_PK_ITEMS = {
  -- MID Treasures
  238612, -- A Child's Stuffy
  238613, -- A Really Nice Curtain
  238614, -- Sin'dorei Outfitter's Ruler
  238615, -- Wooden Weaving Sword
  238616, -- Book of Sin'dorei Stitches
  238617, -- Satin Throw Pillow
  238618, -- Particularly Enchanting Tablecloth
  238619, -- Artisan's Cover Comb
  -- Thalassian Treatise
  245756, -- Thalassian Treatise on Tailoring
  -- Work Orders
  246334, -- Flicker of Midnight Tailoring Knowledge
  246335, -- Glimmer of Midnight Tailoring Knowledge
  -- Secret
  255838, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Tailoring
  -- Faction Vendor
  257601, -- Skill Issue: Tailoring
  -- Chests
  259202, -- Embroidered Memento
  259203, -- Finely Woven Lynx Collar
  -- Weekly quest
  263460, -- Thalassian Tailor's Notebook
}
-- this will collect the above arrays, keyed under their Enum.Profession value
local professionMap = {}

-- This will hold a list of every profession item.  Key is item ID, value is {"profession" : Enum.Profession, "name" : name }
local ALL_PROFESSION_ITEMS = {}

-- This will hold a list of profession items I can use
local MY_PROFESSION_ITEMS = {}

-- Need to slashcmd this later
local debug = false

professionMap[Enum.Profession.Alchemy] = ALCHEMY_PK_ITEMS
professionMap[Enum.Profession.Blacksmithing] = BLACKSMITH_PK_ITEMS
professionMap[Enum.Profession.Enchanting] = ENCHANTING_PK_ITEMS
professionMap[Enum.Profession.Engineering] = ENGINEERING_PK_ITEMS
professionMap[Enum.Profession.Herbalism] = HERBALISM_PK_ITEMS
professionMap[Enum.Profession.Inscription] = INSCRIPTION_PK_ITEMS
professionMap[Enum.Profession.Jewelcrafting] = JEWELCRAFTING_PK_ITEMS
professionMap[Enum.Profession.Leatherworking] = LEATHERWORKING_PK_ITEMS
professionMap[Enum.Profession.Mining] = MINING_PK_ITEMS
professionMap[Enum.Profession.Skinning] = SKINNING_PK_ITEMS
professionMap[Enum.Profession.Tailoring] = TAILORING_PK_ITEMS

--################################################################################--
-- Only prints the message if debug == true
--################################################################################--
local function apkPrint(level, ...)
  local status, res = pcall(format, ...)
  if debug then
    if DLAPI then
      DLAPI.DebugLog(MACRO_NAME, level .."~".. res)
    else
    print(...)
  end
end
end

--################################################################################--
-- return the profession enum if it is an item
--################################################################################--
local function GetProfessionFromItemID(itemID)
  return ALL_PROFESSIONS_FROM_ID[itemID]
end

--################################################################################--
-- return true if I know this Enum.Profession
--################################################################################--
local function ProfessionLearned(profEnum)
  local prof1, prof2 = GetProfessions()
  local profs = {prof1, prof2}
  for _, prof in ipairs(profs) do
    if prof ~= nil then
      local profession_name, _, _, _, _, _, skillLine, _ = GetProfessionInfo(prof)
      local info = C_TradeSkillUI.GetProfessionInfoBySkillLineID(skillLine)
      if info and info.profession and info.profession == profEnum then return true end
    end
  end
  return false
end


--################################################################################--
-- return the macro index, create one if we need
--################################################################################--
local function GetMacroSlot()
  local macroSlot = GetMacroIndexByName(MACRO_NAME)
  if macroSlot == 0 then
    macroSlot = CreateMacro(MACRO_NAME, "INV_Misc_QuestionMark", "", false)
  end
  return macroSlot
end

local f = CreateFrame("Frame")

--################################################################################--
-- Builds a list of items useable by the professions I have
--################################################################################--
local function UpdateProfessionItems()
  apkPrint("WARN", "UpdateProfessionItems start...")
  local prof1, prof2 = GetProfessions()
  MY_PROFESSION_ITEMS = {}

  -- populate itemSet
  local profs = {prof1, prof2}
  for _, prof in ipairs(profs) do
    if prof ~= nil then
      local profession_name, _, _, _, _, _, skillLine, _ = GetProfessionInfo(prof)
      local info = C_TradeSkillUI.GetProfessionInfoBySkillLineID(skillLine)
      apkPrint("ERR", "Skill line " .. tostring(skillLine) .. " and profession " .. profession_name .. " found")
      if info.profession then
        apkPrint("WARN", "Enum.Profession = " .. tostring(info.profession) )
        for _, l in ipairs(professionMap[info.profession]) do MY_PROFESSION_ITEMS[l] = true end
      else
        apkPrint("ERR", "Skill line " .. tostring(skillLine) .. " did not return any info")
      end
    end
  end

  apkPrint("WARN", "UpdateProfessionItems end")
end

--################################################################################--
-- This function updates the macro to the first item found for these professions
-- Clears the macro if there is nothing found
--################################################################################--
local function Update()
  -- make sure we have a macro to update
  local macroSlot = GetMacroSlot()
  local foundIt = false
  apkPrint("WARN", "Update start...")
  for _, tabID in ipairs(BAGS) do
    for slot=1, C_Container.GetContainerNumSlots(tabID) do
      local info = C_Container.GetContainerItemInfo(tabID, slot)
      if info and MY_PROFESSION_ITEMS[info.itemID] then
        foundIt = true
      elseif info and ALL_PROFESSION_ITEMS[info.itemID] then
        local profID = ALL_PROFESSION_ITEMS[info.itemID]["profession"]
        if ProfessionLearned(profID) then
          apkPrint("ERR", "Item " .. tostring(info.itemID) .. " was in ALL_PROFESSIONS but not MY_PROFESSIONS")
          MY_PROFESSION_ITEMS[info.itemID] = true
          foundIt = true
        end
      end

      if foundIt then
        local displayText = C_Item.GetItemNameByID(info.itemID) or tostring(info.itemID)
        apkPrint ("OK", "Setting Auto PK to " .. displayText)
        local body = "#showtooltip ".. displayText .. "\n/use item:" .. tostring(info.itemID)
        EditMacro(macroSlot, MACRO_NAME, nil, body)
        apkPrint("WARN", "Update end, found " .. displayText)
        return
      end
    end
  end

  -- no items found, leave it alone
  apkPrint("WARN", "Update end, nothing found")
  EditMacro(macroSlot, MACRO_NAME, "INV_Misc_QuestionMark", "/akm update")
end

--################################################################################--
-- (Almost) everything the addon needs to do, excludes static data
--################################################################################--
local function Reload()
  -- make sure we have a macro to update
  GetMacroSlot()

  ALL_PROFESSION_ITEMS = {}
  -- Load all item names in now, save us the trouble later
  for professionEnum, itemList in pairs(professionMap) do
    for _, itemID in ipairs(itemList) do
      ALL_PROFESSION_ITEMS[itemID] = { profession = professionEnum, name = tostring(itemID) }
      local item = Item:CreateFromItemID(itemID)

      item:ContinueOnItemLoad(function()
        local id = item:GetItemID()
        local name = item:GetItemName()
        if name then ALL_PROFESSION_ITEMS[id]["name"] = name end
        Update()
      end)
    end
  end

  UpdateProfessionItems()
  Update()
end

--################################################################################--
-- EVENT HANDLING
--################################################################################--
function f:OnEvent(event, ...)
	self[event](self, event, ...)
end

function f:ADDON_LOADED(event, addOnName)
  if addOnName ~= MACRO_NAME then return end
	apkPrint("WARN", event .. " " .. addOnName)

  Reload()
end

function f:BAG_CONTAINER_UPDATE(event)
	apkPrint("WARN", event)
  Update()
end

function f:BAG_NEW_ITEMS_UPDATED(event)
	apkPrint("WARN", event)
  Update()
end

function f:BAG_UPDATE_DELAYED(event)
	apkPrint("WARN", event)
  Update()
end

function f:PLAYER_LEAVE_COMBAT(event)
	apkPrint("WARN", event)
  Update()
end

function f:SKILL_LINE_SPECS_UNLOCKED(event)
	apkPrint("WARN", event)
  Reload()
end

function f:SKILL_LINE_SPECS_RANKS_CHANGED(event)
	apkPrint("WARN", event)
  Reload()
end

function f:GET_ITEM_INFO_RECEIVED(event, itemID, success)
  if ALL_PROFESSION_ITEMS[itemID] then
	  apkPrint("WARN", event .. " itemID: " .. tostring(itemID) .. " success: " .. tostring(success))
    if (success) then
      local name = C_Item.GetItemNameByID(itemID)
      if name then ALL_PROFESSION_ITEMS[itemID]["name"] = name end
      Update()
    end
  end
end

--################################################################################--
-- REGISTER EVENT HANDLING
--################################################################################--

f:RegisterEvent("ADDON_LOADED") -- Init tables, get all item names
f:RegisterEvent("BAG_CONTAINER_UPDATE") -- a bag changed? 
f:RegisterEvent("BAG_NEW_ITEMS_UPDATED") -- looted something?
f:RegisterEvent("BAG_UPDATE_DELAYED") -- bunch of stuff in the bags updated
f:RegisterEvent("PLAYER_LEAVE_COMBAT") -- if you looted something while fighting
f:RegisterEvent("SKILL_LINE_SPECS_UNLOCKED") -- learn\drop a profession? maybe?
f:RegisterEvent("SKILL_LINE_SPECS_RANKS_CHANGED") -- learn\drop a profession? maybe?
f:RegisterEvent("GET_ITEM_INFO_RECEIVED") -- Called C_Item.GetItemName(), name is ready

f:SetScript("OnEvent", f.OnEvent)

--################################################################################--
-- Slash commands
--################################################################################--
SlashCmdList["AUTOKNOWLEDGEMACRO"] = function(msg, editBox)
  if msg == "update" then
    apkPrint("OK", "AKM: Forcing update...")
    Update()
    apkPrint("OK", "AKM: Complete")
  elseif msg == "debug" then
    debug = not debug
    apkPrint("OK", "AKM: Debug ".. (debug and "on" or "off") )
  elseif msg == "pickup" then
    apkPrint("OK", "AKM: Picking up macro")
    PickupMacro(MACRO_NAME)
  elseif msg == "reload" then
    apkPrint("OK", "AKM: Updating professions")
    Reload()
  elseif msg == "help" or msg == nil or msg == "" then
    print("AutoKnowledgeMacro commands: /autokm or /akm")
    print("Options:")
    print("/akm update       Rescan bags for items")
    print("/akm debug        Toggle debug messages on/off")
    print("/akm pickup       Grabs macro from Macro Dialog, drag it to an action bar")
    print("/akm reload       Force reload of AKM")
    print("/akm help         Display this help info")
  end
  end
