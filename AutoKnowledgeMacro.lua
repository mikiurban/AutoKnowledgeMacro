local MACRO_NAME = "AutoKnowledgeMacro"
local BAGS = {
  Enum.BagIndex.Backpack,
  Enum.BagIndex.Bag_1,
  Enum.BagIndex.Bag_2,
  Enum.BagIndex.Bag_3,
  Enum.BagIndex.Bag_4
}
local ALCHEMY_PK_ITEMS = {
  238536, 238538, 238535, 238537, 238534, 238533, 238532, 238539, -- MID Treasures
  262645, -- Faction Vendor
  245755, -- Thalassian Treatise
  246320, 246321, -- Work Orders?
  259188, 259189, -- Chests
  263454, -- Weekly quest?
}
local BLACKSMITH_PK_ITEMS = {
  238546, 238547, 238540, 238543, 238541, 238542, 238545, 238544, -- MID Treasures
  262644, -- Faction Vendor
  245763, -- Thalassian Treatise
  246322, 246323, -- Work Orders?
  259190, 259191, -- Chests
  263455, -- Weekly quest
}
local ENCHANTING_PK_ITEMS = {
  238555, 238554, 238552, 238550, 238548, 238553, 238551, 238549, -- MID Treasures
  257600, -- Faction Vendor
  245759, -- Thalassian Treatise
  246324, 246325, -- Work Orders?
  259192, 259193, -- Chests
  263464, -- Weekly Quest
  250445, -- Vendor (Chel the Chip)
}
local ENGINEERING_PK_ITEMS = {
  238562, 238556, 238558, 238561, 238563, 238559, 238560, 238557, -- MID Treasures
  262646, -- Faction Vendor
  245809, -- Thalassian Treatise
  246326, 246327, -- Work Orders
  259194, 259195, -- Chests
  263456, -- Weekly Quest
}
local HERBALISM_PK_ITEMS = {
  238470, 238472, 238468, 238471, 238475, 238474, 238469, 238473, -- MID Treasures
  258410, -- Faction Vendor
  238465, 238467, 238466, -- Weekly Profession Drops
  245761, -- Thalassian Treatise
  263462, -- Weekly quest
  250443, -- Vendor (Chel the Chip)
}
local INSCRIPTION_PK_ITEMS = {
  238578, 238579, 238574, 238573, 238576, 238575, 238572, 238577, -- MID Treasures
  258411, -- Faction Vendor
  245757, -- Thalassian Treatise
  246328, 246329, -- Work orders?
  259196, 259197, -- Chests
  263457, -- Weekly quest
}
local JEWELCRAFTING_PK_ITEMS = {
  238580, 238585, 238583, 238587, 238581, 238586, 238584, 238582, -- MID Treasures
  257599, -- Faction Vendor
  245760, -- Thalassian Treatise
  246330, 246331, -- Work Orders
  259198, 259199, -- Chests
  263458, -- Weekly quest
}
local LEATHERWORKING_PK_ITEMS = {
  238595, 238591, 238588, 238594, 238589, 238590, 238593, 238592, -- MID Treasures
  250922, -- Faction Vendor
  245758, -- Thalassian Treatise
  246332, 246333, -- Work Ordesr?
  259200, 259201, -- Chests
  263459, -- Weekly quest
}
local MINING_PK_ITEMS = {
  238599, 238597, 238603, 238601, 238602, 238600, 238598, 238596, -- MID Treasures
  250924, -- Faction Vendor
  237507, 237496, 237506, -- Weekly Profession Drops
  245762, -- Thalassian Treatise
  263463, -- Weekly quest
  250444, -- Vendor (Chel the Chip)
}
local SKINNING_PK_ITEMS = {
  238633, 238635, 238632, 238634, 238629, 238630, 238628, 238631, -- MID Treasures
  250923, -- Faction Vendor
  245828, -- Thalassian Treatise
  263461, -- Weekly Quest
  238627, 238625, 238626, -- Profession drops?
  250360, -- Vendor (Chel the Chip)
}
local TAILORING_PK_ITEMS = {
  238613, 238618, 238619, 238614, 238612, 238615, 238616, 238617, -- MID Treasures
  257601, -- Faction Vendor
  245756, -- Thalassian Treatise
  246334, 246335, -- Work Orders?
  259202, 259203, -- Chests
  263460, -- Weekly quest
}
-- this will collect the above arrays, keyed under their Enum.Profession value
local professionMap = {}

