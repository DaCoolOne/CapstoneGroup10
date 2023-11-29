local module = {}
local green_input1_image = love.graphics.newImage("resources/images/greenButton.png")
local green_input2_image = love.graphics.newImage("resources/images/redButton.png")

local and_input1 = false
local and_input2 = false
local and_output = false

local or_input1 = false
local or_input2 = false
local or_output = false

local nand_input1 = false
local nand_input2 = false
local nand_output = false

local nor_input1 = false
local nor_input2 = false
local nor_output = false

local RED = {1, 0, 0} -- Red
local GREEN = {0, 1, 0} -- Green
local BLUE = {0, 0, 1} -- Blue
local CLEAR = {0.5, 0.5, 0.5} -- Clear (background color)
local BLACK = {0, 0, 0} -- Black
local YELLOW = {252,252,129} -- Yellow 
local WHITE = {255,255,255} -- White
local largeFontSize = 30
local smallFontSize = 15
local mediumFontSize = 20
local submitted = false


local box_1 = {"?", "AND", "NAND","OR","NOR"} -- Array of texts
local current_text_box_index = 1 -- Initial index of the current text

local box_2 = {"?", "AND", "NAND","OR","NOR"} -- Array of texts
local current_text_box2_index = 1 -- Initial index of the current text

local box_3 = {"?", "AND", "NAND","OR","NOR"} -- Array of texts
local current_text_box3_index = 1 -- Initial index of the current text

local box_4 = {"?", "AND", "NAND","OR","NOR"} -- Array of texts
local current_text_box4_index = 1 -- Initial index of the current text



function module.load()

end
  
-- Handle Updating the Window --
function module.update()
    -- *Implement the AND gate logic
    local andGateOutput = and_input1 and and_input2
    local orGateOutput = or_input1 or or_input2
    local nandGateOutput =  not (nand_input1 and nand_input2)
    local norGateOutput =  not (nor_input1 or nor_input2)
    and_output = andGateOutput
    or_output = orGateOutput
    nand_output = nandGateOutput
    nor_output = norGateOutput
end

function module.draw()
    local scale_factor = 0.12
    love.graphics.clear(CLEAR)

    love.graphics.setColor(BLACK)
    love.graphics.setFont(love.graphics.newFont(smallFontSize))
    love.graphics.print("Guess the logic gate",100)
    -- INPUT SWITCH
    love.graphics.setColor(WHITE)
    -- AND Done
    love.graphics.draw(green_input1_image, 0, 0, 0, scale_factor, scale_factor)
    love.graphics.setFont(love.graphics.newFont(smallFontSize))
    love.graphics.print(" " .. (and_input1 and 1 or 0), 10, 15)
    love.graphics.draw(green_input2_image, 0, 22, 0, scale_factor, scale_factor)
    love.graphics.print("  " .. (and_input2 and 1 or 0), 5, 35)

    -- OR Done 
    love.graphics.draw(green_input1_image, 0, 70, 0, scale_factor, scale_factor)
    love.graphics.print(" " .. (nand_input1 and 1 or 0), 10, 85)
    love.graphics.draw(green_input2_image, 0, 92, 0, scale_factor, scale_factor)
    love.graphics.print(" " .. (nand_input2 and 1 or 0), 10, 105)

    -- NAND Done 
    love.graphics.draw(green_input1_image, 0, 125, 0, scale_factor, scale_factor)
    love.graphics.print(" " .. (or_input1 and 1 or 0), 10, 140)
    love.graphics.draw(green_input2_image, 0, 148, 0, scale_factor, scale_factor)
    love.graphics.print(" " .. (or_input2 and 1 or 0), 10, 160)
    
    -- NOR Done 
    love.graphics.draw(green_input1_image, 0, 185, 0, scale_factor, scale_factor)
    love.graphics.print(" " .. (nor_input1 and 1 or 0), 10, 200)
    love.graphics.draw(green_input2_image, 0, 205, 0, scale_factor, scale_factor)
    love.graphics.print(" " .. (nor_input2 and 1 or 0), 10, 220)

    -- LINE BETWEEN INPUT AND GATE
    love.graphics.setColor(BLACK)
    love.graphics.line(50, 25, 150, 25) -- Line from Input 1 to the box
    love.graphics.line(50, 45, 150, 45) -- Line from Input 2 to the box
    love.graphics.line(50, 95, 150, 95) -- Line from Input 1 to the box
    love.graphics.line(50, 113, 150, 113) -- Line from Input 2 to the box
    love.graphics.line(50, 148, 150, 148) -- Line from Input 1 to the box
    love.graphics.line(50, 172, 150, 172) -- Line from Input 2 to the box
    love.graphics.line(50, 210, 150, 210) -- Line from Input 1 to the box
    love.graphics.line(50, 230, 150, 230) -- Line from Input 2 to the box

    -- WHAT THE GATE LOOKS LIKE 
    local hexColor = "#eedc5b"
    local r, g, b = tonumber(hexColor:sub(2, 3), 16) / 255, tonumber(hexColor:sub(4, 5), 16) / 255, tonumber(hexColor:sub(6, 7), 16) / 255

    love.graphics.setColor(r, g, b)
    love.graphics.rectangle("fill", 150, 15, 50, 50)
    love.graphics.setFont(love.graphics.newFont(smallFontSize))
    love.graphics.setColor(WHITE)
    love.graphics.print(box_1[current_text_box_index], 160, 15)

    love.graphics.setColor(r, g, b)
    love.graphics.rectangle("fill", 150, 78, 50, 50)
    love.graphics.setFont(love.graphics.newFont(smallFontSize))
    love.graphics.setColor(WHITE)
    love.graphics.print(box_2[current_text_box2_index], 160, 78)

    love.graphics.setColor(r, g, b)
    love.graphics.rectangle("fill", 150, 140, 50, 50)
    love.graphics.setFont(love.graphics.newFont(smallFontSize))
    love.graphics.setColor(WHITE)
    love.graphics.print(box_3[current_text_box3_index], 160, 150)

    love.graphics.setColor(r, g, b)
    love.graphics.rectangle("fill", 150, 200, 50, 50)
    love.graphics.setFont(love.graphics.newFont(smallFontSize))
    love.graphics.setColor(WHITE)
    love.graphics.print(box_4[current_text_box4_index], 160, 210)

    -- LINE BETWEEN GATE AND LINE 
    love.graphics.setColor(BLACK)
    love.graphics.line(250, 35, 200, 35)
    love.graphics.line(250, 100, 200, 100)
    love.graphics.line(250, 170, 200, 170)
    love.graphics.line(250, 225, 200, 225)

    -- LED SECTION
    love.graphics.setColor(and_output and YELLOW or BLACK)
    love.graphics.circle("fill", 250, 35, 20)

    love.graphics.setColor(nand_output and YELLOW or BLACK)
    love.graphics.circle("fill", 250, 100, 20)

    love.graphics.setColor(or_output and YELLOW or BLACK)
    love.graphics.circle("fill", 250, 165, 20)

    love.graphics.setColor(nor_output and YELLOW or BLACK)
    love.graphics.circle("fill", 250, 220, 20)


    -- SUBMIT BUTTON  
    love.graphics.setColor(BLUE)
    love.graphics.rectangle("fill", 200, 300 , 80, 50)
    love.graphics.setFont(love.graphics.newFont(mediumFontSize))
    love.graphics.setColor(WHITE)
    love.graphics.print("Submit", 205, 305)


