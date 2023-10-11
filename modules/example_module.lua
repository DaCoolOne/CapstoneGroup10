local module = {}

-- Generally speaking, when writing Lua code you should make your variables local unless you have a good reason to make them global. It's just good to avoid cluttering the global namespace.
-- There are exceptions, such as in the case of the info module.
local light_timer = 0
local text, img

-- Module callbacks mirror the names of the callbacks in the love2d framework. So while in love, you would override love.load or love.draw, in a module you override module.load or module.draw
function module.load()
    -- This function is called once when the module is first loaded. You should put any first-time generation code here.
    if love.math.random() > 0.5 then
        text = "Hello World"
    else
        text = "Hello Bomb"
    end

    img = love.graphics.newImage("resources/example.png")
end

function module.update(dt)
    -- This function is called every frame and is where you should update any state variables
    light_timer = light_timer + dt
    if light_timer > 2 then
        light_timer = 0
    end
end

function module.draw()
    -- This function is called every frame and is where you should draw your module
    if light_timer > 1 then
        love.graphics.setColor(1, 0, 0)
    else
        love.graphics.setColor(0, 1, 0)
    end
    love.graphics.draw(img, 200, 200, 0, 1, 1, 50, 50)

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(text, 10, 10)
    love.graphics.print("Serial: "..BombInfo.serial, 10, 378)
end

-- Some other useful functions:
-- function module.mousepressed
-- function module.mousereleased
-- function module.mousemoved
-- Or any other function which is a valid love2d callback

return module