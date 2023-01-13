local addonName, addon = ...
local _G = _G

-- Channel functions
function addon:isChannelWhitelisted(channelName)
    return _G[addonName]["WhitelistedChannels"][channelName] or false
end

-- Player functions
function addon:isPlayerWhitelisted(playerName)
    return _G[addonName]["WhitelistedPlayers"][playerName] or false
end

function addon:isPartyWhitelisted()
    for player=1, GetNumGroupMembers() do
        local playerFullName = UnitFullName("party" .. player)
        if playerFullName and not addon:isPlayerWhitelisted(playerFullName) then
            return false
        end
    end

    return true
end

-- Register multiple event for one frame
addon.RegisterEvents =
function (self, ...)
	for key,value in pairs({...}) do
		self:RegisterEvent(value)
	end
end

-- Menu functions
addon.populatePlayersDropDown = 
function(frame, level, menuList)
    for key, value in pairs(_G[addonName]["WhitelistedPlayers"]) do
        local info = UIDropDownMenu_CreateInfo()
        info.text, info.checked = key, value
        info.func =
            function(self)
                _G[addonName]["WhitelistedPlayers"][self.value] = 
                    not _G[addonName]["WhitelistedPlayers"][self.value]
            end

        UIDropDownMenu_AddButton(info)
    end
end

addon.populateDropDownChannels = 
function(frame, level, menuList)
    for key, value in pairs(_G[addonName]["WhitelistedChannels"]) do
        local info = UIDropDownMenu_CreateInfo()
        info.text, info.checked = key, value
        info.func =
            function(self)
                _G[addonName]["WhitelistedChannels"][self.value] = 
                    not _G[addonName]["WhitelistedChannels"][self.value]
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

            local channel = self.text.text_arg2
            local respondPlayer = ((channel == "whisper" and self.text.text_arg1) or nil)
            addon:sendKeyToChannel(channel, respondPlayer)
        end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3
}

function addon:extractChannel(channelType)
    return _G[addonName]["ChannelTypeMapping"][channelType]
end

function addon:sendKeyToChannel(channelType, respondPlayer)
    local key = addon:getPlayerKeystone()
    SendChatMessage("PrivacyKeys : " .. key,
                    channelType,
                    nil,
                    respondPlayer)
end