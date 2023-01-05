local addonName, addon = ...
local _G = _G

-- generic event handler
function handleEvent(channel, message, player, channelType)
    if message == "!keys" then
        StaticPopup_Show("SHARE_KEY_TO_OTHERS", player, channelType)
    end
end

-- party message listener
local PartyEventFrame =  CreateFrame("Frame", "FrameEvent")
PartyEventFrame:RegisterEvent("CHAT_MSG_PARTY")

PartyEventFrame:SetScript("OnEvent",
    function(self, channel, message, player)
        handleEvent(channel, message, player, "party")
    end
)

-- guild message listener
local GuildEventFrame =  CreateFrame("Frame", "FrameEvent")
GuildEventFrame:RegisterEvent("CHAT_MSG_GUILD")

GuildEventFrame:SetScript("OnEvent",
    function(self, channel, message, player)
        handleEvent(channel, message, player, "guild")
    end
)

-- raid message listener
local RaidEventFrame =  CreateFrame("Frame", "FrameEvent")
RaidEventFrame:RegisterEvent("CHAT_MSG_RAID")

RaidEventFrame:SetScript("OnEvent",
    function(self, channel, message, player)
        handleEvent(channel, message, player, "raid")
    end
)

--whisper message listener
local WhisperEventFrame =  CreateFrame("Frame", "FrameEvent")
WhisperEventFrame:RegisterEvent("CHAT_MSG_WHISPER")

WhisperEventFrame:SetScript("OnEvent",
    function(self, channel, message, player)
        handleEvent(channel, message, player, "whisper")
    end
)