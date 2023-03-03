-----------------
-- Author: Zarem
-- Version: Classic/WotLK

local alpha = 1

local function ClassColors(frame, unit)
    local _, class = UnitClass(unit)
    if not class then return end
    local color = RAID_CLASS_COLORS[class]
    frame:SetStatusBarColor(color.r, color.g, color.b)
end

local function ReactionColors(frame, unit)
    local r, g, b
    if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
        r, g, b = 0.5, 0.5, 0.5
    elseif UnitReaction(unit, "player") == 4 then
        r, g, b = 0.8, 0.7, 0.2
    elseif UnitIsFriend(unit, "player") then
        r, g, b = 0, 0.7, 0
    elseif UnitIsEnemy(unit, "player") then
        r, g, b = 0.9, 0, 0
    else
        r, g, b = 1, 1, 1
    end
    frame:SetStatusBarColor(r, g, b)
end

local function ApplyColors(frame, unit)
    if not unit then return end

    if UnitIsPlayer(unit) then 
        ClassColors(frame, unit) 
    else
        ReactionColors(frame, unit)
    end

    frame:SetAlpha(alpha)
end

hooksecurefunc("CompactUnitFrame_UpdateHealthColor", function(self)
    ApplyColors(self.healthBar, self.unit)
end)
