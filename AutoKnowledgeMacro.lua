local MACRO_NAME, AutoKnowledgeMacro = ...

if DLAPI then DLAPI.DebugLog(MACRO_NAME, "OK~"..MACRO_NAME.." loading...") end
SLASH_AUTOKNOWLEDGEMACRO1, SLASH_AUTOKNOWLEDGEMACRO2 = '/autokm', '/akm'
local BAGS = {
  Enum.BagIndex.Backpack,
  Enum.BagIndex.Bag_1,
  Enum.BagIndex.Bag_2,
  Enum.BagIndex.Bag_3,
  Enum.BagIndex.Bag_4,
  Enum.BagIndex.ReagentBag
}

AutoKnowledgeMacro.ENUM_PROFESSION_ALL = 9999
AutoKnowledgeMacro.SettingCategoryID = nil

-- cache the Enum.Profession values I know
local myProfession1 = nil
local myProfession2 = nil

-- This will hold a list of the names of every item.  Key is item ID, value is {"name" : name, "nameFound" : true/false }
AutoKnowledgeMacro.NameCache = {}
local KEY_NAME = "name"
local KEY_NAMEFOUND = "nameFound"

-- This will hold a list of every profession item.  Key is item ID, value is {"profession" : Enum.Profession }
AutoKnowledgeMacro.ActiveProfessionItems = {}
local KEY_PROFESSION = "profession"
-- Master list of the above cache
AutoKnowledgeMacro.professionMap = {}

-- This will hold a list of every profession item that can be disabled by a quest, like treatises.  Key is item ID in string, val is quest ID to check
AutoKnowledgeMacro.ActiveQuestFlaggedItems = {}
-- Master list of the above cache
AutoKnowledgeMacro.treatises = {}

-- This will hold a list of every profession item that requires a minimum quantity to be useful, like Multicraft Matrix
AutoKnowledgeMacro.MinimumQuantityItems = {}
-- Master list of the above cache
AutoKnowledgeMacro.finishingReagents = {}

AutoKnowledgeMacro.professionMap[Enum.Profession.Alchemy] = {}
AutoKnowledgeMacro.professionMap[Enum.Profession.Blacksmithing] = {}
AutoKnowledgeMacro.professionMap[Enum.Profession.Enchanting] = {}
AutoKnowledgeMacro.professionMap[Enum.Profession.Engineering] = {}
AutoKnowledgeMacro.professionMap[Enum.Profession.Herbalism] = {}
AutoKnowledgeMacro.professionMap[Enum.Profession.Inscription] = {}
AutoKnowledgeMacro.professionMap[Enum.Profession.Jewelcrafting] = {}
AutoKnowledgeMacro.professionMap[Enum.Profession.Leatherworking] = {}
AutoKnowledgeMacro.professionMap[Enum.Profession.Mining] = {}
AutoKnowledgeMacro.professionMap[Enum.Profession.Skinning] = {}
AutoKnowledgeMacro.professionMap[Enum.Profession.Tailoring] = {}
AutoKnowledgeMacro.professionMap[AutoKnowledgeMacro.ENUM_PROFESSION_ALL] = {}

--################################################################################--
-- Only prints the message if debug == true
--################################################################################--
local function apkPrint(level, ...)
  local status, res = pcall(format, ...)
  if AutoKnowledgeMacro_SavedVars and AutoKnowledgeMacro_SavedVars.debug then
    if DLAPI then
      DLAPI.DebugLog(MACRO_NAME, level .."~".. res)
    else
      print(...)
    end
  end
end

--################################################################################--
-- Returns true if this is a finishing reagent
--################################################################################--
function AutoKnowledgeMacro:IsFinishingReagent(itemID)
  if itemID then
    for _, expansionList in pairs(AutoKnowledgeMacro.finishingReagents) do
      for _, reagentPair in ipairs(expansionList) do
        if itemID == reagentPair.itemID then return true end
      end
    end
  end
  return false
end

--################################################################################--
-- "Simple" version of  "C_Item.GetItemNameByID()" 
--################################################################################--
function AutoKnowledgeMacro:GetItemNameByID(itemID)
  -- already downloaded?
  if AutoKnowledgeMacro.NameCache[itemID][KEY_NAMEFOUND] then
    return AutoKnowledgeMacro.NameCache[itemID][KEY_NAME]
  end

  -- already cached?
  local cachedName = C_Item.GetItemNameByID(itemID)
  if cachedName then
      AutoKnowledgeMacro.NameCache[itemID][KEY_NAME] = cachedName
      AutoKnowledgeMacro.NameCache[itemID][KEY_NAMEFOUND] = true
      return cachedName
  end

  -- go get it :/
  local item = Item:CreateFromItemID(itemID)
  item:ContinueOnItemLoad(function()
    local id = item:GetItemID()
    local name = item:GetItemName()
    apkPrint("OK", "ContinueOnItemLoad for " .. tostring(id) .. " " .. name)
    if name then
      AutoKnowledgeMacro.NameCache[id][KEY_NAME] = name
      AutoKnowledgeMacro.NameCache[id][KEY_NAMEFOUND] = true

      if AutoKnowledgeMacro:IsFinishingReagent(itemID) then
        AutoKnowledgeMacro:InitializeSettings()
      end
    end
  end)
  return nil
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
-- Returns true if this is a treatise and I already learned it this week
--################################################################################--
local function IsItemUsed(itemID)
  if itemID and AutoKnowledgeMacro.ActiveQuestFlaggedItems[tostring(itemID)] then
    return C_QuestLog.IsQuestFlaggedCompleted(AutoKnowledgeMacro.ActiveQuestFlaggedItems[tostring(itemID)])
  end
  return false
