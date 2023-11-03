local module = {}

-- Generally speaking, when writing Lua code you should make your variables local unless you have a good reason to make them global. It's just good to avoid cluttering the global namespace.
-- There are exceptions, such as in the case of the info module.
local text, img

local SERIAL_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
local SERIAL_LENGTH = 8

local start_time, end_time

function module.newBombInfo()
    local manufacturer_ndx = math.random(1,3)
    BombInfo.manufacturer = manufacturers[manufacturer_ndx]
    BombInfo.num_batteries = math.random(1,3)
    BombInfo.serial = ""

    for i = 1, SERIAL_LENGTH do
        local ndx = math.random (1, #SERIAL_CHARS)

        BombInfo.serial = BombInfo.serial .. SERIAL_CHARS:sub(ndx,ndx)
    end

    -- timer info is filled in the load function
end

-- Module callbacks mirror the names of the callbacks in the love2d framework. So while in love, you would override love.load or love.draw, in a module you override module.load or module.draw
function module.load()
    -- This function is called once when the module is first loaded. You should put any first-time generation code here.
    if love.math.random() > 0.5 then
        text = "Hello World"
    else
        text = "Hello Bomb"
    end

    img = love.graphics.newImage("resources/example.png")

    -- current time + 5 minutes
    start_time = love.timer.getTime()
    end_time = start_time + 300
end

function module.update(dt)
    -- This function is called every frame and is where you should update any state variables
    BombInfo.seconds_remaining = math.floor(end_time - love.timer.getTime())

end

function module.draw()
    -- This function is called every frame and is where you should draw your module

    if BombInfo.seconds_remaining > 30 or BombInfo.seconds_remaining % 2 == 0 then
        love.graphics.setColor(0,1,0)
    else
        love.graphics.setColor(1,0,0)
    end

    local minutes = math.floor(BombInfo.seconds_remaining / 60)
    local seconds = BombInfo.seconds_remaining % 60

    local time_text
    if seconds > 9 then
        time_text = minutes..":"..seconds
    else
        time_text = minutes..":0"..seconds
    end

    love.graphics.print(time_text, 200, 200)

    --love.graphics.draw(img, 200, 200, 0, 1, 1, 50, 50)

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(text, 10, 10)
    love.graphics.print("Serial: "..BombInfo.serial, 10, 378)
    love.graphics.print("Manufacturer:"..BombInfo.manufacturer, 10, 350)
    love.graphics.print("Number of Batteries:"..BombInfo.num_batteries, 10, 325)

    love.graphics.circle("line", love.mouse.getX(), love.mouse.getY(), 20)
end

-- Some other useful functions:
-- function module.mousepressed
-- function module.mousereleased
-- function module.mousemoved
-- Or any other function which is a valid love2d callback

module.newBombInfo()

return module
