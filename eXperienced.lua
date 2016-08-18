-- =============================================================================
--
--       Filename:  eXperienced.lua
--
--    Description:  A simple experience bar.
--
--        Version:  7.0.1
--
--         Author:  Mathias Jost (mail@mathiasjost.com)
--
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Return rested XP percentage
-- -----------------------------------------------------------------------------
local function XPRestedPercent()
	return GetXPExhaustion("player") * 100 / UnitXPMax("player")
end


-- -----------------------------------------------------------------------------
-- Return current XP percentage
-- -----------------------------------------------------------------------------
local function XPCurrentPercent()
	return UnitXP("player") * 100 / UnitXPMax("player")
end


-- -----------------------------------------------------------------------------
-- create the addon frame
-- -----------------------------------------------------------------------------
local eXperienced = CreateFrame("Frame", "eXperienced", UIParent)

eXperienced:SetFrameStrata("BACKGROUND")
eXperienced:SetWidth(GetScreenWidth())
eXperienced:SetHeight(2)
eXperienced:SetPoint("TOP")
eXperienced:Show()


-- -----------------------------------------------------------------------------
-- Variables
-- -----------------------------------------------------------------------------
local XPCurrent
local XPMax
local XPRested
local XPRestedBarWidth
local XPCurrentBarWidth


-- -----------------------------------------------------------------------------
-- Regiester events
-- -----------------------------------------------------------------------------
eXperienced:RegisterEvent("PLAYER_XP_UPDATE")
eXperienced:RegisterEvent("PLAYER_LOGIN")


-- -----------------------------------------------------------------------------
-- Event handler
-- -----------------------------------------------------------------------------
eXperienced:SetScript("OnEvent", function(self, event, ...)

	-- get the rested xp percentage
	if XPRestedPercent() + XPCurrentPercent() >= 100 then
		XPRestedBarFill = 100
	else
		XPRestedBarFill = XPRestedPercent() + XPCurrentPercent()
	end


	-- Get xp values
	XPCurrent = UnitXP("player")
	XPMax = UnitXPMax("player")
	XPRested = GetXPExhaustion("player")

	-- set the text display to the current values
	ExperienceText:SetText(string.format("%d/%d (%.1f%%) R: %.1f%%", XPCurrent, XPMax, XPCurrentPercent(), XPRestedPercent()))

	-- set the value of the rested xp bar
	eXperiencedRested:SetValue(XPRestedBarFill)

	-- set the value of the current xp bar
	eXperiencedCurrent:SetValue(XPCurrentPercent())

end)


-- -----------------------------------------------------------------------------
-- create the experience text display
-- -----------------------------------------------------------------------------
ExperienceText = eXperienced:CreateFontString(nil, "OVERLAY")
ExperienceText:SetPoint("CENTER", 0, -10)
ExperienceText:SetFont("Interface\\AddOns\\eStats\\font.ttf", 14)
ExperienceText:SetTextColor(1, 1, 1)
ExperienceText:Hide()


-- -----------------------------------------------------------------------------
-- create the rested xp bar display
-- -----------------------------------------------------------------------------
local eXperiencedRested = CreateFrame("StatusBar", "eXperiencedRested", eXperienced)

eXperiencedRested:SetWidth(GetScreenWidth())
eXperiencedRested:SetHeight(2)  
eXperiencedRested:SetMinMaxValues(0, 100)
eXperiencedRested:SetFrameStrata("MEDIUM")
eXperiencedRested:SetStatusBarTexture("Interface\\AddOns\\eXperienced\\Smudge.tga")
eXperiencedRested:SetStatusBarColor(0.1, 0.1, 0.1, 0.5)
eXperiencedRested:SetPoint("TOPLEFT")
eXperiencedRested:Show()


-- -----------------------------------------------------------------------------
-- create the current xp bar display
-- -----------------------------------------------------------------------------
local eXperiencedCurrent = CreateFrame("StatusBar", "eXperiencedCurrent", eXperienced)

eXperiencedCurrent:SetWidth(GetScreenWidth())
eXperiencedCurrent:SetHeight(2)  
eXperiencedCurrent:SetMinMaxValues(0, 100)
eXperiencedCurrent:SetFrameStrata("HIGH")
eXperiencedCurrent:SetStatusBarTexture("Interface\\AddOns\\eXperienced\\Smudge.tga")
eXperiencedCurrent:SetStatusBarColor(1.0, 1.0, 1.0, 1.0)
eXperiencedCurrent:SetPoint("TOPLEFT")
eXperiencedCurrent:Show()


-- -----------------------------------------------------------------------------
-- Show the experience text
-- -----------------------------------------------------------------------------
eXperienced:SetScript("OnEnter", function(self, motion)

	ExperienceText:Show()

end)


-- -----------------------------------------------------------------------------
-- Hide the experience text
-- -----------------------------------------------------------------------------
eXperienced:SetScript("OnLeave", function(self, motion)

	ExperienceText:Hide()

end)