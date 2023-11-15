local module = {}

-- Generally speaking, when writing Lua code you should make your variables local unless you have a good reason to make them global. It's just good to avoid cluttering the global namespace.
-- There are exceptions, such as in the case of the info module.
local module_complete = 0
local numpad = {}
local numpad_font = nil

local width = 400
local height = 400

local function newNumpadButton(text, fn)
    return {
        text = text,
        fn = fn
    }
end

-- Module callbacks mirror the names of the callbacks in the love2d framework. So while in love, you would override love.load or love.draw, in a module you override module.load or module.draw
function module.load()
    -- This function is called once when the module is first loaded. You should put any first-time generation code here.
    
    -- Creates a list of numpad buttons
    table.insert(numpad, newNumpadButton(
        "1",
        function()
            print("1")
        end))

    table.insert(numpad, newNumpadButton(
        "2",
        function()
            print("2")
        end))

    table.insert(numpad, newNumpadButton(
        "3",
        function()
            print("3")
        end))

    table.insert(numpad, newNumpadButton(
        "4",
        function()
            print("4")
        end))

    table.insert(numpad, newNumpadButton(
        "5",
        function()
            print("5")
        end))

    table.insert(numpad, newNumpadButton(
        "6",
        function()
            print("6")
        end))
    
    table.insert(numpad, newNumpadButton(
        "7",
        function()
            print("7")
        end))

    table.insert(numpad, newNumpadButton(
        "8",
        function()
            print("8")
        end))

    table.insert(numpad, newNumpadButton(
        "9",
        function()
            print("9")
        end))

    table.insert(numpad, newNumpadButton(
        "0",
        function()
            print("0")
        end))

    table.insert(numpad, newNumpadButton(
        ".",
        function()
            print(".")
        end))

    table.insert(numpad, newNumpadButton(
        "-",
        function()
            print("-")
        end))

    table.insert(numpad, newNumpadButton(
        "<-",
        function()
            print("<-")
        end))
    
    love.graphics.setBackgroundColor(0.6, 0.65, 0.6, 0.5)
end

function module.update(dt)
    -- This function is called every frame and is where you should update any state variables
end

function module.draw()
    -- This function is called every frame and is where you should draw your module
    numpad_font = love.graphics.newFont(16)
    
    local numpad_button_size = 35
    
    local current_width = 25
    local current_height = height - (7*(numpad_button_size + 5)) - 5

    local width_count = 0

    for i, numpad_button in ipairs(numpad) do
        if(i == (#numpad)) then
            love.graphics.rectangle("fill", current_width, current_height, ((2 * numpad_button_size) + 5), numpad_button_size)
        elseif(width_count == 0) then
            love.graphics.rectangle("fill", current_width, current_height, numpad_button_size, numpad_button_size)
        else
            love.graphics.rectangle("fill", current_width, current_height, numpad_button_size, numpad_button_size)
        end

        if(width_count == 0) then
            current_width = current_width + (numpad_button_size + 5)
            width_count = width_count + 1
        else
            current_width = current_width - (numpad_button_size + 5)
            current_height = current_height + (numpad_button_size + 5)
            width_count = width_count - 1
        end
    end

    love.graphics.print("Serial: "..BombInfo.serial, 10, 378)
end

-- Some other useful functions:
-- function module.mousepressed
-- function module.mousereleased
-- function module.mousemoved
-- Or any other function which is a valid love2d callback

return module