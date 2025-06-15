AngleurUnderlight_CheckboxMixin = {};

function AngleurUnderlight_CheckboxMixin:greyOut()
    self:SetChecked(false)
    self:Disable()
    self.text:SetTextColor(0.9, 0.9, 0.9)
    self.disabledText:Show()
    if self.dropDown then
        self.dropDown:Hide()
    end
end

function AngleurUnderlight_CheckboxMixin:reposition()
    local width, height = self.text:GetSize()
    self.text:ClearAllPoints()
    self.text:SetPoint("RIGHT", self, "LEFT")
    self.disabledText:SetPoint("LEFT", self, "RIGHT")
    local _, _, _, offsetX, offsetY = self:GetPoint()
    self:AdjustPointsOffset(width, 0)
end

function AngleurUnderlight_CheckboxMixin:OnClick()
    local grandParent = self:GetParent():GetParent()
    local teeburu = grandParent.savedVarTable
    if not self.reference then 
        print("no checkbox reference string")
        return
    end
    if not teeburu then 
        print("no saved variable table attached")
        return 
    end
    if teeburu[self.reference] == nil then
        print("checkbox reference not found in saved variable table")
        return
    end
    if self:GetChecked() then
        teeburu[self.reference] = true
    elseif self:GetChecked() == false then
        teeburu[self.reference] = false
    end
end

AngleurUnderlight_CollapseConfigMixin = {}

function AngleurUnderlight_CollapseConfigMixin:Init()

end

function AngleurUnderlight_CollapseConfigMixin:Update()
    local teeburu = self.savedVarTable
    if not teeburu then
        print("checkbox parent doesn't have a saved variable table attached")
        return
    end
    local children = {self.popup:GetChildren()}
    for i, child in pairs(children) do
        if child:GetObjectType() == "CheckButton" and child.reference then
            local savedVar = teeburu[child.reference]
            if savedVar then
                if savedVar == true then
                    child:SetChecked(true)
                elseif savedVar == false then
                    child:SetChecked(false)
                end
            end
        end
    end
end

AngleurUnderlight_TutorialTooltipMixin = {}

function AngleurUnderlight_TutorialTooltipMixin:OnShow()
    self:SetPadding(self.paddingL, self.paddingB, self.paddingR, self.paddingT)
end

function AngleurUnderlight_TutorialTooltipMixin:PlaceTexture(texturePath, width, height, anchor, padOffsetX, padOffsetY)
    if not texturePath then return end
    self.texture:ClearAllPoints()
    self.texture:SetTexture(texturePath)
    self.texture:SetSize(width, height)
    self.texture:SetPoint(anchor, self, anchor)
    self:ResetPadding()
    if anchor == "TOPLEFT" then
        self.paddingL = width + padOffsetX
        self.paddingT = height + padOffsetY
    elseif anchor == "TOPRIGHT" then
        self.paddingR = width + padOffsetX
        self.paddingT = height + padOffsetY
    elseif anchor == "BOTTOMLEFT" then
        self.paddingL = width + padOffsetX
        self.paddingB = height + padOffsetY
    elseif anchor == "BOTTOMRIGHT" then
        self.paddingR = width + padOffsetX
        self.paddingB = height + padOffsetY
    end
end

function AngleurUnderlight_TutorialTooltipMixin:ResetPadding()
    self.paddingL = 0
    self.paddingB = 0
    self.paddingR = 0
    self.paddingT = 0
end

function AngleurUnderlight_TutorialTooltipMixin:OnHide()
    self.texture:SetTexture(nil)
    self.texture:ClearAllPoints()
    self:ResetPadding()    
end