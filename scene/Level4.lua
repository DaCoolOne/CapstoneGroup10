 -- level4.lua
 -- By: Michael Johnson
local level4 = {}

 -- Modules to load
local MODULE_TO_RENDER_1 = "example_module copy"
local MODULE_TO_RENDER_3 = "colorchanging"
local MODULE_TO_RENDER_4 = "info_module"

 -- Gets modules from files
local module_1 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_4 .. '.lua')()
local module_2 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_1 .. '.lua')()
local module_3 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_3 .. '.lua')()
local module_4 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_1 .. '.lua')()
local module_5 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_3 .. '.lua')()
local module_6 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_3 .. '.lua')()
local module_7 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_1 .. '.lua')()
local module_8 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_1 .. '.lua')()
local module_9 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_1 .. '.lua')()

 -- Stores the modules and their x and y values
local modules = {module_1, module_2, module_3, module_4, module_5, module_6, module_7, module_8, module_9}
local modules_x = {}
local modules_y = {}

 -- Scales of bomb view, module view, and the modules
local bomb_scale = 200
local module_scale = bomb_scale / 75
local drawn_module_scale = bomb_scale / 400

 -- Determines if the user is in a module
local in_module = false

 -- Determines if the user is in exit screen
local in_exit_screen = false

 -- Determines if left click is pressed
local button_pressed = false

 -- Total number of modules in a row and spacing between each one
local max_x = 3
local spacing = 225

 -- Keeps track of the selected modules coordinates
local in_module_x = 0
local in_module_y = 0
local module_index = 0

 -- Finds the current module's x and y
local scalerx = 0
local scalery = 0

 -- Gets the location of a modules location in the modules array
local function getModuleLocation(index) 
    local x = modules_x[index]
    local y = modules_y[index]

    return x, y
end

 -- Checks to see if a value is in an array
local function check_if_taken(index_value, array)
     -- Presumes the value is not in the array
    local in_array = false
    
     -- Goes through the array searching for the value
    for i, array_value in ipairs(array) do

         -- Checks to see if the current value is the value being searched for
        if(array_value == index_value) then 
            in_array = true
        end
    end

     -- Returns if the value was found or not
    return in_array
end

 -- Randomizes the spot of the modules
