require "menu"
local tilesetImage
local tileQuads = {}
local tileSize = 32
local gravity = 600
local px
local speed
speed = 0.5

local mapa_config = {
  mapaSize_x = 550,
  mapaSize_y = 33,
  mapaDisplay_x = 121,
  mapaDisplay_y = 33
}

local camera = {
  pos_x = 1,
  pos_y = 1,
  speed = 300
}

local player = {
  image = love.graphics.newImage("mario.png"),
  pos_x = ((mapa_config.mapaDisplay_x / 2) + 10),
  pos_y = 450,
  jump = false,
  jumpForce = 425,
  jumpTime = 0
}

local mapa = {}

function LoadMap (filename) -- Le o conteúdo do arquivo para a matriz
local file = io.open(filename)
local i = 1
for line in file:lines() do
  mapa[i] = {}
for j=1, #line, 1 do
  mapa[i][j] = line:sub(j,j)
end
i = i + 1
end
file:close()
end

function love.load()
  medium = love.graphics.newFont (125)
  
love.window.setMode(1600,900,{resizable=true})
LoadMap("Map.txt")
lava = love.graphics.newImage("lava.png")
stone = love.graphics.newImage ("stone.png")
lavas  = love.graphics.newImage ("lava2.png")
vulcao = love.graphics.newImage ("vulcao.png")
chao = love.graphics.newImage ("chao.png")
chaos = love.graphics.newImage ("chaofundo.png")
arb = love.graphics.newImage ("arbusto.png")
caixa = love.graphics.newImage ("caixa.png")
jungle = love.graphics.newImage ("jungle.png")
book = love.graphics.newImage ("book.png")
books = love.graphics.newImage ("bookshelf.png")
ground = love.graphics.newImage ("ground.png")
floor = love.graphics.newImage ("floor2.png")
door = love.graphics.newImage ("door.png")
metal = love.graphics.newImage ("metal.png")
metal2 = love.graphics.newImage ("metal2.png")
ship = love.graphics.newImage ("ship1.png")
ship2 = love.graphics.newImage ("ship2.png")
ship3 = love.graphics.newImage ("ship3.png")
futuro = love.graphics.newImage ("futuro.png")
end

function love.draw()
 
  offset_x = math.floor(camera.pos_x%tileSize)
  first_tile_x=math.floor(camera.pos_x/tileSize)   
 
  print(first_tile_x)
  if(first_tile_x>=50 and first_tile_x<202) then
    love.graphics.draw(jungle)
    speed=1.0
  elseif(first_tile_x>=202 and first_tile_x<320) then
    love.graphics.draw(vulcao)
    speed=1.3
  elseif (first_tile_x>=320) then
      love.graphics.draw(futuro)
      speed=1.5
  end
for i=1, mapa_config.mapaDisplay_y, 1 do  
for j=1, mapa_config.mapaDisplay_x, 1 do
  
  if (mapa[i][first_tile_x + j] == "P") then
    love.graphics.draw (stone,((j-1)* tileSize) - offset_x ,((i-1)* tileSize))
  elseif (mapa[i][first_tile_x + j] == "A") then
    love.graphics.draw (lava,((j-1)* tileSize) - offset_x ,((i-1)* tileSize))
  elseif (mapa[i][first_tile_x + j] == "G") then
    love.graphics.draw (lavas,((j-1)* tileSize) - offset_x ,((i-1)* tileSize))
  elseif (mapa[i][first_tile_x + j] == "g") then
    love.graphics.draw (chao,((j-1)* tileSize) - offset_x ,((i-1)* tileSize))
  elseif (mapa[i][first_tile_x + j] == "D") then
    love.graphics.draw (chaos,((j-1)* tileSize) - offset_x ,((i-1)* tileSize))
  elseif (mapa[i][first_tile_x + j] == "c") then
    love.graphics.draw (caixa,((j-1)* tileSize) - offset_x ,((i-1)* tileSize))
  elseif (mapa[i][first_tile_x + j] == "a") then
    love.graphics.draw (arb,((j-1)* tileSize) - offset_x ,((i-1)* tileSize))
  elseif (mapa[i][first_tile_x + j] == "e") then
    love.graphics.draw (ground,((j-1)* tileSize) - offset_x ,((i-1)* tileSize))
  elseif (mapa[i][first_tile_x + j] == "f") then
    love.graphics.draw (floor,((j-1)* tileSize) - offset_x ,((i-1)* tileSize))
  elseif (mapa[i][first_tile_x + j] == "b") then
    love.graphics.draw (books,((j-1)* tileSize) - offset_x ,((i-1)* tileSize))
  elseif (mapa[i][first_tile_x + j] == "B") then
    love.graphics.draw (book,((j-1)* tileSize) - offset_x ,((i-1)* tileSize))
  elseif (mapa[i][first_tile_x + j] == "d") then
    love.graphics.draw (door,((j-1)* tileSize) - offset_x ,((i-1)* tileSize))
  elseif (mapa[i][first_tile_x + j] == "m") then
    love.graphics.draw (metal,((j-1)* tileSize) - offset_x ,((i-1)* tileSize)) 
  elseif (mapa[i][first_tile_x + j] == "M") then
    love.graphics.draw (metal2,((j-1)* tileSize) - offset_x ,((i-1)* tileSize))
  elseif (mapa[i][first_tile_x + j] == "s") then
    love.graphics.draw (ship,((j-1)* tileSize) - offset_x ,((i-1)* tileSize))
  elseif (mapa[i][first_tile_x + j] == "S") then
    love.graphics.draw (ship2,((j-1)* tileSize) - offset_x ,((i-1)* tileSize))
  elseif (mapa[i][first_tile_x + j] == "O") then
    love.graphics.draw (ship3,((j-1)* tileSize) - offset_x ,((i-1)* tileSize))
  end
  
