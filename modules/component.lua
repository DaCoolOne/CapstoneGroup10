local module = {}
local looping_variable=1
local togg_switch=0
local success = 0
local cursor = {}

cursor.x = 0
cursor.y = 0
cursor.value=0.0
local x = 100
local y = 100
local selectedres=0
local circuit = {}
local switch = {}
local resistorslot = {}
local res1 = {}
local res2 = {}
function module.load()
  circuit["v"]=BombInfo.num_batteries
  circuit["i"]=circuit.v/.5
  circuit["r"]=0
  switch["x"]=200
  switch["w"]=45
  switch["y"]=100
  switch["h"]=15    
  resistorslot["x"]=300
  resistorslot["w"]=45
  resistorslot["y"]=200
  resistorslot["h"]=15 
  res1["x"]=50
  res1["w"]=50
  res1["y"]=350
  res1["h"]=15
  res1["r"]=2 
  res2["x"]=150
  res2["w"]=50
  res2["y"]=350
  res2["h"]=15
  res2["r"]=.5  
end
function module.check_values()
  if togg_switch ==1 then
    if circuit.v == circuit.i*circuit.r then
      mark_solved()
      success =1
    end
    if circuit.v ~= circuit.i*circuit.r then
      count_strike()
      togg_switch=0
    end
    togg_switch=0
  end
end
local buttonpressed
function module.getButtonPressed(x,y)
  if (x>=switch.x) and (x<=switch.x+switch.w) and (y>=switch.y) and (y<=switch.y+switch.h) then
    buttonpressed=1
  end
  if (x>=res1.x) and (x<=res1.x+res1.w) and (y>=res1.y) and (y<=res1.y+res1.h) then
    buttonpressed=3
  end
  if (x>=res2.x) and (x<=res2.x+res2.w) and (y>=res2.y) and (y<=res2.y+res2.h) then
    buttonpressed=4
  end
  if (x>=resistorslot.x) and (x<=resistorslot.x+resistorslot.w) and (y>=resistorslot.y) and (y<=resistorslot.y+resistorslot.h) then
    buttonpressed=2
  end
end
function module.mousepressed(x,y)
  if success==0 then
    module.getButtonPressed(x,y)
  end
  
end
function module.mousereleased()
  if (buttonpressed== 1) and (success==0) then
    togg_switch=1
    module.check_values()
  end
  if (buttonpressed== 2) and (success==0) then
    circuit.r = selectedres
  end
  if (buttonpressed== 3) and (success==0) then
    circuit.r = res1.r
  end
  if (buttonpressed== 4) and (success==0) then
    circuit.r = res2.r
  end
    
end
function module.update(dt)
    print(dt)
    x , y = love.mouse.getPosition()
    if x < 1 then
      x=1
    end
    if x > 399 then
      x=399
    end
    if y < 1 then
      y=1
    end
    if y > 399 then
      y=399
    end
    --if love.mousepressed() then
      --cursor.x , cursor.y = love.mouse.getPosition()
      --while love.mousereleased() == false do
        --local g = cursor.x
      --end
    --end
    --love.graphics.setColor( 1, 1, 1, 1 )
    --love.graphics.print("apple",0,40)
    --love.graphics.print(y,0,70)
    --if love.mousepressed(x,y,1) then
      --while looping_variable==1 do
      --love.graphics.print(y,500,70)
      --cursor.x = x
      --cursor.y = y
      --love.graphics.print(x,500,90)
        --if love.mousereleased() then
          --looping_variable=0
        --end
      --end
      --looping_variable=1
    --end
end
function module.drawstrikes()
  
  love.graphics.setColor( 1, 1, 0, 1 )
  if BombInfo.strikes_remaining < 3 then
    love.graphics.setColor(1,0,0,1)
  end
  if success==1 then
    love.graphics.setColor(0,1,0,1)
  end
  love.graphics.rectangle("fill", 380, 380, 10, 10 )
  love.graphics.setColor( 1, 1, 0, 1 )
  if BombInfo.strikes_remaining < 2 then
    love.graphics.setColor(1,0,0,1)
  end
  if success==1 then
    love.graphics.setColor(0,1,0,1)
  end
  love.graphics.rectangle( "fill", 380, 360, 10, 10 )  
end
function module.drawcursor()
  --love.graphics.setColor( 0, 0, 0, 1 )
  --love.graphics.rectangle("fill", x,y, 3, 3)  
end
function module.draw()
  if BombInfo.strikes_remaining >= 0 then
    love.graphics.setColor( 1, 1, 1, 1 )
    love.graphics.rectangle("fill", 0, 0, 400, 400)
    module.drawstrikes()
    module.drawcursor()
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle("line",100,100,200,200) -- circuit path
    love.graphics.setColor(0,0,1,1)
    love.graphics.rectangle("fill",100,200,45,15) -- voltage
    love.graphics.rectangle("fill",200,300,45,15) -- amperage
    love.graphics.rectangle("fill",200,100,45,15) -- switch
    love.graphics.setColor(0,1,0,1)
    love.graphics.rectangle("fill",300,200,45,15) --resistor slot
    love.graphics.setColor(1,0,1,1)
    love.graphics.rectangle("fill",50,350,50,15)
    love.graphics.rectangle("fill",150,350,50,15)
    love.graphics.setColor(1,1,1,1)
    love.graphics.print(tostring("?") .. "V",100,200)
    love.graphics.print(tostring(circuit.i) .. "A",200,300)
    love.graphics.print(tostring(circuit.r) .. "Ohms",300,200)
    love.graphics.print("_/ _",200,100)
    love.graphics.print("2 Ohms",50,350)
    love.graphics.print(".5 Ohms",150,350)
    love.graphics.print(tostring(x), 500,30)
    love.graphics.print(tostring(y), 500,50)
    --love.graphics.print(tostring(cursor.value), 500,70)
    --love.graphics.print(tostring(circuit.r), 500,90)
    --module.selec()
    --module.check_values()
  end
  if success == 1 and BombInfo.strikes_remaining>=0 then 
    --mark_solved()
    --love.graphics.setColor(1,0,0,1)
    --love.graphics.print("A WINNER IS YOU!!!!", 185,120)
  end
  
end
function module.selec()
  if 50<cursor.x and cursor.x<100 and 350<cursor.y and cursor.y<365 then
    cursor.value= 2.0
    cursor.x=0
    cursor.y=0
  end
  if 150<cursor.x and cursor.x<200 and 350<cursor.y and cursor.y<365 then
    cursor.value= 0.5
    cursor.x=0
    cursor.y=0
  end
  if 300<cursor.x and cursor.x<345 and 200<cursor.y and cursor.y<215 and cursor.value ~= circuit.r then
    circuit.r = cursor.value
    cursor.x=0
    cursor.y=0
  end
  if 200<cursor.x and cursor.x<245 and 100<cursor.y and cursor.y<115 then
    togg_switch = 1
    cursor.x=0
    cursor.y=0
  end
end

return module