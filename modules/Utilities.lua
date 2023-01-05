local addonName, addon = ...

-- Channel functions
function addon:isChannelWhitelisted(channelName)
    return _G["ConsentKeys"]["WhitelistedChannels"][channelName] or false
end

-- Player functions
function addon:isPlayerWhitelisted(playerName)
    return _G["ConsentKeys"]["WhitelistedPlayers"][playerName] or false
end

function addon:isPartyWhitelisted(...)
    for player in ... do
        if not isPlayerWhitelisted(player) then
            return false
        end
    end

    return true
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
