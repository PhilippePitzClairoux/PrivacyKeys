local _G = _G

-- Initialize global variables
AddonName = AddonName or "ConsentKeys"
Addon = Addon or {}

-- Create table to save global values that should be stored
if not _G["ConsentKeys"] then
    _G["ConsentKeys"] = {}
end

-- Populate table with important values to store (if they don't exist)
local consentKeys = _G["ConsentKeys"]

-- player whitelist
if not consentKeys["WhitelistedPlayers"] then
    consentKeys["WhitelistedPlayers"] = {}
end

if not consentKeys["WhitelistPlayers"] then
    consentKeys["WhitelistPlayers"] = false
end

-- channel whitelist (ex: guild, raid, party)
if not consentKeys["WhitelistedChannels"] then
    consentKeys["WhitelistedChannesl"] = {}
end

if not consentKeys["WhitelistChannels"] then
    consentKeys["WhitelistChannesl"] = false
end

-- popup 
StaticPopupDialogs["SHARE_KEY_TO_OTHERS"] = {
    text = "%s wants you to share your key in %s.\nDo you agree?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = 
        function()
            local key = addon:getPlayerKeystone()
            SendChatMessage("ConsentKey : " .. gsub(key,"\124", "\124\124"),
                            "PARTY",
                            nil,
                            "CHANNEL"
            )
        end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3
}
