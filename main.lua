require 'player'
require 'enemy'

local player = Player.create()

local enemies = (function()
  enemies = {}

  for i=1, 5, 1 do
    enemies[i] = Enemy.create()
  end

  return enemies
end)()

function love.draw()
  player:draw()

  for i, enemy in ipairs(enemies) do
    enemy:draw()
  end
end

function love.load()
end

function love.update(dt)
  player:update(dt)
  
  for i, enemy in ipairs(enemies) do 
    enemy:update(player)
  end
end