end

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
function AutoKnowledgeMacro:Update()
  if UpdateInProgress then
    apkPrint("WARN", "Update already in progress")
    return
  end

  UpdateInProgress = true
  apkPrint("WARN", "Update start...")

  -- make sure we have a macro to update
  local macroSlot = GetMacroSlot()

  -- make sure our professions are found
  if myProfession1 == nil and myProfession2 == nil then UpdateProfessions() end

  -- if we still don't have any professions, don't bother
  if myProfession1 or myProfession2 then
    for _, tabID in ipairs(BAGS) do
      for slot=1, C_Container.GetContainerNumSlots(tabID) do
        local info = C_Container.GetContainerItemInfo(tabID, slot)
        if info then
          local key = tostring(info.itemID)
          if AutoKnowledgeMacro.ActiveProfessionItems[info.itemID] then
          if IsItemUsed(info.itemID) then
              apkPrint ("OK", "Already used " .. key .. " this week");
          else
              local profID = AutoKnowledgeMacro.ActiveProfessionItems[info.itemID][KEY_PROFESSION]
            if profID == myProfession1 or profID == myProfession2 or profID == AutoKnowledgeMacro.ENUM_PROFESSION_ALL then
                local displayText = AutoKnowledgeMacro:GetItemNameByID(info.itemID) or key
            apkPrint ("OK", "Setting Auto PK to " .. displayText)
                local body = "#showtooltip ".. displayText .. "\n/use item:" .. key
                EditMacro(macroSlot, MACRO_NAME, nil, body)
                apkPrint("WARN", "Update end, found " .. displayText)
                UpdateInProgress = false
                return
              end
            end
          elseif AutoKnowledgeMacro:IsFinishingReagent(info.itemID) then
            local value = AutoKnowledgeMacro_SavedVars[key]
            if value and C_Item.GetItemCount(info.itemID) >= AutoKnowledgeMacro.MinimumQuantityItems[key] then
              local displayText = AutoKnowledgeMacro:GetItemNameByID(info.itemID) or key
              local body = "#showtooltip ".. displayText .. "\n/use item:" .. key
            EditMacro(macroSlot, MACRO_NAME, nil, body)
            apkPrint("WARN", "Update end, found " .. displayText)
              UpdateInProgress = false
            return
          end
        end
      end
    end
  end
  end

  -- no items found or no professions found, leave it alone
  apkPrint("WARN", "Update end, nothing found")
  EditMacro(macroSlot, MACRO_NAME, "INV_Misc_QuestionMark", "/akm update")
  -- Give the addon some time for all the triggers to collect
  C_Timer.After(0.1, function()
    UpdateInProgress = false
  end)
end

function AutoKnowledgeMacro:ReloadAllProfessionItems()
  AutoKnowledgeMacro.ActiveProfessionItems = {}
  -- Load all item names in now, save us the trouble later
  for professionEnum, expansionList in pairs(AutoKnowledgeMacro.professionMap) do
    for _, itemList in pairs(expansionList) do
      for _, itemID in pairs(itemList) do
        AutoKnowledgeMacro.ActiveProfessionItems[itemID] = { profession = professionEnum }
        if not AutoKnowledgeMacro.NameCache[itemID] then
          AutoKnowledgeMacro.NameCache[itemID] = { name = tostring(itemID), nameFound = false }
          AutoKnowledgeMacro:GetItemNameByID(itemID)
        end
      end
      end
    end
  end

function AutoKnowledgeMacro:ReloadAllQuestFlaggedItems()
  AutoKnowledgeMacro.ActiveQuestFlaggedItems = {}
  if AutoKnowledgeMacro_SavedVars.treatises then
    for professionEnum, expansionList in pairs(AutoKnowledgeMacro.treatises) do
    for _, itemQuestPair in ipairs(expansionList) do
      local key = tostring(itemQuestPair.itemID)
      apkPrint("OK", "item ID: " .. key .. ", questID: " .. tostring(itemQuestPair.questID))
        AutoKnowledgeMacro.ActiveQuestFlaggedItems[key] = itemQuestPair.questID
        if not AutoKnowledgeMacro.NameCache[itemQuestPair.itemID] then
          AutoKnowledgeMacro.NameCache[itemQuestPair.itemID] = { name = key, nameFound = false }
          AutoKnowledgeMacro:GetItemNameByID(itemQuestPair.itemID)
        end
      end
    end
  end
