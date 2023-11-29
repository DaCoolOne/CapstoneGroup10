local module = {}
local and_input1_image = love.graphics.newImage("images/greenButton.png")
local and_input2_image = love.graphics.newImage("images/redButton.png")

local and_input1 = false
local and_input2 = false
local and_output = false

local or_input1_image = love.graphics.newImage("images/greenButton.png")
local or_input2_image = love.graphics.newImage("images/redButton.png")

local or_input1 = false
local or_input2 = false
local or_output = false

local nand_input1_image = love.graphics.newImage("images/greenButton.png")
local nand_input2_image = love.graphics.newImage("images/redButton.png")
local nand_input1 = false
local nand_input2 = false
local nand_output = false

local nor_input1_image = love.graphics.newImage("images/greenButton.png")
local nor_input2_image = love.graphics.newImage("images/redButton.png")
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
local largeFontSize = 45
local smallFontSize = 15

  


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
    local scale_factor = 0.3
    love.graphics.clear(CLEAR)

    -- INPUT SWITCH
    love.graphics.draw(and_input1_image, 0, 0, 0, scale_factor, scale_factor)
    love.graphics.setColor(RED)
    love.graphics.setFont(love.graphics.newFont(smallFontSize))
    love.graphics.print(" " .. (and_input1 and 1 or 0), 120, 50)

    love.graphics.draw(and_input2_image, 0, 50, 0, scale_factor, scale_factor)
    love.graphics.setColor(GREEN)
    love.graphics.setFont(love.graphics.newFont(smallFontSize))
    love.graphics.print("  " .. (and_input2 and 1 or 0), 120, 100)

    love.graphics.draw(or_input1_image, 0, 120, 0, scale_factor, scale_factor)
    love.graphics.setColor(RED)
    love.graphics.setFont(love.graphics.newFont(smallFontSize))
    love.graphics.print(" " .. (nand_input1 and 1 or 0), 120, 175)
    love.graphics.draw(or_input2_image, 0, 170, 0, scale_factor, scale_factor)
    love.graphics.setColor(GREEN)
    love.graphics.setFont(love.graphics.newFont(smallFontSize))
    love.graphics.print(" " .. (nand_input2 and 1 or 0), 120, 230)

    love.graphics.draw(nand_input1_image, 0, 250, 0, scale_factor, scale_factor)
    love.graphics.setColor(RED)
    love.graphics.setFont(love.graphics.newFont(smallFontSize))
    love.graphics.print(" " .. (or_input1 and 1 or 0), 120, 300)
    love.graphics.draw(nand_input2_image, 0, 300, 0, scale_factor, scale_factor)
    love.graphics.setColor(GREEN)
    love.graphics.setFont(love.graphics.newFont(smallFontSize))
    love.graphics.print(" " .. (or_input2 and 1 or 0), 120, 350)

    love.graphics.draw(nor_input1_image, 0, 375, 0, scale_factor, scale_factor)
    love.graphics.setColor(RED)
    love.graphics.setFont(love.graphics.newFont(smallFontSize))
    love.graphics.print(" " .. (nor_input1 and 1 or 0), 120, 430)
    love.graphics.draw(nor_input2_image, 0, 420, 0, scale_factor, scale_factor)
    love.graphics.setColor(GREEN)
    love.graphics.setFont(love.graphics.newFont(smallFontSize))
    love.graphics.print(" " .. (nor_input2 and 1 or 0), 120, 480)

    -- LINE BETWEEN INPUT AND GATE
    love.graphics.setColor(BLACK)
    love.graphics.line(170, 65, 300, 65) -- Line from Input 1 to the box
    love.graphics.line(170, 115, 300, 115) -- Line from Input 2 to the box

    love.graphics.setColor(BLACK)
    love.graphics.line(170, 190, 300, 190) -- Line from Input 1 to the box
    love.graphics.line(170, 240, 300, 240) -- Line from Input 2 to the box

    love.graphics.setColor(BLACK)
    love.graphics.line(170, 317, 300, 317) -- Line from Input 1 to the box
    love.graphics.line(170, 365, 300, 365) -- Line from Input 2 to the box

    love.graphics.setColor(BLACK)
    love.graphics.line(170, 442, 300, 442) -- Line from Input 1 to the box
    love.graphics.line(170, 490, 300, 490) -- Line from Input 2 to the box

    -- WHAT THE GATE LOOKS LIKE 
    local hexColor = "#eedc5b"
    local r, g, b = tonumber(hexColor:sub(2, 3), 16) / 255, tonumber(hexColor:sub(4, 5), 16) / 255, tonumber(hexColor:sub(6, 7), 16) / 255
    love.graphics.setColor(r, g, b)
    love.graphics.rectangle("fill", 300, 50, 100, 100)
    love.graphics.setFont(love.graphics.newFont(largeFontSize))
    love.graphics.setColor(WHITE)
    love.graphics.print("?", 340, 78)

    love.graphics.setColor(r, g, b)
    love.graphics.rectangle("fill", 300, 170, 100, 100)
    love.graphics.setFont(love.graphics.newFont(largeFontSize))
    love.graphics.setColor(WHITE)
    love.graphics.print("?", 340, 180)

    love.graphics.setColor(r, g, b)
    love.graphics.rectangle("fill", 300, 290, 100, 100)
    love.graphics.setFont(love.graphics.newFont(largeFontSize))
    love.graphics.setColor(WHITE)
    love.graphics.print("?", 340, 310)

    love.graphics.setColor(r, g, b)
    love.graphics.rectangle("fill", 300, 410, 100, 100)
    love.graphics.setFont(love.graphics.newFont(largeFontSize))
    love.graphics.setColor(WHITE)
    love.graphics.print("?", 340, 425)

    -- LINE BETWEEN GATE AND LINE 
    love.graphics.setColor(BLACK)
    love.graphics.line(400, 100, 500, 100)

    love.graphics.setColor(BLACK)
    love.graphics.line(400, 220, 500, 220)

    love.graphics.setColor(BLACK)
    love.graphics.line(400, 340, 500, 340)

    love.graphics.setColor(BLACK)
    love.graphics.line(400, 460, 500, 460)

    -- LED SECTION
    love.graphics.setColor(and_output and YELLOW or BLACK)
    love.graphics.circle("fill", 500, 105, 20)

    love.graphics.setColor(nand_output and YELLOW or BLACK)
    love.graphics.circle("fill", 500, 220, 20)

    love.graphics.setColor(or_output and YELLOW or BLACK)
    love.graphics.circle("fill", 500, 335, 20)

    love.graphics.setColor(nor_output and YELLOW or BLACK)
    love.graphics.circle("fill", 500, 450, 20)

