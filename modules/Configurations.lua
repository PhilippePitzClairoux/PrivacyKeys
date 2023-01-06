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
-- player whitelist
if not _G["ConsentKeys"]["WhitelistedPlayers"] then
    _G["ConsentKeys"]["WhitelistedPlayers"] = {}
end

if not _G["ConsentKeys"]["WhitelistPlayers"] then
    _G["ConsentKeys"]["WhitelistPlayers"] = false
end

-- channel whitelist (ex: guild, raid, party)
if not _G["ConsentKeys"]["WhitelistedChannels"] then
    _G["ConsentKeys"]["WhitelistedChannels"] = {
        party=false,
        raid=false,
        guild=false
    }
end

if not _G["ConsentKeys"]["WhitelistChannels"] then
    _G["ConsentKeys"]["WhitelistChannels"] = false
end
