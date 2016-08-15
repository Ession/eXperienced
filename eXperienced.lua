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
-- create the addon frame
-- -----------------------------------------------------------------------------
local eXperienced = CreateFrame("Frame", "eXperienced", UIParent)

eXperienced:SetFrameStrata("BACKGROUND")
eXperienced:SetWidth(GetScreenWidth())
eXperienced:SetHeight(1)
eXperienced:SetPoint("TOP")
eXperienced:Show()


-- -----------------------------------------------------------------------------
-- Variables
-- -----------------------------------------------------------------------------
local XPCurrent
local XPMax
local XPRested


-- -----------------------------------------------------------------------------
-- Regiester events
-- -----------------------------------------------------------------------------
eXperienced:RegisterEvent("PLAYER_XP_UPDATE")
eXperienced:RegisterEvent("PLAYER_LOGIN")


-- -----------------------------------------------------------------------------
-- Event handler
-- -----------------------------------------------------------------------------
eXperienced:SetScript("OnEvent", function(self, event, ...)

	-- Get xp values
	XPCurrent = UnitXP("player")
	XPMax = UnitXPMax("player")
	XPRested = GetXPExhaustion("player")
	XPCurrentPercent = XPCurrent * 100 / XPMax
	XPRestedPercent = XPRested * 100 / XPMax

	-- set the text display to the current values
	ExperienceText:SetText(string.format("%d/%d (%.1f%%) R: %.1f%%", XPCurrent, XPMax, XPCurrentPercent, XPRestedPercent))

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