-- Initialize global variables
ConsentKeyAddonName = ConsentKeyAddonName or "ConsentKeys"
ConsentKey = ConsentKey or {}

-- import variables locally
local addonName, addon = ConsentKeyAddonName, ConsentKey
local _G = _G


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
    consentKeys["WhitelistChannels"] = false
end