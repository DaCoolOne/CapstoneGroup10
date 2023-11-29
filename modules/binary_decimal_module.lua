local module = {}

-- Generally speaking, when writing Lua code you should make your variables local unless you have a good reason to make them global. It"s just good to avoid cluttering the global namespace.
-- There are exceptions, such as in the case of the info module.
local light_timer = 0

local img
local input
local goal_num
local HexChars = {"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"}
local buttons = {}
local start_text
local completed

-- Module callbacks mirror the names of the callbacks in the love2d framework. So while in love, you would override love.load or love.draw, in a module you override module.load or module.draw
function module.load()
    -- This function is called once when the module is first loaded. You should put any first-time generation code here.
    goal_num = math.random(2048, 65535)
    BombInfo.num_batteries = 1

    if BombInfo.num_batteries == 1 then
        -- Hex to Bin
        start_text = string.upper(string.format("%x", goal_num))
    elseif BombInfo.num_batteries == 2 then
        -- dec to bin
        start_text = string.upper(string.format(goal_num))
    elseif BombInfo.num_batteries == 3 then
        -- dec to hex
        start_text = string.upper(string.format(goal_num))
    end

    input = ""
    img = love.graphics.newImage("resources/example.png")

    for x = 1, 4, 1 
    do
        for y = 1, 4, 1
        do
            buttons[HexChars[x + (4 * (y-1))]] = {
                x = (x * 75) - 74,
                y = (y * -75) + 398,
                w = 100,
                h = 100,
                text = HexChars[x + (4 * (y-1))]
            }
        end
    end
    buttons["BACK"] = {
        x = 315,
        y = 323,
        w = 100,
        h = 100,
        text = "BACK"
    }
    buttons["ENTER"] = {
        x = 315,
        y = 248,
        w = 100,
        h = 100,
        text = "ENTER"
    }

    completed = false
end

function module.update(dt)
    -- This function is called every frame and is where you should update any state variables
    -- light_timer = light_timer + dt
    -- if light_timer > 2 then
    --     light_timer = 0
    -- end
end

function module.draw()
    -- This function is called every frame and is where you should draw your module

    love.graphics.setColor(0.7, 0.7, 0.5)
    love.graphics.rectangle("fill", 0, 0, 400, 400)

    for k, v in pairs(buttons) do
        love.graphics.setColor(1,1,1)
        love.graphics.draw(img, v.x, v.y, 0, 0.75, 0.75)
        love.graphics.setColor(1,0,0)
        love.graphics.printf(v.text, v.x - 35, v.y + 34, 100, "center", 0, 1.5, 1.5)
    end
    
    -- Add backspace button

    if completed then
        love.graphics.setColor(0,1,0)
    else
        love.graphics.setColor(1,0,0)
    end
    love.graphics.rectangle("line", 20, 10, 370, 75)
    love.graphics.printf(input, 0, 25, 150, "right", 0, 2.5, 2.5)
    love.graphics.setColor(1,1,1)
    love.graphics.printf(start_text, 200, 86, 95, "right", 0, 2, 2)
end

local buttonPressed

function module.getButtonPressed(x, y)
    for k, v in pairs(buttons) do
        if (x > v.x and x < v.x + v.w) and (y > v.y and y < v.y + v.h) then
            return k
        end
    end
    return -1
end

function module.mousepressed(x, y)
    -- if buttonPressed == 1 then
        buttonPressed = module.getButtonPressed(x, y)
    -- end
end

function module.mousereleased(x, y)
    if buttonPressed == module.getButtonPressed(x, y) and not completed then
        -- Do nothing if no button is pressed, backspace is pressed, or input is 10 or more chars
        if buttonPressed ~= -1 and buttonPressed ~= "BACK" and buttonPressed ~= "ENTER" and #input < 17 then
            input = input .. buttonPressed
        elseif buttonPressed ~= -1 and buttonPressed == "BACK" and buttonPressed ~= "ENTER" and #input > 0 then
            input = input:sub(1, -2)
        elseif  buttonPressed ~= -1 and buttonPressed ~= "BACK" and buttonPressed == "ENTER" then
            if BombInfo.num_batteries == 1 then
                -- Hex to Bin
                if tonumber(input, 2) == goal_num then
                    completed = true
                    mark_solved()
                else
                    count_strike()
                end
            elseif BombInfo.num_batteries == 2 then
                -- dec to bin
                if tonumber(input, 2) == goal_num then
                    completed = true
                    mark_solved()
                else
                    count_strike()
                end
            elseif BombInfo.num_batteries == 3 then
                -- dec to hex
                if tonumber(input, 16) == goal_num then
                    completed = true
                    mark_solved()
                else
                    count_strike()
                end
            end
        end
    end
    buttonPressed = -1

    
end

-- Some other useful functions:
-- function module.mousepressed
-- function module.mousereleased
-- function module.mousemoved
-- Or any other function which is a valid love2d callback

return module
