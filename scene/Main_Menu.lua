 -- Main_Menu.lua
 -- By: Michael Johnson
local main_menu = {}

 -- Stores the positions of the buttons
local button_x = {}
local button_y = {}
local button_words = {"Level Select", "  Options", "Quit Game"}

 -- Stores button sizes
local button_width = 400
local button_height = 50

local mousex = 0
local mousey = 0
local button_pressed = false
local button_selected = 0

function main_menu.mousepressed(x, y, button)

     -- Checks to see if left click is used
    if(button == 1) then

         -- Goes through each button
        for i=1,3 do

             -- Checks to see if a button is pressed
            if((x >= button_x[i]) and (x <= (button_x[i] + button_width)) and (y >= button_y[i]) and (y <= (button_y[i] + button_height))) then

                 -- Recognizes a button was pressed and which button it was
                button_pressed = true
                button_selected = i
            end
        end
    end
end

function main_menu.mousereleased(x, y, button)

     -- Checks to see if a button was pressed with left click
    if((button == 1) and (button_pressed == true) ) then

         -- Checks to see if the mouse is still on the button
        if((x >= button_x[button_selected]) and (x <= (button_x[button_selected] + button_width)) 
        and (y >= button_y[button_selected]) and (y <= (button_y[button_selected] + button_height))) then

             -- Checks to see if level select is chosen
            if(button_selected == 1) then
                ChangeScene("Level_Select")
             -- Allows the user to press it, but it doesn't do anything yet
            elseif(button_selected == 2) then
                button_pressed = false
             -- Closes game if quit is chosen
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

function main_menu.keypressed(key)
end

function main_menu.load()

     -- Finds the first button's position
    local x = love.graphics.getWidth()/4
    local y = love.graphics.getHeight()/4

     -- Saves each button position
    for i=1,3 do
        table.insert(button_x, x)
        table.insert(button_y, (y*(i/2)) + 25)
    end

     -- Sets the size of the window
    love.window.setMode(button_width*2, button_width)
end

function main_menu.update(dt)
end

function main_menu.draw()

     -- Prints the title of the game
    love.graphics.setColor(1,1,1)
    love.graphics.print("Keep Talking And No One Gets Electricuted!", love.graphics.getWidth()/12.5, love.graphics.getHeight()/15, 0, 2.5, 2.5)

     -- Draws each button
    for i=1,3 do

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

return main_menu