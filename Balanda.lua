---------------------------------------------------------------------------------------------------------
--Всеееееем привет дорогие друзья, с вами снова я, Кейн, и это уже 255 часть наших обзоров модов!
---------------------------------------------------------------------------------------------------------

local mod_path = SMODS.current_mod.path
local lib = NFS.getDirectoryItems(mod_path .. "lib")
local content = NFS.getDirectoryItems(mod_path .. "content")
local keychains = NFS.getDirectoryItems(mod_path .. "keychains")
local taskboard = NFS.getDirectoryItems(mod_path .. "taskboard")
local files = {
    lib = lib,
    content = content,
    keychains = keychains,
    taskboard = taskboard,
}
for k, v in pairs(files) do
    for _, f in ipairs(v) do
        sendDebugMessage(k .. "/" .. f)
        SMODS.load_file(k .. "/" .. f)()
    end
end