-- This will hold a list of every profession item
local ALL_PROFESSION_ITEMS = {}

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

for _, itemList in pairs(professionMap) do
  for _, itemID in ipairs(itemList) do ALL_PROFESSION_ITEMS[itemID] = true end
end

local function apkPrint(...)
  if debug then
    print(...)
  end
end

local function GetMacroSlot()
  local macroSlot = GetMacroIndexByName(MACRO_NAME)
  if macroSlot == 0 then
    macroSlot = CreateMacro(MACRO_NAME, "INV_Misc_QuestionMark", "", false)
  end
  return macroSlot
end

local f = CreateFrame("Frame")

-- This function updates the macro to the first item found for these professions
-- Clears the macro if there is nothing found
local function UpdateMacro(prof1, prof2)
  local macroSlot = GetMacroSlot()

  local itemSet = {} -- This will hold a hash of item IDs we are interested in

  -- populate itemSet
  local profs = {prof1, prof2}
  for _, prof in ipairs(profs) do
    if prof ~= nil then
      local profession_name, _, _, _, _, _, skillLine, _ = GetProfessionInfo(prof)
      local info = C_TradeSkillUI.GetProfessionInfoBySkillLineID(skillLine)
      if info.profession then
        apkPrint("This character knows", profession_name, "(Enum.Profession =", info.profession, ")")
        for _, l in ipairs(professionMap[info.profession]) do itemSet[l] = true end
      end
    end
  end

  for _, tabID in ipairs(BAGS) do
    for slot=1, C_Container.GetContainerNumSlots(tabID) do
      local info = C_Container.GetContainerItemInfo(tabID, slot)
      if info and itemSet[info.itemID] then
        if ALL_PROFESSION_ITEMS[info.itemID] then
          local displayText = C_Item.GetItemNameByID(info.itemID)
          if displayText then
            apkPrint ("Setting Auto PK to " .. displayText)
            local body = "#show ".. displayText .. "\n/use " .. displayText
            EditMacro(macroSlot, MACRO_NAME, nil, body)
            return
          else
            -- force an item load
            apkPrint ("Forcing GetItemInfo() on " .. tostring(info.itemID))
            C_Item.GetItemInfo(info.itemID)
          end
        end
      end
    end
  end

  -- no items found, leave it alone
  apkPrint ("No PK items found")
  EditMacro(macroSlot, MACRO_NAME, "INV_Misc_QuestionMark", "")
end

local function Update()
  GetMacroSlot()

  -- get professions for this character
  local prof1, prof2 = GetProfessions()
  UpdateMacro(prof1, prof2)
end

function f:OnEvent(event, ...)
	self[event](self, event, ...)
end

function f:ADDON_LOADED(event, addOnName)
  if addOnName ~= MACRO_NAME then return end
	apkPrint(event, addOnName)
  Update()
end

function f:BAG_CONTAINER_UPDATE(event)
	apkPrint(event)
  Update()
end

function f:BAG_NEW_ITEMS_UPDATED(event)
	apkPrint(event)
  Update()
end

function f:BAG_UPDATE_DELAYED(event)
	apkPrint(event)
  Update()
end

function f:GET_ITEM_INFO_RECEIVED(event, itemID, success)
  if ALL_PROFESSION_ITEMS[itemID] then
	  apkPrint(event, "itemID:", itemID, "success:", success)
    if (success) then Update() end
  end
end

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("BAG_CONTAINER_UPDATE")
f:RegisterEvent("BAG_NEW_ITEMS_UPDATED")
f:RegisterEvent("GET_ITEM_INFO_RECEIVED")
f:RegisterEvent("BAG_UPDATE_DELAYED")
f:SetScript("OnEvent", f.OnEvent)