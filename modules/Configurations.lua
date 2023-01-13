-- Initialize global variables
PrivacyKeysAddonName = PrivacyKeysAddonName or "PrivacyKeys"
PrivacyKeys = PrivacyKeys or {}

-- import variables locally
local addonName, addon = PrivacyKeysAddonName, PrivacyKeys
local _G = _G


-- Create table to save global values that should be stored
if not _G[addonName] then
    _G[addonName] = {}
end

-- Populate table with important values to store (if they don't exist)
-- player whitelist
if not _G[addonName]["WhitelistedPlayers"] then
    _G[addonName]["WhitelistedPlayers"] = {}
end

if not _G[addonName]["WhitelistPlayers"] then
    _G[addonName]["WhitelistPlayers"] = false
end

-- channel whitelist (ex: guild, raid, party)
if not _G[addonName]["WhitelistedChannels"] then
    _G[addonName]["WhitelistedChannels"] = {
        party=false,
        raid=false,
        guild=false
    }
end

if not _G[addonName]["WhitelistChannels"] then
    _G[addonName]["WhitelistChannels"] = false
end

if not _G[addonName]["ChannelTypeMapping"] then
    _G[addonName]["ChannelTypeMapping"] = {
        CHAT_MSG_PARTY="party",
        CHAT_MSG_PARTY_LEADER="party",
        CHAT_MSG_GUILD="guild",
        CHAT_MSG_RAID="raid",
        CHAT_MSG_RAID_LEADER="raid",
        CHAT_MSG_WHISPER="whisper"
    }
end