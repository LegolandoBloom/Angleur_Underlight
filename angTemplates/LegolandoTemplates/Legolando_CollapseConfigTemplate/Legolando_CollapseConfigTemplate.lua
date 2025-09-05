Legolando_CollapseConfigMixin_AngleurUnderlight = {}

function Legolando_CollapseConfigMixin_AngleurUnderlight:Init()

end

function Legolando_CollapseConfigMixin_AngleurUnderlight:Update()
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