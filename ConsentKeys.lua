local addonName, addon = ...
local _G = _G

-- party messages
local PartyEventFrame =  CreateFrame("Frame", "FrameEvent")
PartyEventFrame:RegisterEvent("CHAT_MSG_PARTY")

PartyEventFrame:SetScript("OnEvent",
    function(self, channel, message, player)
        if message == "!keys" then
            
        end
    end
)

-- guild messages
local GuildEventFrame =  CreateFrame("Frame", "FrameEvent")
GuildEventFrame:RegisterEvent("CHAT_MSG_GUILD")

GuildEventFrame:SetScript("OnEvent",
    function(self, channel, message, player)
        
    end
)

-- raid messages
local RaidEventFrame =  CreateFrame("Frame", "FrameEvent")
RaidEventFrame:RegisterEvent("CHAT_MSG_RAID")

RaidEventFrame:SetScript("OnEvent",
    function(self, channel, message, player)
        
    end
)

--whisper messages
local WhisperEventFrame =  CreateFrame("Frame", "FrameEvent")
WhisperEventFrame:RegisterEvent("CHAT_MSG_WHISPER")

WhisperEventFrame:SetScript("OnEvent",
    function(self, channel, message, player)
        
    end
)

-- handle events here
function getPlayerResponse(player, channel)
    local frame = CreateFrame("Frame", "Frame")
    frame:SetPoint("CENTER")
    frame:SetSize(100, 100)
    frame:AddLine(player .. " has requested you to share your key in " .. channel)

    local yesButton = CreateFrame()
    local noButton = CreateFrame()
    
    
end