end
end

  love.graphics.draw(player.image, player.pos_x + 80, player.pos_y - 2, 0, 0.1, 0.1)

if player.pos_x <= - 120 then
  --love.graphics.setBackgroundColor ( 0,0,0)
  love.graphics.setColor (255,0,0)
  love.graphics.setFont (medium)
  love.graphics.setColor (255,255,255)
  love.graphics.print ("THE END", 500, 350)
  love.graphics.setColor (255,0,0)
   
end
 end

function love.update (dt) 
  
  px = 1
  px = px * 2
  
  camera.pos_x = camera.pos_x + (camera.speed * dt + 0.1 + px) * speed
 
      
  player_tile_x = math.floor((camera.pos_x + player.pos_x + (tileSize / 2)) / tileSize)
  player_tile_xr = math.floor((camera.pos_x + player.pos_x + tileSize) / tileSize)
  player_tile_xl = math.floor((camera.pos_x + player.pos_x) / tileSize)
  player_tile_y = math.floor((player.pos_y) / tileSize)
  player_tile_yr = math.floor((player.pos_y + (tileSize / 1.5)) / tileSize)
  
  local a = mapa[player_tile_yr + 2][player_tile_xr + 4]
if (a == "b" or a == "B" or a == "P" or a == "a" or a == "g" or a == "D" or a == "c" or a == "m" or a == "M" or a == "s" or a == "S" or a == "O") then
  player.pos_x = player.pos_x - (100 * dt) * (2.4 + (5*speed))
  end
  --mapa[player_tile_yr + 2][player_tile_xr + 4] = "A"
  if love.keyboard.isDown("right") and (mapa[player_tile_yr + 2][player_tile_xr + 4] == "X") then
  player.pos_x = player.pos_x + (300 * dt)
end

if love.keyboard.isDown("right") and (mapa[player_tile_yr + 2][player_tile_xr + 4] == "f") then
  player.pos_x = player.pos_x + (300 * dt)
end

if love.keyboard.isDown("right") and (mapa[player_tile_yr + 2][player_tile_xr + 4] == "d") then
  player.pos_x = player.pos_x + (300 * dt)
end

if love.keyboard.isDown("right") and (mapa[player_tile_yr + 2][player_tile_xr + 4] == "Z") then
  player.pos_x = player.pos_x + (300 * dt)
end

   --mapa[player_tile_yr + 2][player_tile_xl +  3 ]  = "A" 
  if love.keyboard.isDown("left") and (mapa[player_tile_yr + 2][player_tile_xl + 3] == "X") then
  player.pos_x = player.pos_x - (300 * dt)
end

if love.keyboard.isDown("left") and (mapa[player_tile_yr + 2][player_tile_xr + 4] == "f") then
  player.pos_x = player.pos_x - (300 * dt)
end
if love.keyboard.isDown("left") and (mapa[player_tile_yr + 2][player_tile_xr + 4] == "d") then
  player.pos_x = player.pos_x - (300 * dt)
end

if love.keyboard.isDown("left") and (mapa[player_tile_yr + 2][player_tile_xr + 4] == "Z") then
  player.pos_x = player.pos_x - (300 * dt)
end

if player.pos_x < -120 then
  player.pos_x = - 130
  end
  
  if player.pos_x < -115 then
    camera.pos_x = camera.pos_x + (camera.speed * dt + 0.1 + px * speed) / 70
  end
  
  if player.pos_x > 1550 then
    player.pos_x = 1550
    end
  
  --mapa[player_tile_y + 3][player_tile_x + 3] = "A"
  if love.keyboard.isDown("up") and player.jump == false then
    if player_tile_y + 3 < mapa_config. mapaSize_y then
      if (mapa[player_tile_y + 3][player_tile_x + 3] ~= "X") and (mapa[player_tile_y + 3][player_tile_x + 3] ~= "G") and (mapa[player_tile_y + 3][player_tile_x + 3] ~= "A") and (mapa[player_tile_y + 3][player_tile_x + 3] ~= "f") and (mapa[player_tile_y + 3][player_tile_x + 3] ~= "d") and (mapa[player_tile_y + 3][player_tile_x + 3] ~= "Z")  then
        player.jump = true      
      end
    end   
  end  
 
    
  if player.jump then
    player.jumpTime = player.jumpTime + dt 
    player.pos_y = player.pos_y - ((player.jumpForce + 600) * dt) 
    player.jumpForce = player.jumpForce - (3 * dt)
    if player.jumpTime > 0.5 then
      player.jump = false 
      player.jumpTime = 0
    end
  end 
  
  if player_tile_y + 3 < mapa_config. mapaSize_y then
    if (mapa[player_tile_y + 3][player_tile_x + 4] == "X") or (mapa[player_tile_y + 3][player_tile_x + 4] == "A") or (mapa[player_tile_y + 3][player_tile_x + 4] == "G") or (mapa[player_tile_y + 3][player_tile_x + 4] == "f") or (mapa[player_tile_y + 3][player_tile_x + 4] == "d") or (mapa[player_tile_y + 3][player_tile_x + 4] == "Z")  then
      player.pos_y = player.pos_y + (gravity * dt)
    end
    if player_tile_y and player_tile_x == "A" then
      player.pos_y = player.pos_y - (gravity * dt)
      end
    if camera.pos_x < 0 then
    camera.pos_x = 0
  end  
end
end