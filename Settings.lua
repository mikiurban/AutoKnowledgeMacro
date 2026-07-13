local MACRO_NAME, AutoKnowledgeMacro = ...

AutoKnowledgeMacro_SavedVars = {
  debug = false,
  treatises = true
}

local function OnSettingChanged(setting, value)
	-- This callback will be invoked whenever a setting is modified.
  AutoKnowledgeMacro:Update()
end

function AutoKnowledgeMacro:InitializeSettings()
  -- Wait until all of the items have names before we start showing them
  for _, expansionList in pairs(AutoKnowledgeMacro.finishingReagents) do
    for _, reagentPair in ipairs(expansionList) do
      if not AutoKnowledgeMacro:NameFound(reagentPair.itemID) then return end
    end
  end

	local defaultFalse = false

  if not AutoKnowledgeMacro.SettingCategoryID then
    AutoKnowledgeMacro.SettingCategoryID = Settings.RegisterVerticalLayoutCategory(MACRO_NAME)
    Settings.RegisterAddOnCategory(AutoKnowledgeMacro.SettingCategoryID)
  end

  local setting = Settings.GetSetting("AKM_Debug")
	if not setting then
    setting = Settings.RegisterAddOnSetting(AutoKnowledgeMacro.SettingCategoryID, "AKM_Debug", "debug", AutoKnowledgeMacro_SavedVars, type(defaultFalse), "Debug Logging", defaultFalse)
    setting:SetValueChangedCallback(OnSettingChanged)
    Settings.CreateCheckbox(AutoKnowledgeMacro.SettingCategoryID, setting, "Show debug messages in the chat window") -- last param is tooltip
  end

  setting = Settings.GetSetting("AKM_Treatises")
	if not setting then
    setting = Settings.RegisterAddOnSetting(AutoKnowledgeMacro.SettingCategoryID, "AKM_Treatises", "treatises", AutoKnowledgeMacro_SavedVars, type(defaultFalse), "Use Treatises", defaultFalse)
    setting:SetValueChangedCallback(OnSettingChanged)
    Settings.CreateCheckbox(AutoKnowledgeMacro.SettingCategoryID, setting, "Use Treatises when available") -- last param is tooltip
  end

  for _, expansionList in pairs(AutoKnowledgeMacro.finishingReagents) do
    for _, reagentPair in ipairs(expansionList) do
      local variableKey = tostring(reagentPair.itemID)
      local variable = "AKM_"..variableKey
      local name = AutoKnowledgeMacro:GetItemNameByID(reagentPair.itemID)
      local description = reagentPair.note

      setting = Settings.GetSetting(variable)
	    if not setting then
        setting = Settings.RegisterAddOnSetting(AutoKnowledgeMacro.SettingCategoryID, variable, variableKey, AutoKnowledgeMacro_SavedVars, type(defaultFalse), name, defaultFalse)
        setting:SetValueChangedCallback(OnSettingChanged)
        Settings.CreateCheckbox(AutoKnowledgeMacro.SettingCategoryID, setting, description)
      end
    end
  end
end

function AutoKnowledgeMacro:CheckOrCreateSettings()

end