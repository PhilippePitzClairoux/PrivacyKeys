local addonName, addon = ...
local _G = _G

-- setup menu frame
local frame = CreateFrame("Frame", nil)
frame.name = addonName


-- populate frame
frame:SetScript("OnShow",
    function(frame)
        local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 16, -16)
        title:SetText(addonName)

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
                _G[addonName]["WhitelistPlayers"] = PlayerWhitelisting:GetChecked()
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
                _G[addonName]["WhitelistChannels"] = PlayerWhitelisting:GetChecked()
            end
        )

        -- list of players/channels
    end
)

InterfaceOptions_AddCategory(frame)