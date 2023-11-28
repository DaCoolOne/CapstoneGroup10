local module = {}

-- Generally speaking, when writing Lua code you should make your variables local unless you have a good reason to make them global. It's just good to avoid cluttering the global namespace.
-- There are exceptions, such as in the case of the info module.
local numpad = {}
local img, text
local width = 400
local height = 400
local buttons = {"0","1","2","3","4","5","6","7","8","9",".","-","<-"}
local module_complete = 0

function module.load()
    -- This function is called once when the module is first loaded. You should put any first-time generation code here.

    text = ""
    img = love.graphics.newImage("resources/battery.png") -- Load picture of battery for source    
    local numpad_button_size = 25
    local current_width = 25
    local current_height = height - (7*(numpad_button_size + 5)) - 5
    local width_count = 0
    for i, v in ipairs(buttons) do
        if (i == (#buttons)) then
            numpad[i] = {
                x = current_width,
                y = current_height,
                w = (2 * numpad_button_size) + 5,
                h = numpad_button_size,
                text = buttons[i],
            }
            
        elseif(width_count == 0) then
            numpad[i] = {
                x = current_width,
                y = current_height,
                w = numpad_button_size,
                h = numpad_button_size,
                text = buttons[i],
            }

        else
            numpad[i] = {
                x = current_width,
                y = current_height,
                w = numpad_button_size,
                h = numpad_button_size,
                text = buttons[i],
            }
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

    love.graphics.setBackgroundColor(0.6, 0.65, 0.6, 0.5)
end

function module.update(dt)
    -- This function is called every frame and is where you should update any state variables
end

function module.draw()
    -- This function is called every frame and is where you should draw your module

    love.graphics.setColor(1,1,1)
    numpad_font = love.graphics.newFont(20)
    local numpad_button_size = 25
    local current_width = 25
    local current_height = height - (7*(numpad_button_size + 5)) - 5
    local width_count = 0

    for i, v in ipairs(buttons) do

        if(i == (#buttons)) then
            love.graphics.rectangle("line", current_width, current_height, ((2 * numpad_button_size) + 5), numpad_button_size)
            love.graphics.print(v, current_width + 6, current_height + 6)
        elseif(width_count == 0) then
            love.graphics.rectangle("line", current_width, current_height, numpad_button_size, numpad_button_size)
            love.graphics.print(v, current_width + 6, current_height + 6)
        else
            love.graphics.rectangle("line", current_width, current_height, numpad_button_size, numpad_button_size)
            love.graphics.print(v, current_width + 6, current_height + 6)
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
    
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("line", 100, 40, 200, 120)
    love.graphics.print("R", 200, 15, 0, 2, 2)
    love.graphics.print("R", 300, 100, 0, 2, 2)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(img, 50, 50)
    love.graphics.rectangle("line", 100, 310,200, 50)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(text, 100, 325, 120, "right", 0, 1.5, 1.5)
end

local buttonPressed

    function module.getButtonPressed(x, y)
        for k, v in pairs(buttons) do
            if (x > numpad[k].x and x < numpad[k].x + numpad[k].w) and (y > numpad[k].y and y < numpad[k].y + numpad[k].h) then
                return numpad[k].text
            end
        end
    end
    
    function module.mousepressed(x, y)
            buttonPressed = module.getButtonPressed(x, y)
    end
    
    function module.mousereleased(x, y)
        buttonPressed = module.getButtonPressed(x, y)
        if buttonPressed ~= nil then
            if buttonPressed ~= -1 and buttonPressed ~= "<-" and #text < 10 then
                text = text .. buttonPressed
            elseif buttonPressed ~= -1 and buttonPressed == "<-" and #text > 0 then
                text = text:sub(1, -2)
            end
        end
        buttonPressed = -1
    end

return module
