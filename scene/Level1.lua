 -- level1.lua
 -- By: Michael Johnson
 local level1 = {}


function level1.load()
     -- Modules to load
    local MODULE_TO_RENDER_1 = "example_module copy"
    local MODULE_TO_RENDER_3 = "colorchanging"
    local MODULE_TO_RENDER_4 = "info_module"
 
     -- Gets modules from files
    local module_1 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_4 .. '.lua')()
    local module_2 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_1 .. '.lua')()
    local module_3 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_3 .. '.lua')()
 
     -- Stores the modules and their x and y values
    local modules = {module_1, module_2, module_3}
    local framework = love.filesystem.load("scene/Framework.lua")(modules)
    framework.load()
 
     -- Deals with framework.update, framework.draw, etc
    setmetatable(level1, { __index = framework })
end
 
return level1