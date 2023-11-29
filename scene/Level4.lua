 -- level4.lua
 -- By: Michael Johnson
local level4 = {}

function level4.load()
     -- Modules to load
    local MODULE_TO_RENDER_1 = "digital_logic"
    local MODULE_TO_RENDER_2 = "binary_decimal_module"
    local MODULE_TO_RENDER_3 = "KVL_KCL"
    local MODULE_TO_RENDER_4 = "info_module"

     -- Gets modules from files
    local module_1 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_3 .. '.lua')()
    local module_2 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_1 .. '.lua')()
    local module_3 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_2 .. '.lua')()
    local module_4 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_1 .. '.lua')()
    local module_5 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_2 .. '.lua')()
    local module_6 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_2 .. '.lua')()
    local module_7 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_1 .. '.lua')()
    local module_8 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_3 .. '.lua')()
    local module_9 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_4 .. '.lua')()

     -- Stores the modules and their x and y values
    local modules = {module_1, module_2, module_3, module_4, module_5, module_6, module_7, module_8, module_9}
    local framework = love.filesystem.load("scene/Framework.lua")(modules)
    framework.load()
 
     -- Deals with framework.update, framework.draw, etc
    setmetatable(level4, { __index = framework })
end
 
return level4