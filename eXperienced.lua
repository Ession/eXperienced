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
eXperienced:SetHeight(1)
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

	-- Get xp values
	XPCurrent = UnitXP("player")
	XPMax = UnitXPMax("player")
	XPRested = GetXPExhaustion("player")

	-- set the text display to the current values
	ExperienceText:SetText(string.format("%d/%d (%.1f%%) R: %.1f%%", XPCurrent, XPMax, XPCurrentPercent(), XPRestedPercent()))

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
if XPRestedPercent() + XPCurrentPercent() >= 100 then
	XPRestedBarWidth = GetScreenWidth()
else
	XPRestedBarWidth = (XPRestedPercent() + XPCurrentPercent()) * GetScreenWidth() / 100
end

local eXperiencedRested = CreateFrame("Frame", "eXperiencedRested", eXperienced)

eXperiencedRested:SetFrameStrata("BACKGROUND")
eXperiencedRested:SetWidth(XPRestedBarWidth)
eXperiencedRested:SetHeight(1)  
eXperiencedRested:SetAlpha(1.0)
eXperiencedRested:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background"})
eXperiencedRested:SetBackdropColor(1,1,1,1)

eXperiencedRested:SetPoint("TOPLEFT")
eXperiencedRested:Show()


-- -----------------------------------------------------------------------------
-- create the current xp bar display
-- -----------------------------------------------------------------------------
XPCurrentBarWidth = XPCurrentPercent() * GetScreenWidth() / 100

local eXperiencedCurrent = CreateFrame("Frame", "eXperiencedCurrent", eXperienced)

eXperiencedCurrent:SetFrameStrata("BACKGROUND")
eXperiencedCurrent:SetWidth(XPCurrentBarWidth)
eXperiencedCurrent:SetHeight(1)  
eXperiencedCurrent:SetAlpha(1.0)
eXperiencedCurrent:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background"})
eXperiencedCurrent:SetBackdropColor(0,0,1,1)

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