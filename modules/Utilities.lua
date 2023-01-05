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
    for bag=0, NUM_BAG_SLOTS do
        for item=1, GetContainerNumSlots(bag) do
            local itemLink = GetItemLink(bag, slot)
            if String.contains(itemLink, "Keystone: ") then
                return itemLink
            end
        end
    end
    return "I don't have a key"
end