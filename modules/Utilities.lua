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
