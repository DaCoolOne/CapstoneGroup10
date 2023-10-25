local component = {}
local togg_switch=0
local tries = 2
local success = 0
local cursor = {}
cursor.x = 0
cursor.y = 0
cursor.value=0.0
local x = 100
local y = 100
local circuit = {}
function component.load()
    circuit["v"]=2.4
    circuit["i"]=4.8
    circuit["r"]=0
end
function component.check_values()
  if togg_switch ==1 then
    if circuit.v == circuit.i*circuit.r then
      success =1
    end
    if circuit.v ~= circuit.i*circuit.r then
      tries = tries-1
      togg_switch=0
    end
    togg_switch=0
  end
end
function component.update(dt)
    print(dt)
    if 1 <= x  and x <= 399 and 1 <= y and y <= 399 then
      if love.keyboard.isDown("right") then
        x = x + 60 * dt
      end
      if love.keyboard.isDown("left") then
        x = x - 60 * dt
      end
      if love.keyboard.isDown("up") then
        y = y - 60 * dt
      end
      if love.keyboard.isDown("down") then
        y = y + 60 * dt
      end
    end
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
    if love.keyboard.isDown("k") then
      cursor.x = x
      cursor.y = y
    end
end
function component.draw()
  if success == 0 and tries >= 0 then
    love.graphics.setColor( 1, 1, 1, 1 )
    love.graphics.rectangle("fill", 0, 0, 400, 400)
    love.graphics.setColor( 0, 0, 0, 1 )
    love.graphics.rectangle("fill", x,y, 3, 3)
    love.graphics.setColor( 1, 1, 0, 1 )
    if tries < 2 then
      love.graphics.setColor(1,0,0,1)
    end
    love.graphics.rectangle("fill", 380, 380, 10, 10 )
    love.graphics.setColor( 1, 1, 0, 1 )
    if tries < 1 then
      love.graphics.setColor(1,0,0,1)
    end
    love.graphics.rectangle( "fill", 380, 360, 10, 10 )
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle("line",100,100,200,200)
    love.graphics.setColor(0,0,1,1)
    love.graphics.rectangle("fill",100,200,45,15)
    love.graphics.rectangle("fill",200,300,45,15)
    love.graphics.rectangle("fill",200,100,45,15)
    love.graphics.setColor(0,1,0,1)
    love.graphics.rectangle("fill",300,200,45,15)
    love.graphics.setColor(1,0,1,1)
    love.graphics.rectangle("fill",50,350,50,15)
    love.graphics.rectangle("fill",150,350,50,15)
    love.graphics.setColor(1,1,1,1)
    love.graphics.print(tostring(circuit.v) .. "V",100,200)
    love.graphics.print(tostring(circuit.i) .. "A",200,300)
    love.graphics.print(tostring(circuit.r) .. "Ohms",300,200)
    love.graphics.print("_/ _",200,100)
    love.graphics.print("2 Ohms",50,350)
    love.graphics.print(".5 Ohms",150,350)
    --love.graphics.print(tostring(cursor.x), 500,30)
    --love.graphics.print(tostring(cursor.y), 500,50)
    --love.graphics.print(tostring(cursor.value), 500,70)
    --love.graphics.print(tostring(circuit.r), 500,90)
    component.selec()
    component.check_values()
  end
  if success == 1 and tries >=0 then 
    love.graphics.setColor(1,0,0,1)
    love.graphics.print("A WINNER IS YOU!!!!", 185,120)
  end
  if tries < 0 then
    love.graphics.setColor(1,0,0,1)
    love.graphics.print("All Your Base Are Belong To Us!", 185,120)
  end
end
function component.selec()
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

return component