 -- Win_Lose_Screen.lua
 -- By: Michael Johnson
 local win_lose_screen = {}

 -- Stores the positions of the buttons
local button_x = {}
local button_y = {}
local button_words = {"Main Menu", "Quit Game"}

 -- Stores button sizes
local button_width = 400
local button_height = 50

local mousex = 0
local mousey = 0
local button_pressed = false
local button_selected = 0

function win_lose_screen.mousepressed(x, y, button)

     -- Checks to see if left click is used
    if(button == 1) then

         -- Goes through each button
        for i=1,2 do

             -- Checks to see if a button is pressed
            if((x >= button_x[i]) and (x <= (button_x[i] + button_width)) and (y >= button_y[i]) and (y <= (button_y[i] + button_height))) then

                 -- Recognizes a button was pressed and which button it was
                button_pressed = true
                button_selected = i
            end
        end
    end
end

function win_lose_screen.mousereleased(x, y, button)

     -- Checks to see if a button was pressed with left click
    if((button == 1) and (button_pressed == true) ) then

         -- Checks to see if the mouse is still on the button
        if((x >= button_x[button_selected]) and (x <= (button_x[button_selected] + button_width)) 
        and (y >= button_y[button_selected]) and (y <= (button_y[button_selected] + button_height))) then

             -- Checks to see if level select is chosen
            if(button_selected == 1) then
                ChangeScene("Main_Menu")
            else
                 -- Quits the game and Love2D
                love.event.quit()
            end
        
         -- Resets select if mouse is not over button when released
        else
            button_pressed = false
        end
    end
end

function win_lose_screen.load()

     -- Finds the first button's position
    local x = love.graphics.getWidth()/5
    local y = love.graphics.getHeight()/2

     -- Saves each button position
    for i=1,2 do
        table.insert(button_x, x)
        table.insert(button_y, (y*(i/4) + y/1.5))
    end
end

function win_lose_screen.update(dt)
end

function win_lose_screen.draw()

     -- Gets the X and Y of the window
    local window_x = love.graphics.getWidth()
    local window_y = love.graphics.getHeight()

     -- Prints the win or lose message
    love.graphics.setColor(1,1,1)
    if((BombInfo.strikes_remaining == 0) or (BombInfo.seconds_remaining == -1)) then
        love.graphics.print("Sorry, You Lose.", window_x/3.5, window_y/3, 0, 3)
    else
        love.graphics.print("Congratulations, You Win!", window_x/7, window_y/3, 0, 3)
    end

     -- Draws each button
    for i=1,2 do

         -- Switches the color of the button if it is pressed
        if((button_pressed == true) and (i == button_selected)) then
            love.graphics.setColor(0, 1, 0)
        else
            love.graphics.setColor(1,1,1)
        end

         -- Creates the button on screen
        love.graphics.rectangle("fill", button_x[i], button_y[i], button_width, button_height)

         -- Creates the text for the button
        love.graphics.setColor(1,0,0)
        love.graphics.print(button_words[i], button_x[i] + (button_width/3), button_y[i], 0, 2, 2)
    end
end

return win_lose_screen