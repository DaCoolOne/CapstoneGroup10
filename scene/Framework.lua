 -- framework.lua
 -- By: Michael Johnson
local framework = {}

-- Optional: Translate interactions between modules and framework
    -- Module.load
    -- Module.update
    -- zooming
    -- Go through events
        -- Mouse events
        -- Scroll events
        -- DONT OVERRUN .run
        -- etc.

-- Super simple scene to draw modules as they will appear on the bomb.
-- To change which module is being rendered, change this variable
-- local MODULE_TO_RENDER = "KVL_KCL"
local MODULE_TO_RENDER_1 = "example_module"
local MODULE_TO_RENDER_2 = "KVL_KCL"
local MODULE_TO_RENDER_3 = "component"
local MODULE_TO_RENDER_4 = "binary_decimal_module"


 -- Gets modules from files
local module_1 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_1 .. '.lua')()
local module_2 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_2 .. '.lua')()
local module_3 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_3 .. '.lua')()
local module_4 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_4 .. '.lua')()
local module_5 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_1 .. '.lua')()
local module_6 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_2 .. '.lua')()
local module_7 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_3 .. '.lua')()
local module_8 = love.filesystem.load("modules/" .. MODULE_TO_RENDER_4 .. '.lua')()

 -- Stores the modules and their x and y values
local modules = {module_1, module_2, module_3, module_4, module_5, module_6, module_7, module_8}
local modules_x = {}
local modules_y = {}

 -- Stores 
local scale = 200

 -- Determines if the user is in a module
local in_module = false

 -- Keeps track of the selected modules coordinates
local in_module_x = 0
local in_module_y = 0
local module_index = 0

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

function framework.mousepressed(x, y, button)

     -- Checks to see if the user is in a module
    if((in_module == false) and (button == 1)) then

         -- Goes through each module location to see if the user pressed in a module
        for i, current_module in ipairs(modules) do
             -- Checks to see if the user pressed in a module's x values
            if((x <= (modules_x[i] + scale)) and (x > modules_x[i])) then
                 -- Checks to see if the user pressed in a module's y values
                if((y <= (modules_y[i] + scale)) and (y > modules_y[i])) then
                     -- Puts the user into a module
                    in_module = true

                    module_index = i

                     -- Stores the module's x and y locations
                    in_module_x, in_module_y = getModuleLocation(i)
                end
            end
        end
    end
end

 -- Overrides keypressed
function framework.keypressed(key)

     -- Checks to see if the escape key is pressed and the user is in a module
    if((key == "escape") and in_module) then

         -- Returns to bomb scene
        in_module = false
    end
end

function framework.load()

     -- Seeds the randomizer with the operating system's time
    math.randomseed(os.time())

     -- Randomizes the location of the modules
    randomizeModules()

     -- Calls each module's load function
    for i, current_module in ipairs(modules) do
        current_module.load()
    end

    -- Stores the module spacing
    local width_spacing = 225
    local height_spacing = 225

     -- Tracks if the modules should go to the next line
    local number_of_modules_x = 0
    local number_of_modules_y = 0

     -- Sets the total number of modules in a row
    local max_x = 3

     -- Finds the x and y values of each module
    for i, current_module in ipairs(modules) do

         -- Checks to see if the next module should go to next row
        if number_of_modules_x == max_x then
            number_of_modules_y = number_of_modules_y + 1
            number_of_modules_x = number_of_modules_x - max_x
        end

         -- Stores the current modules x and y value
        table.insert(modules_x, ((width_spacing * number_of_modules_x) + 25))
        table.insert(modules_y, ((height_spacing * number_of_modules_y) + 25))

         -- Goes to the next module
        number_of_modules_x = number_of_modules_x + 1
    end
end

function framework.update(dt)

     -- Calls each module's update function
    for i, current_module in ipairs(modules) do
        current_module.update(dt)
    end
end

function framework.draw()

     -- Stores the location of the bomb view
    love.graphics.push()

     -- Checks to see if the user has selected a module
    if(in_module == true) then
        love.graphics.push()

         -- Moves to selected module
        love.graphics.translate(in_module_x, in_module_y)

        modules[module_index].draw()

        love.graphics.pop()
     -- Calls the draw function of each module at their corresponding location
    else
        for i, current_module in ipairs(modules) do

         -- Stores current location
        love.graphics.push()

         -- Gets the current module's x and y
        local x, y = getModuleLocation(i)

         -- Moves to the module's location
        love.graphics.translate(x, y)

         -- Creates an outline of the module
        love.graphics.rectangle("line", 0, 0, scale, scale)

         -- Scales the module to fit the outline
        love.graphics.scale(scale / 400, scale / 400)

         -- Calls the module's draw function
        current_module.draw()

         -- Returns to the stored location
        love.graphics.pop()
        end
    end

     -- Returns to the stored location
    love.graphics.pop()
end

return framework