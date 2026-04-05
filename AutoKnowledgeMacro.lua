local MACRO_NAME, T = ...
-- local MACRO_NAME = "AutoKnowledgeMacro"
if DLAPI then DLAPI.DebugLog(MACRO_NAME, "OK~"..MACRO_NAME.." loading...") end
SLASH_AUTOKNOWLEDGEMACRO1, SLASH_AUTOKNOWLEDGEMACRO2 = '/autokm', '/akm'
local BAGS = {
  Enum.BagIndex.Backpack,
  Enum.BagIndex.Bag_1,
  Enum.BagIndex.Bag_2,
  Enum.BagIndex.Bag_3,
  Enum.BagIndex.Bag_4
}

-- this will collect the above arrays, keyed under their Enum.Profession value
T.professionMap = {}
T.ENUM_PROFESSION_ALL = 9999
local professionMap = T.professionMap

-- cache the Enum.Profession values I know
local myProfession1 = nil
local myProfession2 = nil

-- This will hold a list of every profession item.  Key is item ID, value is {"profession" : Enum.Profession, "name" : name }
local ALL_PROFESSION_ITEMS = {}

local debug = false

professionMap[Enum.Profession.Alchemy] = {}
professionMap[Enum.Profession.Blacksmithing] = {}
professionMap[Enum.Profession.Enchanting] = {}
professionMap[Enum.Profession.Engineering] = {}
professionMap[Enum.Profession.Herbalism] = {}
professionMap[Enum.Profession.Inscription] = {}
professionMap[Enum.Profession.Jewelcrafting] = {}
professionMap[Enum.Profession.Leatherworking] = {}
professionMap[Enum.Profession.Mining] = {}
professionMap[Enum.Profession.Skinning] = {}
professionMap[Enum.Profession.Tailoring] = {}
professionMap[T.ENUM_PROFESSION_ALL] = {}

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
local function UpdateProfessions()
  apkPrint("WARN", "UpdateProfessions start")
  local prof1, prof2 = GetProfessions()

  if prof1 then
    local profession_name, _, _, _, _, _, skillLine, _ = GetProfessionInfo(prof1)
    local info = C_TradeSkillUI.GetProfessionInfoBySkillLineID(skillLine)
    apkPrint("ERR", "Skill line " .. tostring(skillLine) .. " and profession " .. profession_name .. " found")
    myProfession1 = info.profession
  else
    myProfession1 = nil
  end

  if prof2 then
    local profession_name, _, _, _, _, _, skillLine, _ = GetProfessionInfo(prof2)
    local info = C_TradeSkillUI.GetProfessionInfoBySkillLineID(skillLine)
    apkPrint("ERR", "Skill line " .. tostring(skillLine) .. " and profession " .. profession_name .. " found")
    myProfession2 = info.profession
  else
    myProfession2 = nil
  end

  apkPrint("WARN", "UpdateProfessions end")
end

local UpdateInProgress = false

--################################################################################--
-- This function updates the macro to the first item found for these professions
-- Clears the macro if there is nothing found
--################################################################################--
local function Update()
  if UpdateInProgress then
    apkPrint("WARN", "Update already in progress")
    return
  else
  apkPrint("WARN", "Update start...")
  end

  UpdateInProgress = true

  -- Give the addon some time for all the triggers to collect
  C_Timer.After(0.25, function()
  -- make sure we have a macro to update
  local macroSlot = GetMacroSlot()

  -- make sure our professions are found
  if myProfession1 == nil and myProfession2 == nil then UpdateProfessions() end

  -- if we still don't have any professions, don't bother
  if myProfession1 or myProfession2 then
    for _, tabID in ipairs(BAGS) do
      for slot=1, C_Container.GetContainerNumSlots(tabID) do
        local info = C_Container.GetContainerItemInfo(tabID, slot)
        if info and ALL_PROFESSION_ITEMS[info.itemID] then
          local profID = ALL_PROFESSION_ITEMS[info.itemID]["profession"]
            if profID == myProfession1 or profID == myProfession2 or profID == T.ENUM_PROFESSION_ALL then
            local displayText = C_Item.GetItemNameByID(info.itemID) or tostring(info.itemID)
            apkPrint ("OK", "Setting Auto PK to " .. displayText)
            local body = "#showtooltip ".. displayText .. "\n/use item:" .. tostring(info.itemID)
            EditMacro(macroSlot, MACRO_NAME, nil, body)
            apkPrint("WARN", "Update end, found " .. displayText)
              UpdateInProgress = false
            return
          end
        end
      end
    end
  end

  -- no items found or no professions found, leave it alone
  apkPrint("WARN", "Update end, nothing found")
  EditMacro(macroSlot, MACRO_NAME, "INV_Misc_QuestionMark", "/akm update")
    UpdateInProgress = false
  end)
end

--################################################################################--
-- (Almost) everything the addon needs to do, excludes static data
--################################################################################--
local function Reload()
  -- make sure we have a macro to update
  GetMacroSlot()

  ALL_PROFESSION_ITEMS = {}
  -- Load all item names in now, save us the trouble later
  for professionEnum, expansionList in pairs(professionMap) do
    for _, itemList in pairs(expansionList) do
      for _, itemID in pairs(itemList) do
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
  end

  UpdateProfessions()
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
    print("AutoKnowledgeMacro: Update complete")
  elseif msg == "debug" then
    debug = not debug
    apkPrint("OK", "AKM: Debug ".. (debug and "on" or "off"))
    print("AutoKnowledgeMacro: Debug ".. (debug and "on" or "off"))
  elseif msg == "pickup" then
    apkPrint("OK", "AKM: Picking up macro")
    PickupMacro(MACRO_NAME)
  elseif msg == "reload" then
    apkPrint("OK", "AKM: Updating professions")
    Reload()
    print("AutoKnowledgeMacro: Reload complete")
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
