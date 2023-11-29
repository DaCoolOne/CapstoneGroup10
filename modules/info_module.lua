local module = {}

-- Generally speaking, when writing Lua code you should make your variables local unless you have a good reason to make them global. It's just good to avoid cluttering the global namespace.
-- There are exceptions, such as in the case of the info module.
local text, battery

local SERIAL_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
local SERIAL_LENGTH = 8

local start_time, end_time

local count_strike = function()
    BombInfo.strikes_remaining = BombInfo.strikes_remaining - 1
end

local mark_solved = function()
    BombInfo.modules_solved = BombInfo.modules_solved + 1
end

function module.newBombInfo()
    local manufacturer_ndx = math.random(1,3)
    BombInfo.manufacturer = manufacturers[manufacturer_ndx]
    BombInfo.num_batteries = math.random(1,3)
    BombInfo.strikes_remaining = 3 -- TODO
    BombInfo.modules_solved = 0
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

    battery = love.graphics.newImage("resources/battery.png")
    mark_solved()

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

    love.graphics.printf(time_text, 0, 10, 100, "right", 0, 4, 4)
    love.graphics.setColor(1,1,1)
    love.graphics.printf(BombInfo.serial, 0, 60, 100, "right", 0, 4, 4)
    love.graphics.printf(BombInfo.manufacturer, 10, 120, 75, "left", 0, 4, 4)
    love.graphics.printf("Strikes Left: "..BombInfo.strikes_remaining, 0, 240, 100, "right", 0, 4, 4)

    for i = 1, BombInfo.num_batteries do
        love.graphics.draw(battery, ((i - 1) * (100)) + 5, 300)
    end
end

function module.mousepressed(x, y, button)
    if(button == 1) then
    end
end

-- Some other useful functions:
-- function module.mousepressed
-- function module.mousereleased
-- function module.mousemoved
-- Or any other function which is a valid love2d callback

rawset(_G, "count_strike", count_strike)
rawset(_G, "mark_solved", mark_solved)
module.newBombInfo()
return module
