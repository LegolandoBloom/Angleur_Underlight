Legolando_CollapseConfigMixin_AngleurUnderlight = {}


function Legolando_CollapseConfigMixin_AngleurUnderlight:Init(tabNames)
    if tabNames and next(tabNames) ~= nil then
        local tabs = self.popup.tabs
        for i, name in ipairs(tabNames) do
            tabs:AddTab(name)
        end
        local function tabSelectedCallback(tabID)
            local children = {self.popup:GetChildren()}
            for i, v in pairs(children) do
                local id = v:GetID()
                if id and id ~= 0 then
                    if id == tabID then
                        v:Show()
                    else
                        v:Hide()
                    end
                end
            end
            -- if tabID == 1 then
            --     print("this is tab 1")
            -- elseif tabID == 2 then
            --     print("this is tab 2")
            -- elseif tabID == 3 then
            --     print("this is tab 3")
            -- end
        end
        tabs:SetTabSelectedCallback(tabSelectedCallback)
        tabs:SetTab(1)
    end
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
