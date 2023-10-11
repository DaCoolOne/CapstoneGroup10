

-- Super simple scene to draw modules as they will appear on the bomb.
-- To change which module is being rendered, change this variable
local MODULE_TO_RENDER = "example_module"

local bmr = {}

local module = love.filesystem.load("modules/" .. MODULE_TO_RENDER .. '.lua')()
setmetatable(bmr, { __index = module })

function bmr.draw()
    love.graphics.push()

    -- Center the module
    love.graphics.translate(love.graphics.getWidth() / 2 - 200, love.graphics.getHeight() / 2 - 200)

    -- Draw outer boundary of module
    local cr, cg, cb, ca = love.graphics.getColor()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("line", 0, 0, 400, 400)
    love.graphics.setColor(cr, cg, cb, ca)

    -- Draw the module
    module.draw()

    love.graphics.pop()
end

return bmr