end

function AutoKnowledgeMacro:ReloadAllMinimumQuantityItems()
  AutoKnowledgeMacro.MinimumQuantityItems = {}
  for professionEnum, expansionList in pairs(AutoKnowledgeMacro.finishingReagents) do
    for _, reagentPair in ipairs(expansionList) do
      local key = tostring(reagentPair.itemID)
      AutoKnowledgeMacro.MinimumQuantityItems[key] = reagentPair.qty

      -- still need to know the names for the Settings 
      if not AutoKnowledgeMacro.NameCache[reagentPair.itemID] then
        AutoKnowledgeMacro.NameCache[reagentPair.itemID] = { name = key, nameFound = false }
        AutoKnowledgeMacro:GetItemNameByID(reagentPair.itemID)
      end
    end
    end
  end

--################################################################################--
-- (Almost) everything the addon needs to do, excludes static data
--################################################################################--
local function ReloadAll()
  -- make sure we have a macro to update
  GetMacroSlot()

  AutoKnowledgeMacro:ReloadAllProfessionItems()
  AutoKnowledgeMacro:ReloadAllQuestFlaggedItems()
  AutoKnowledgeMacro:ReloadAllMinimumQuantityItems()

  UpdateProfessions()
  AutoKnowledgeMacro:Update()

  -- Weekly resets for Treatises
  local seconds = C_DateAndTime.GetSecondsUntilWeeklyReset()
  C_Timer.After(seconds, function()
    ReloadAll()
  end)
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

  AutoKnowledgeMacro:LoadMidnightData()
  AutoKnowledgeMacro:LoadTheWarWithinData()
  AutoKnowledgeMacro:CheckOrCreateSettings()

  ReloadAll()

  AutoKnowledgeMacro:InitializeSettings()
end

function f:BAG_CONTAINER_UPDATE(event, ...)
  apkPrint("WARN", event, ...)
  AutoKnowledgeMacro:Update()
end

function f:BAG_NEW_ITEMS_UPDATED(event, ...)
  apkPrint("WARN", event, ...)
  AutoKnowledgeMacro:Update()
end

function f:BAG_UPDATE_DELAYED(event, ...)
  apkPrint("WARN", event, ...)
  AutoKnowledgeMacro:Update()
end

function f:PLAYER_LEAVE_COMBAT(event, ...)
  apkPrint("WARN", event, ...)
  AutoKnowledgeMacro:Update()
end

function f:SKILL_LINE_SPECS_UNLOCKED(event, ...)
  apkPrint("WARN", event, ...)
  UpdateProfessions()
  AutoKnowledgeMacro:Update()
end

function f:SKILL_LINE_SPECS_RANKS_CHANGED(event, ...)
  apkPrint("WARN", event, ...)
  UpdateProfessions()
  AutoKnowledgeMacro:Update()
end

function f:GET_ITEM_INFO_RECEIVED(event, itemID, success)
  if success and AutoKnowledgeMacro.NameCache[itemID] and not AutoKnowledgeMacro.NameCache[itemID][KEY_NAMEFOUND] then
    local name = AutoKnowledgeMacro:GetItemNameByID(itemID)
      apkPrint("WARN", event .. " itemID: " .. tostring(itemID) .. " " .. name .. " success: " .. tostring(success))
      C_Timer.After(0.1, function()
      AutoKnowledgeMacro:Update()
      end)

    if AutoKnowledgeMacro:IsFinishingReagent(itemID) then
      AutoKnowledgeMacro:InitializeSettings()
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

function AutoKnowledgeMacro:ToggleDebug()
  AutoKnowledgeMacro:SetDebug(not AutoKnowledgeMacro_SavedVars.debug)
end

function AutoKnowledgeMacro:SetDebug(newValue)
  AutoKnowledgeMacro_SavedVars.debug = newValue
  apkPrint("OK", "AKM: Debug ".. (AutoKnowledgeMacro_SavedVars.debug and "on" or "off"))
  print("AutoKnowledgeMacro: Debug ".. (AutoKnowledgeMacro_SavedVars.debug and "on" or "off"))
end

--################################################################################--
-- Slash commands
--################################################################################--
SlashCmdList["AUTOKNOWLEDGEMACRO"] = function(msg, editBox)
  if msg == "update" then
    apkPrint("OK", "AKM: Forcing update...")
    AutoKnowledgeMacro:Update()
    apkPrint("OK", "AKM: Complete")
    print("AutoKnowledgeMacro: Update complete")
  elseif msg == "debug" then
    AutoKnowledgeMacro:ToggleDebug()
  elseif msg == "pickup" then
    apkPrint("OK", "AKM: Picking up macro")
    PickupMacro(MACRO_NAME)
  elseif msg == "reload" then
    apkPrint("OK", "AKM: Updating professions")
    ReloadAll()
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
