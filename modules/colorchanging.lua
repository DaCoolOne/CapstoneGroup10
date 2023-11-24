local module = {}

-- Generally speaking, when writing Lua code you should make your variables local unless you have a good reason to make them global. It's just good to avoid cluttering the global namespace.
-- There are exceptions, such as in the case of the info module.
local light_timer = 0
local text, img
local color_change = false

local mousex = 0
local mousey = 0

local button_pressed = false

local complete

-- Module callbacks mirror the names of the callbacks in the love2d framework. So while in love, you would override love.load or love.draw, in a module you override module.load or module.draw
function module.load()
    img = love.graphics.newImage("resources/example.png")

    complete = false
end

function module.update(dt)
end

function module.draw()
    -- This function is called every frame and is where you should draw your module
    if color_change then
        love.graphics.setColor(1, 0, 0)
    else
        love.graphics.setColor(0, 1, 0)
    end
    love.graphics.draw(img, 200, 200, 0, 1, 1, 50, 50)

    love.graphics.setColor(1,1,1)

    love.graphics.circle("line", mousex, mousey, 20)

end

function module.mousepressed(x, y, button)
    if(button == 1) then
        if((x >= 0) and (x <= 400) and (y >= 0) and (y <= 400)) then
            button_pressed = true
            
            if(color_change) then
                color_change = false
            else
                color_change = true
            end
        end
    end
end

function module.mousereleased(x, y, button)
    if(button == 1) then
        button_pressed = false

        if((x >= 0) and (x <= 400) and (y >= 0) and (y <= 400)) then
            mousex = x
            mousey = y
            complete = true
        end
    end
end

function module.mousemoved(x, y)
    if(button_pressed == true) then
        if((x >= 0) and (x <= 400) and (y >= 0) and (y <= 400)) then
            mousex = x
            mousey = y
        end
    end

    mousex = x
    mousey = y
end
-- Some other useful functions:
-- function module.mousepressed
-- function module.mousereleased
-- function module.mousemoved
-- Or any other function which is a valid love2d callback

return module