

-- Super simple scene to draw modules as they will appear on the bomb.
-- To change which module is being rendered, change this variable
local MODULE_TO_RENDER = "example_module"

local bmr = {}
local mousex, mousey = 0, 0

local module = love.filesystem.load("modules/" .. MODULE_TO_RENDER .. '.lua')()
setmetatable(bmr, { __index = module })

function bmr.mousepressed(x, y, ...) if module.mousepressed then module.mousepressed(mousex, mousey, ...) end end
function bmr.mousereleased(x, y, ...) if module.mousereleased then module.mousereleased(mousex, mousey, ...) end end
function bmr.mousemoved(x, y, ...) if module.mousemoved then module.mousemoved(mousex, mousey, ...) end end

local mp = love.mouse.getPosition

local mouse_overrides = {
    getPosition = function() return mousex, mousey end,
    getX = function() return mousex end,
    getY = function() return mousey end
}
setmetatable(mouse_overrides, { __index = love.mouse })
love.mouse = mouse_overrides

function bmr.draw()
    love.graphics.push()

    -- Center the module
    love.graphics.translate(love.graphics.getWidth() / 2 - 200, love.graphics.getHeight() / 2 - 200)

    -- Backwards compute the mouse coordinates
    mousex, mousey = love.graphics.inverseTransformPoint(mp())

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