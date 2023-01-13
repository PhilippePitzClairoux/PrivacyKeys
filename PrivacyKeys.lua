local addonName, addon = ...
local _G = _G

-- generic event handler
function handleEvent(channel, message, player)
    if message == "!keys" then
        local actualChannel = addon:extractChannel(channel)

        if (_G[addonName]["WhitelistPlayers"]) then
            print("Inside player whistelisted if")
            if addon:isPlayerWhitelisted(player) and actualChannel == "whisper" then
                addon:sendKeyToChannel(actualChannel, player)
                return nil
            else 
                if addon:isPartyWhitelisted() then
                    addon:sendKeyToChannel(actualChannel, player)
                    return nil
                end
            end
        end

        print("Is channel whitelisted : " .. tostring(addon:isChannelWhitelisted(actualChannel)))
        print("Channel Whitelisting enabled : " .. tostring(_G[addonName]["WhitelistChannels"] ))
        if (_G[addonName]["WhitelistChannels"] and addon:isChannelWhitelisted(actualChannel)) then
            addon:sendKeyToChannel(actualChannel, player)
            return nil
        end
        
        StaticPopup_Show("SHARE_KEY_TO_OTHERS", player, actualChannel)
    end
end


-- party message listener
local EventFrame =  CreateFrame("Frame")
EventFrame.RegisterEvents = addon.RegisterEvents
EventFrame:RegisterEvents("CHAT_MSG_PARTY",
                          "CHAT_MSG_PARTY_LEADER",
                          "CHAT_MSG_GUILD",
                          "CHAT_MSG_RAID",
                          "CHAT_MSG_RAID_LEADER",
                          "CHAT_MSG_WHISPER")

EventFrame:SetScript("OnEvent",
    function(self, channel, message, player)
        handleEvent(channel, message, player)
    end
)

-- local PartyLeaderEventFrame =  CreateFrame("Frame", "FrameEvent")
-- PartyLeaderEventFrame:RegisterEvent("CHAT_MSG_PARTY_LEADER")

-- PartyLeaderEventFrame:SetScript("OnEvent",
--     function(self, channel, message, player)
--         handleEvent(channel, message, player, "party")
--     end
-- )


-- -- guild message listener
-- local GuildEventFrame =  CreateFrame("Frame", "FrameEvent")
-- GuildEventFrame:RegisterEvent("CHAT_MSG_GUILD")

-- GuildEventFrame:SetScript("OnEvent",
--     function(self, channel, message, player)
--         handleEvent(channel, message, player, "guild")
--     end
-- )

-- -- raid message listener
-- local RaidEventFrame =  CreateFrame("Frame", "FrameEvent")
-- RaidEventFrame:RegisterEvent("CHAT_MSG_RAID")

-- RaidEventFrame:SetScript("OnEvent",
--     function(self, channel, message, player)
--         handleEvent(channel, message, player, "raid")
--     end
-- )

-- local RaidLeaderEventFrame =  CreateFrame("Frame", "FrameEvent")
-- RaidLeaderEventFrame:RegisterEvent("CHAT_MSG_RAID_LEADER")

-- RaidLeaderEventFrame:SetScript("OnEvent",
--     function(self, channel, message, player)
--         handleEvent(channel, message, player, "raid")
--     end
-- )


-- --whisper message listener
-- local WhisperEventFrame =  CreateFrame("Frame", "FrameEvent")
-- WhisperEventFrame:RegisterEvent("CHAT_MSG_WHISPER")

-- WhisperEventFrame:SetScript("OnEvent",
--     function(self, channel, message, player)
--         handleEvent(channel, message, player, "whisper")
--     end
-- )