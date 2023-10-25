local module = {} 

local input1 = false
local input2 = false
local output = false
local RED = {1, 0, 0} -- Red
local GREEN = {0, 1, 0} -- Green
local BLUE = {0, 0, 1} -- Blue
local CLEAR = {0.5, 0.5, 0.5} -- Clear (background color)
local BLACK = {0, 0, 0} -- Black
local font
local utf8 = require("utf8")
local inputText = "" -- To store user input
local showCursor = true
local inputFont = love.graphics.newFont(24)

-- *Todo: Adjust game so that everything is centered again
-- *Todo: Make a question mark inside the box 
-- *Todo: Make a line that connects to the inputs  
-- *Todo: Change the inputText -> Buttons  
-- *Todo: Change the output button from a button to a lightbulb  
    -- *Todo: If possible make it adaptive so that when it is correct then you can get a bright light  



function module.load()
    local text = ""
    -- *enable key repeat so backspace can be held down to trigger love.keypressed multiple times.
    love.keyboard.setKeyRepeat(true)

    -- *set the font size and all fonts will be rendered to this rule
    font = love.graphics.newFont(24)
    love.graphics.setFont(font)

    -- *Create a font for the input field
    local inputFont = love.graphics.newFont(24)

end

-- Handle Updating the Window --
function module.update()
     -- *Implement the AND gate logic
     local andGateOutput = input1 and input2
    
     -- *Check if the user entered "AND" and update the output
     if inputText:lower() == "and" then
         output = true
     else
         output = andGateOutput
     end
end

--* Handle Drawing inside the window --
function module.draw()
    love.graphics.clear(CLEAR)

    -- *Display INPUT switches that are text 
    love.graphics.setColor(RED)
    love.graphics.print("Input 1: " .. (input1 and 1 or 0), 50, 50)
    love.graphics.setColor(GREEN)
    love.graphics.print("Input 2: " .. (input2 and 1 or 0), 50, 100)


    -- *Display the LINE between the gate and the light
    love.graphics.setColor(BLACK)
    love.graphics.line(50, 100, 300, 100)

    -- *Display the AND gate
    love.graphics.setColor(BLUE)
    love.graphics.rectangle("line", 300, 50, 100, 100)

    -- *Display the LINE between the gate and the light
    love.graphics.setColor(BLACK)
    love.graphics.line(400, 100, 500, 100)

    -- *Display the LED
    love.graphics.setColor(output and 0 or 1, output and 1 or 0, 0)
    love.graphics.circle("fill", 500, 105, 20)

    -- *Draw the question
    love.graphics.setColor(BLACK)
    love.graphics.printf("What logic gate is it?", 530, 35, 255, "right")

    --* Draw the text box background
    love.graphics.setColor(BLACK)
    love.graphics.rectangle("line", 550, 70, 200, 70)

    -- *Render the text input field
    love.graphics.setFont(inputFont)
    love.graphics.setColor(BLACK)
    love.graphics.print(inputText .. (showCursor and "|" or ""), 560, 80)
    love.graphics.setFont(font)
end

--* Handle Mouse Clicks --
function module.mousepressed(x, y, button)
    if button == 1 then
        if x > 50 and x < 150 and y > 50 and y < 80 then
            input1 = not input1
        elseif x > 50 and x < 150 and y > 100 and y < 130 then
            input2 = not input2
        end
    end
end

-- *Handle Key Strokes & Validate Input --
function module.keypressed(key)
    if key == "backspace" then
        -- *Handle backspace to remove the last character from inputText
        inputText = inputText:sub(1, -2)
    elseif key == "return" then
        --* Check the input text against your desired logic
        if inputText:lower() == "and" then
            print("Correct logic!") -- Modify this to your desired logic outcome
        else
            print("Incorrect logic.") -- Modify this to your desired logic outcome
        end

        -- *Clear the input field after checking
        inputText = ""
    end
end

--* This collects input from the User --
function module.textinput(t)
    --* Only allow text input when the input field is clicked
    local inputX, inputY, inputWidth, inputHeight = 550, 70, 200, 70
    local x, y = love.mouse.getPosition()
    if x >= inputX and x <= inputX + inputWidth and y >= inputY and y <= inputY + inputHeight then
        inputText = inputText .. t
    end
end

return module