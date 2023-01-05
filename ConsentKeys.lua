local addonName, addon = ...
local _G = _G

-- party messages
local PartyEventFrame =  CreateFrame("Frame", "FrameEvent")
PartyEventFrame:RegisterEvent("CHAT_MSG_PARTY")

PartyEventFrame:SetScript("OnEvent",
    function(self, channel, message, player)
        handleEvent(channel, message, player, "party")
    end
)

-- guild messages
local GuildEventFrame =  CreateFrame("Frame", "FrameEvent")
GuildEventFrame:RegisterEvent("CHAT_MSG_GUILD")

GuildEventFrame:SetScript("OnEvent",
    function(self, channel, message, player)
        handleEvent(channel, message, player, "guild")
    end
)

-- raid messages
local RaidEventFrame =  CreateFrame("Frame", "FrameEvent")
RaidEventFrame:RegisterEvent("CHAT_MSG_RAID")

RaidEventFrame:SetScript("OnEvent",
    function(self, channel, message, player)
        handleEvent(channel, message, player, "raid")
    end
)

--whisper messages
local WhisperEventFrame =  CreateFrame("Frame", "FrameEvent")
WhisperEventFrame:RegisterEvent("CHAT_MSG_WHISPER")

WhisperEventFrame:SetScript("OnEvent",
    function(self, channel, message, player)
        handleEvent(channel, message, player, "whisper")
    end
)

-- handle events here
function handleEvent(channel, message, player, type)
    if message == "!keys" then
        StaticPopup_Show("SHARE_KEY_TO_OTHERS", player, "party")
    end
end