local function randomizeModules()

     -- Arrays used to hold the randomized locations
    local copy_modules = {}
    local copied_indexes = {}

     -- Randomized index value
    local random_index = 0

     -- Goes through the modules array and randomizes the modules to new spots
    for i, current_module in ipairs(modules) do 
        
         -- Creates a random value from 1 to the number of modules
        random_index = math.random(#modules)

         -- Randomizes the module until it finds a module that has not been randomized yet
        while check_if_taken(random_index, copied_indexes) do
            random_index = math.random(#modules)
        end

         -- Inserts the module into copied array to keep track of new position
        table.insert(copied_indexes, random_index)
        table.insert(copy_modules, modules[random_index])
    end

     -- Places the randomized modules into the module array
    for i, current_module in ipairs(copy_modules) do
        modules[i] = current_module
    end
end

function level4.mousepressed(x, y, button)
     -- Button has been pressed
    button_pressed = true

     -- Checks to see if user is in module view and if mousepressed exists inside of module and not in the exit screen
    if ((in_module == true) and (button == 1) and (modules[module_index].mousepressed ~= nil) and (in_exit_screen == false)) then

         -- Converts module's location to current transform
        local current_module_x, current_module_y = love.graphics.transformPoint(in_module_x, in_module_y)

         -- Calculates module's beginning x and y values
        current_module_x = current_module_x/(module_scale) - (25*scalerx)
        current_module_y = current_module_y/(module_scale) - (25*scalery)

         -- Calculates module's ending x and y values
        local module_scale_x = current_module_x + (bomb_scale*(module_scale)) + 10
        local module_scale_y = current_module_y + (bomb_scale*(module_scale)) + 10

         -- Checks to see if mouse clicked in module
        if((x <= module_scale_x) and (x >= current_module_x)) then
            if((y <= module_scale_y) and (y >= current_module_y)) then

                 -- Sends the mouse coordinates to the module's file
                modules[module_index].mousepressed((x - current_module_x)/(module_scale)/(drawn_module_scale), 
                (y - current_module_y)/(module_scale)/(drawn_module_scale), button)
            end
        end
    end
end

function level4.mousereleased(x, y, button)

    -- Button has been unpressed
    button_pressed = false

     -- Checks to see if user in bomb view and not in the exit screen
    if((in_module == false) and (button == 1) and (in_exit_screen == false)) then

        -- Goes through each module location to see if the user pressed in a module
        for i, current_module in ipairs(modules) do

            -- Checks to see if user selected a module
            if((x <= (modules_x[i] + bomb_scale)) and (x >= modules_x[i]) 
            and (y <= (modules_y[i] + bomb_scale)) and (y >= modules_y[i])) then

                    -- Puts the user into a module
                   in_module = true

                    -- Records the module's array position
                   module_index = i

                    -- Stores the module's x and y locations
                   in_module_x, in_module_y = getModuleLocation(i)
            end
        end
    
     -- Checks to see if it is zoomed into module, left mouse is selected, mousereleased exists in the module, and not in the exit screen
    elseif ((in_module == true) and (button == 1) and 
    (modules[module_index].mousereleased ~= nil) and (in_exit_screen == false)) then

         -- Converts module's location to current transform
        local current_module_x, current_module_y = love.graphics.transformPoint(in_module_x, in_module_y)

         -- Calculates module's beginning x and y values
        current_module_x = current_module_x/(module_scale) - (25*scalerx)
        current_module_y = current_module_y/(module_scale) - (25*scalery)

         -- Calculates module's ending x and y values
        local module_scale_x = current_module_x + (bomb_scale*(module_scale)) + 10
        local module_scale_y = current_module_y + (bomb_scale*(module_scale)) + 10

         -- Checks to see if mouse clicked in module
        if((x <= module_scale_x) and (x >= current_module_x) and (y <= module_scale_y) and (y >= current_module_y)) then

                -- Sends the mouse coordinates to the module's file
               modules[module_index].mousereleased((x - current_module_x)/(module_scale)/(drawn_module_scale), 
               (y - current_module_y)/(module_scale)/(drawn_module_scale), button)
        end

     -- Checks to see if the user is in the exit screen
    elseif((button == 1) and (in_exit_screen == true)) then

         -- Switches back to the main menu if user presses yes
        if((x >= love.graphics.getWidth()/5) and (x <= (love.graphics.getWidth()/5 + 200))
         and (y >= love.graphics.getHeight()/3) and (y <= (love.graphics.getHeight()/3 + 50))) then
            
             -- Restarts game back to main menu to save RAM
            love.event.quit("restart")

         -- Goes back to the bomb if the user presses no
        elseif((x >= (love.graphics.getWidth()/5 + spacing)) and (x <= (love.graphics.getWidth()/5 + 200 + spacing))
         and (y >= love.graphics.getHeight()/3) and (y <= (love.graphics.getHeight()/3 + 50))) then
            in_exit_screen = false
        end
    end
end

function level4.mousemoved(x, y, dx, dy)

     -- Checks to see if left mouse is pressed, module is zoomed in, mousemoved exists in the module, and not in the exit screen
    if((button_pressed == true) and (in_module == true) and (modules[module_index].mousemoved ~= nil) and (in_exit_screen == false)) then
         -- Converts module's location to current transform
        local current_module_x, current_module_y = love.graphics.transformPoint(in_module_x, in_module_y)

         -- Calculates module's beginning x and y values
        current_module_x = current_module_x/(module_scale) - (25*scalerx)
        current_module_y = current_module_y/(module_scale) - (25*scalery)

         -- Calculates module's ending x and y values
        local module_scale_x = current_module_x + (bomb_scale*(module_scale)) + 10
        local module_scale_y = current_module_y + (bomb_scale*(module_scale)) + 10

         -- Checks to see if mouse clicked in module
        if((x <= module_scale_x) and (x >= current_module_x) and (y <= module_scale_y) and (y >= current_module_y)) then

             -- Sends the mouse coordinates to the module's file
            modules[module_index].mousemoved((x - current_module_x)/(module_scale)/(drawn_module_scale), (y - current_module_y)/(module_scale)/(drawn_module_scale), 
            dx/(module_scale)/(drawn_module_scale), dy/(module_scale)/(drawn_module_scale))
        end
    end
end

 -- Overrides keypressed
function level4.keypressed(key)

     -- Turns on exit screen if user presses escape in bomb view
    if((key == "escape") and not in_module) then
        in_exit_screen = true
    
     -- Returns to bomb view if escape is pressed inside of module
    elseif((key == "escape") and in_module) then
        in_module = false
    
     -- Activates keypressed in the module if it exists
    elseif(in_module and (modules[module_index].keypressed ~= nil)) then
        modules[module_index].keypressed(key)
    end
end

function level4.load()

     -- Randomizes the location of the modules
    randomizeModules()

     -- Calls each module's load function
    for i, current_module in ipairs(modules) do
        current_module.load()
    end

     -- Tracks if the modules should go to the next line
    local number_of_modules_x = 0
    local number_of_modules_y = 0

     -- Finds the x and y values of each module
    for i, current_module in ipairs(modules) do

         -- Checks to see if the next module should go to next row
        if (number_of_modules_x == max_x) then
            number_of_modules_y = number_of_modules_y + 1
            number_of_modules_x = number_of_modules_x - max_x
        end

         -- Stores the current modules x and y value
        table.insert(modules_x, ((spacing * number_of_modules_x) + 25))
        table.insert(modules_y, ((spacing * number_of_modules_y) + 25))

         -- Goes to the next module
        number_of_modules_x = number_of_modules_x + 1
    end

     -- Sets dimensions of window
    love.window.setMode(modules_x[max_x] + spacing - 15, modules_y[#modules_y] + spacing - 15)
end

function level4.update(dt)

     -- Calls each module's update function
    for i, current_module in ipairs(modules) do
        current_module.update(dt)
    end

     -- Ends the game if the player uses up all their strikes or time reaches 0 (-1 used to show 0:00 to player)
    if((BombInfo.strikes_remaining == 0) or (BombInfo.seconds_remaining == -1) or (BombInfo.modules_solved == #modules)) then
        ChangeScene("Win_Lose_Screen")
    end
end

function level4.draw()

     -- Stores the location of the bomb view
    love.graphics.push()

        -- Stores the transform throughout draw function
    local transform

        -- Calculates and moves to a module's transform if a module is selected
    if(in_module == true) then

        -- Calculates the x and y needed for the module selected
        scalerx = (module_index - 1) % max_x
        scalery = math.floor((module_index - 1) / max_x)

        -- Creates a new transform at the module selected and at a scale of module_scale
        transform = love.math.newTransform((-in_module_x - (scalerx*45)), (-in_module_y - (scalery*45)), 0, module_scale, module_scale)

        -- Applies the transform to zoom into the module
        love.graphics.applyTransform(transform)
    end

    -- Calls the draw function of each module at their corresponding location
    for i, current_module in ipairs(modules) do

            -- Stores current location
        love.graphics.push()

            -- Gets the current module's x and y        
        local x, y = getModuleLocation(i)

            -- Finds x and y in with respect to new transform and scales them down
        if(in_module == true) then
            -- Finds the x and y of each module with respect to the chosen module's location
            x, y = transform:transformPoint(x, y)

            -- Scales the x and y of of each module to fit the new scale
            x = x/(module_scale)
            y = y/(module_scale)
        end

            -- Moves to the module's location
        love.graphics.translate(x, y)

            -- Sets color of module lines to white
        love.graphics.setColor(1,1,1)

        -- Creates an outline of the module
        love.graphics.rectangle("line", 0, 0, bomb_scale, bomb_scale)

        -- Scales the module to fit the outline
        love.graphics.scale(drawn_module_scale, drawn_module_scale)

        -- Calls the module's draw function
        current_module.draw()

        -- Returns to the stored location
        love.graphics.pop()
    end

     -- Puts the user into an exit screen
    if(in_exit_screen == true) then
        -- Creates the background of exit screen
       love.graphics.setColor(0.5,0.5,0.5)
       love.graphics.rectangle("fill", love.graphics.getWidth()/6, love.graphics.getHeight()/6, modules_x[max_x], modules_y[#modules_y])

        -- Creates text for exit screen
       love.graphics.setColor(0,0,0)
       love.graphics.print("Do you want to exit back to the main menu?", love.graphics.getWidth()/4.5, love.graphics.getHeight()/4.5, 0, 1.5)

        -- Creates buttons for exit screen
       love.graphics.setColor(1,1,1)
       love.graphics.rectangle("fill", love.graphics.getWidth()/5, love.graphics.getHeight()/3, 200, 50)
       love.graphics.rectangle("fill", (love.graphics.getWidth()/5 + spacing), love.graphics.getHeight()/3, 200, 50)

        -- Creates text for buttons
       love.graphics.setColor(0,0,0)
       love.graphics.print("Yes", (love.graphics.getWidth()/5 + 85), (love.graphics.getHeight()/3 + 12.5), 0, 1.5)
       love.graphics.print("No", (love.graphics.getWidth()/5 + spacing + 85), (love.graphics.getHeight()/3 + 12.5), 0, 1.5)
   end

     -- Returns to the stored location
    love.graphics.pop()
end

return level4