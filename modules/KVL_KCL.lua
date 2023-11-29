local module = {}

-- Generally speaking, when writing Lua code you should make your variables local unless you have a good reason to make them global. It's just good to avoid cluttering the global namespace.
-- There are exceptions, such as in the case of the info module.
local numpad = {}
local img, text, solution, R_hor, R_ver
local width = 400
local height = 400
local buttons = {"0","1","2","3","4","5","6","7","8","9",".","-","<-", "ENTER"}
local module_complete = false
local rand_1 = math.random(0, 500)
local rand_2 = math.random(0, 500)
local rand_3 = math.random(0, 100) --Voltage
local rand_4 = math.random(0, 500)
local answer = ""
local complete = false 

function module.load()
    -- This function is called once when the module is first loaded. You should put any first-time generation code here.
    love.graphics.setColor(0.6, 0.65, 0.6, 0.5)
    love.graphics.rectangle("fill", 0, 0, 400, 400)
    
    if BombInfo.num_batteries == 1 then -- Current flows normally
        rand_3 = rand_3 * 1
        solution = (rand_3 / (rand_1 + ( 1 / (1 / rand_4 + 1 / rand_2))))

    elseif BombInfo.num_batteries == 2 then -- Current flows in reverse, voltage of battery is modified by 2

        solution = (rand_3 * 2 / (rand_1 + ( 1 / (1 / rand_4 + 1 / rand_2))))

    else -- Current flows in reverse, voltage of battery is modified by -2, 

        solution = (rand_3 * -2 / (rand_1 + ( 1 / (1 / rand_4 + 1 / rand_2))))

    end

    text = ""
    answer = ""
    R_hor = love.graphics.newImage("resources/resistor_horizontal.png")
    R_ver = love.graphics.newImage("resources/resistor_vertical.png")
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

end

function module.update(dt)
    -- This function is called every frame and is where you should update any state variables
    if module_complete == true then 
        answer = "answer"
    end 

end

function module.draw()
    -- This function is called every frame and is where you should draw your module

    if(module_complete == true) then
        love.graphics.setColor(0,0,0)
    else
        love.graphics.setColor(0.5, 0.7, 0.7)
    end
    love.graphics.rectangle("fill", 0, 0, 400, 400)

    love.graphics.setColor(1,1,1)
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
    love.graphics.rectangle("line", 100, 40, 150, 120)
    --love.graphics.print("Solve for the current \n... Round to the 5th decimal place.", 100, 235, 0, 1.2, 1.2)
    love.graphics.print("R = " .. rand_1, 200, 15, 0, 1.5, 1.5)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(R_hor, 135, 30)
    love.graphics.setColor(1, 0, 0)
    love.graphics.print("R = " .. rand_2, 300, 80, 0, 1.5, 1.5)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(R_ver, 290, 75)
    love.graphics.setColor(1, 0, 0)
    love.graphics.print("R = " .. rand_4, 175, 80, 0, 1.5, 1.5)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(R_ver, 240, 75)
    love.graphics.print("V = " .. rand_3, 25, 25, 0, 1.5, 1.5)
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
    if buttonPressed ~= nil and module_complete == false then
        if buttonPressed ~= -1 and buttonPressed ~= "<-" and #text < 10 and buttonPressed ~= "ENTER" then
            text = text .. buttonPressed
            answer = answer .. buttonPressed
        elseif buttonPressed ~= -1 and buttonPressed == "<-" and #text > 0 then
            text = text:sub(1, -2)
            answer = answer:sub(1, -2)
        elseif buttonPressed ~= -1 and buttonPressed == 'ENTER' and #text > 0 then
            if answer == tostring(module.round(solution, -5)) then
                module_complete = true
                mark_solved()
            else
                count_strike()
            end
        end
    end
    buttonPressed = -1
end

function module.round(x, r_pos)
    local percision = math.pow(10, r_pos)
    x = x + (percision / 2)
    return math.floor(x / percision) * percision
end

return module