end


--* Handle Mouse Clicks --
function module.mousepressed(x, y, button)
    if button == 1 then -- Check if the left mouse button (button 1) was clicked
        -- Check if the mouse click is within the boundaries of Input 1 text
        if x > 50 and x < 150 and y > 50 and y < 80 then
            and_input1 = not and_input1 -- Toggle the state of Input 1
        end

        -- Check if the mouse click is within the boundaries of Input 2 text
        if x > 50 and x < 150 and y > 100 and y < 130 then
            and_input2 = not and_input2 -- Toggle the state of Input 2
        end

        -- Check if the mouse click is within the boundaries of OR Input 1 text
        if x > 50 and x < 150 and y > 175 and y < 205 then
            nand_input1 = not nand_input1 -- Toggle the state of OR Input 1
        end

        -- Check if the mouse click is within the boundaries of OR Input 2 text
        if x > 50 and x < 150 and y > 225 and y < 255 then
            nand_input2 = not nand_input2 -- Toggle the state of OR Input 2
        end

        -- Check if the mouse click is within the boundaries of NAND Input 1 text
        if x > 50 and x < 150 and y > 300 and y < 330 then
            or_input1 = not or_input1 -- Toggle the state of NAND Input 1
        end

        -- Check if the mouse click is within the boundaries of NAND Input 2 text
        if x > 50 and x < 150 and y > 350 and y < 380 then
            or_input2 = not or_input2 -- Toggle the state of NAND Input 2
        end

        -- Check if the mouse click is within the boundaries of NOR Input 1 text
        if x > 50 and x < 150 and y > 425 and y < 455 then
            nor_input1 = not nor_input1 -- Toggle the state of NOR Input 1
        end

        -- Check if the mouse click is within the boundaries of NOR Input 2 text
        if x > 50 and x < 150 and y > 475 and y < 505 then
            nor_input2 = not nor_input2 -- Toggle the state of NOR Input 2
        end
    end
end
return module
