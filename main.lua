local global_consts = {}

-- Bomb info. Accessible by all modules, managed by the bomb info module
BombInfo = {
    serial = "3X4MP1E"
}

-- A little black magic to prevent people from setting global variables accidentally.
setmetatable(_G,{ __index = global_consts, __newindex = function(_, k, _) error(("Accidental global variable %s detected! Please use the \"local\" keyword to avoid cluttering the global namespace!\n\nIf you intended to create a global variable, please contact Scott."):format(k), 2) end })

-- Local variables
local DEFAULT_SCENE = "framework"
local current_scene = {}

local queued_scene_change

-- Important global functions
function global_consts.ChangeScene(scene_name)
    local err
    queued_scene_change, err = love.filesystem.load("scene/"..scene_name..'.lua')
    if err then error(err, 2) end
end

-- Overwrite update function to perform scene changes
function love.update(dt)
    if queued_scene_change then
        if current_scene.quit then current_scene.quit() end
        current_scene = queued_scene_change()
        setmetatable(love, { __index = current_scene })
        queued_scene_change = nil
        if current_scene.load then current_scene.load() end
    end
    if current_scene.update then current_scene.update(dt) end
end

-- Initialize default scene
ChangeScene(DEFAULT_SCENE)