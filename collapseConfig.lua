
function AngleurUnderlight_CollapseConfig_OnLoad(self)
    local colorBlu = CreateColor(0.61, 0.85, 0.92)
    local colorDarkBlu = CreateColor(0.35, 0.45, 0.92)
    local colorGrae = CreateColor(0.85, 0.85, 0.85)
    local colorYello = CreateColor(1.0, 0.82, 0.0)
    local colorUnderlight = CreateColor(0.9, 0.8, 0.5)

    self.icon:SetTexture("Interface/BUTTONS/UI-OptionsButton")
    self.popup.title:SetText(colorUnderlight:WrapTextInColorCode("Angleur_Underlight Config"))

    self.popup.checkbox1.text:SetText("Delve Mode")
    self.popup.checkbox1.text.tooltip = "Keeps the fish form active while submerged inside " .. colorDarkBlu:WrapTextInColorCode("Underwater Delves,") 
        .. " allowing for infinite breath.\n\n" .."Won't be able to re-equip " .. "\'Main\' Fishing Rod inside the delve while active."
    self.popup.checkbox1:reposition()
    self.popup.checkbox1.reference = "delveMode"
    
    self.popup.checkbox2.text:SetText("Waterwalking")
    self.popup.checkbox2.text.tooltip = "While " .. colorBlu:WrapTextInColorCode("Angleur ") .. "is " .. colorGrae:WrapTextInColorCode("Sleeping")
    .. ", won't re-equip \'Main\' Fishing Rod " .. "when you stop swimming - allowing you to waterwalk.\n\nWhen you " 
    .. colorYello:WrapTextInColorCode("wake ") .. colorBlu:WrapTextInColorCode("Angleur ") .. "up, your \'Main\' Fishing Rod will be equipped back."
    self.popup.checkbox2:reposition()
    self.popup.checkbox2.reference = "waterwalking"
    self.popup.checkbox2.disabledText:SetText("Disabled.\n" .. "Needs " .. colorBlu:WrapTextInColorCode("Angleur\n") .. "to function.")
    if not AngleurUnderlight_AngLoaded then
        self.popup.checkbox2:greyOut()
    end
end