end


--* Handle Mouse Clicks --
function module.mousepressed(x, y, button)
    if button == 1 then -- Check if the left mouse button (button 1) was clicked
        -- Check if the mouse click is within the boundaries of Input 1 text
        if x > 0 and x < 50 and y > 0 and y < 30 then
            and_input1 = not and_input1 -- Toggle the state of Input 1
        end
        -- Check if the mouse click is within the boundaries of Input 2 text
        if x > 0 and x < 50 and y > 40 and y < 55 then
            and_input2 = not and_input2 -- Toggle the state of Input 2
        end

        -- Check if the mouse click is within the boundaries of OR Input 1 text
        if x > 0 and x < 50 and y > 80 and y < 100 then
            nand_input1 = not nand_input1 -- Toggle the state of OR Input 1
        end

        -- Check if the mouse click is within the boundaries of OR Input 2 text
        if x > 0 and x < 50 and y > 112 and y < 120 then
            nand_input2 = not nand_input2 -- Toggle the state of OR Input 2
        end

        -- Check if the mouse click is within the boundaries of NAND Input 1 text
        if x > 0 and x < 50 and y > 120 and y < 160 then
            or_input1 = not or_input1 -- Toggle the state of NAND Input 1
        end

        -- Check if the mouse click is within the boundaries of NAND Input 2 text
        if x > 0 and x < 50 and y > 170 and y < 180 then
            or_input2 = not or_input2 -- Toggle the state of NAND Input 2
        end

        -- Check if the mouse click is within the boundaries of NOR Input 1 text
        if x > 0 and x < 50 and y > 200 and y < 215 then
            nor_input1 = not nor_input1 -- Toggle the state of NOR Input 1
        end

        -- Check if the mouse click is within the boundaries of NOR Input 2 text
        if x > 0 and x < 50 and y > 220 and y < 235 then
            -- nor_input2 = not nor_input2 -- Toggle the state of NOR Input 2
        end


        if x > 150 and x < 200 and y > 0 and y < 70 then
            current_text_box_index = current_text_box_index + 1
            if current_text_box_index > #box_1 then
                current_text_box_index = 1 -- Reset to the first text
            end
        end

        if x > 150 and x < 200 and y > 70 and y < 120 then
            current_text_box2_index = current_text_box2_index + 1
            if current_text_box2_index > #box_2 then
                current_text_box2_index = 1 -- Reset to the first text
            end
        end
        
        if x > 150 and x < 200 and y > 120 and y < 190 then
            current_text_box3_index = current_text_box3_index + 1
            if current_text_box3_index > #box_3 then
                current_text_box3_index = 1 -- Reset to the first text
            end
        end
        
        if x > 150 and x < 200 and y > 190 and y < 250 then
            current_text_box4_index = current_text_box4_index + 1
            if current_text_box4_index > #box_4 then
                current_text_box4_index = 1 -- Reset to the first text
            end
        end
        
        -- SUBMIT BUTTON CLICKABLE AREA 
        if x > 200 and x < 300 and y > 270 and y < 400 then 
            -- CHECK IF all boxes are correct 
            submitted = true 
            module.checkAnswer()
            

        end 

    end
end

function module.checkAnswer()
    local correctAnswers = {
        box_1 = {"AND"},
        box_2 = {"NAND"},
        box_3 = {"OR"},
        box_4 = {"NOR"}
        -- Add more correct answers as needed
    }

    local userAnswers = {
        box_1 = box_1[current_text_box_index],
        box_2 = box_2[current_text_box2_index],
        box_3 = box_3[current_text_box3_index],
        box_4 = box_4[current_text_box4_index]
    }

    local allCorrect = true

    for box, correctOptions in pairs(correctAnswers) do
        local userOption = userAnswers[box]
        local isCorrect = false

        for _, correctOption in ipairs(correctOptions) do
            if userOption == correctOption then
                isCorrect = true
                break
            end
        end

        if not isCorrect then
            allCorrect = false
            break
        end
    end

    if allCorrect then
        mark_solved()
    else
        count_strike()
    end
end


return module
