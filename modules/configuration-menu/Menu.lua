local addonName, addon = ...
local _G = _G

-- setup menu frame
local frame = CreateFrame("Frame", nil)
frame.name = addonName

function setDefaultText(frame)
    frame:SetText("Player-Server (ex: Philouxo-Area52)")
end

function hideFrames(...)
    for key,value in pairs({...}) do
        value:Hide()
    end
end

function showFrames(...)
    for key,value in pairs({...}) do
        value:Show()
    end
end

-- populate frame
frame:SetScript("OnShow",
    function(frame)
        local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 16, -16)
        title:SetText(addonName)

        -- list of players/channels
        PlayerWhitelistingDropdown = CreateFrame("Frame",
                                                              "WhitelistDropDown",
                                                              frame,
                                                              "UIDropDownMenuTemplate")
        PlayerWhitelistingDropdown:SetPoint("BOTTOMLEFT")
        UIDropDownMenu_SetWidth(PlayerWhitelistingDropdown, 200)
        UIDropDownMenu_SetText(PlayerWhitelistingDropdown, "Whitelisted players")
        UIDropDownMenu_Initialize(PlayerWhitelistingDropdown, addon.populatePlayersDropDown)

        ChannelWhitelistingDropdown = CreateFrame("Frame",
                                "WhitelistDropDown",
                                frame,
                                "UIDropDownMenuTemplate")
        ChannelWhitelistingDropdown:SetPoint("BOTTOMRIGHT")
        UIDropDownMenu_SetWidth(ChannelWhitelistingDropdown, 200)
        UIDropDownMenu_SetText(ChannelWhitelistingDropdown, "Whitelisted channels")
        UIDropDownMenu_Initialize(ChannelWhitelistingDropdown, addon.populateDropDownChannels)

        -- add/remove players
        AddWhitelistPlayerEditBox = CreateFrame("EditBox",
                                         "EditBoxFrame",
                                         frame,
                                         "InputBoxTemplate")
        AddWhitelistPlayerEditBox:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 16, -65)
        AddWhitelistPlayerEditBox:SetSize(200, 300)
        AddWhitelistPlayerEditBox:SetAutoFocus(false)
        setDefaultText(AddWhitelistPlayerEditBox)

        AddWhitelistPlayerEditBox:SetScript("OnEditFocusGained", function(self)
            AddWhitelistPlayerEditBox:SetText("")
        end)

        AddButton = CreateFrame("Button",
                                       "AddPlayerButton",
                                       frame,
                                       "UIPanelButtonTemplate")
        AddButton:SetSize(80 ,22)
        AddButton:SetText("Add player")
        AddButton:SetPoint("CENTER", AddWhitelistPlayerEditBox, "CENTER", 200, 0)
        
        AddButton:SetScript("OnClick", function(self)
            local user = AddWhitelistPlayerEditBox:GetText()

            if (not _G[addonName]["WhitelistedPlayers"][user]) then
                _G[addonName]["WhitelistedPlayers"][user] = true
                UIDropDownMenu_Initialize(PlayerWhitelistingDropdown, addon.populatePlayersDropDown)
            end
            AddWhitelistPlayerEditBox:SetText("")
        end)


        RemoveButton = CreateFrame("Button",
                                          "RemovePlayerButton",
                                          frame,
                                          "UIPanelButtonTemplate")
        RemoveButton:SetSize(80 ,22)
        RemoveButton:SetText("Remove player")
        RemoveButton:SetPoint("CENTER", AddWhitelistPlayerEditBox, "CENTER", 300, 0)

        RemoveButton:SetScript("OnClick", function(self)
            local user = AddWhitelistPlayerEditBox:GetText()

            if (_G[addonName]["WhitelistedPlayers"][user]) then
                _G[addonName]["WhitelistedPlayers"][user] = nil
                UIDropDownMenu_Initialize(PlayerWhitelistingDropdown, addon.populatePlayersDropDown)
            end
            setDefaultText(AddWhitelistPlayerEditBox)
        end)

        -- checkboxes enable/disable
        local player_whitelisting = CreateFrame("CheckButton",
                                                "PlayerWhitelisting",
                                                frame,
                                                    "ChatConfigCheckButtonTemplate")
        player_whitelisting:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 16, -16)
        PlayerWhitelistingText:SetText("Toggle player whitelisting")
        player_whitelisting.tooltip = "Enable/Disable whitelisting of players"
        player_whitelisting:SetChecked(_G[addonName]["WhitelistPlayers"])
        player_whitelisting:SetScript("OnClick", 
            function(self)
                local isChecked = self:GetChecked()
                _G[addonName]["WhitelistPlayers"] = PlayerWhitelisting:GetChecked()
                
                if isChecked then
                    showFrames(AddButton, RemoveButton, AddWhitelistPlayerEditBox, PlayerWhitelistingDropdown)
                else
                    hideFrames(AddButton, RemoveButton, AddWhitelistPlayerEditBox, PlayerWhitelistingDropdown)
                end
            end
        )

        local channel_whitelisting = CreateFrame("CheckButton",
                                                 "ChannelWhitelisting",
                                                 frame,
                                                 "ChatConfigCheckButtonTemplate")
        channel_whitelisting:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 16, -48)
        channel_whitelisting.tooltip = "Enable/Disable whitelisting of players"
        ChannelWhitelistingText:SetText("Toggle channel whitelisting")
        channel_whitelisting:SetChecked(_G[addonName]["WhitelistChannels"])
        channel_whitelisting:SetScript("OnClick", 
            function(self)
                local isChecked = self:GetChecked()
                _G[addonName]["WhitelistChannels"] = isChecked

                if isChecked then
                    showFrames(ChannelWhitelistingDropdown)
                else
                    hideFrames(ChannelWhitelistingDropdown)
                end

            end
        )

    end
)

InterfaceOptions_AddCategory(frame)