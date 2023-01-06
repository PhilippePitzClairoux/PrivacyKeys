local addonName, addon = ...
local _G = _G

-- Channel functions
function addon:isChannelWhitelisted(channelName)
    return _G["ConsentKeys"]["WhitelistedChannels"][channelName] or false
end

-- Player functions
function addon:isPlayerWhitelisted(playerName)
    return _G["ConsentKeys"]["WhitelistedPlayers"][playerName] or false
end

function addon:isPartyWhitelisted()
    for player=0, GetNumGroupMembers() - 1 do
        local playerFullName = UnitFullName("party" .. player)
        if playerFullName and not isPlayerWhitelisted(playerFullName) then
            return false
        end
    end

    return true
end

-- Menu functions
addon.populatePlayersDropDown = 
function(frame, level, menuList)
    for key, value in pairs(_G["ConsentKeys"]["WhitelistedPlayers"]) do
        local info = UIDropDownMenu_CreateInfo()
        info.text, info.checked = key, value
        info.func =
            function(self)
                _G["ConsentKeys"]["WhitelistedPlayers"][self.value] = 
                    not _G["ConsentKeys"]["WhitelistedPlayers"][self.value]
            end

        UIDropDownMenu_AddButton(info)
    end
end

addon.populateDropDownChannels = 
function(frame, level, menuList)
    for key, value in pairs(_G["ConsentKeys"]["WhitelistedChannels"]) do
        local info = UIDropDownMenu_CreateInfo()
        info.text, info.checked = key, value
        info.func =
            function(self)
                _G["ConsentKeys"]["WhitelistedChannels"][self.value] = 
                    not _G["ConsentKeys"]["WhitelistedChannels"][self.value]
            end
        UIDropDownMenu_AddButton(info)
    end
end

-- find keystone
function addon:getPlayerKeystone()
    local bag, item, currentItemLink
    for bag=0,4 do
        for item=1,C_Container.GetContainerNumSlots(bag) do
            currentItemLink = C_Container.GetContainerItemLink(bag, item)
            if currentItemLink and string.find(currentItemLink, "Keystone: ") then
                return currentItemLink
            end
        end
    end
    return "Unable to find key."
end

-- popup 
StaticPopupDialogs["SHARE_KEY_TO_OTHERS"] = {
    text = "%s wants you to share your key in %s.\nDo you agree?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = 
        function(self)
            local key = addon:getPlayerKeystone()
            local channel = (self.text.text_arg2 == "whisper" and "WHISPER" or "CHANNEL")
            local respondPlayer = (channel == "WHISPER" and self.text.text_arg1 or nil)

            SendChatMessage("ConsentKey : " .. key,
                            string.upper(self.text.text_arg2),
                            nil,
                            respondPlayer
            )
        end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3
}
