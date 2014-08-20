require 'player'
require 'enemy'
require 'collision'

local player = Player.create()

local enemies = (function()
  enemies = {}

  for i=1, 2, 1 do
    enemies[i] = Enemy.create()
  end

  return enemies
end)()

local collision_count = 0

local game_state = 'playing'

function love.draw()
  if game_state == 'playing' then
    player:draw()

    for i, enemy in ipairs(enemies) do
      enemy:draw()
    end

    love.graphics.setColor(255, 255, 0)
  else
    love.graphics.setColor(255, 0, 0)
    love.graphics.print("YOU GOT HIT. GAME OVER.", 100, 100)
  end
end

function love.load()
  love.graphics.setNewFont(28)
end

function love.update(dt)
  player:update(dt)
  
  for i, enemy in ipairs(enemies) do 
    enemy:update(player)

    -- Test enemy collision
    if Collision.create(player, enemy):collide() then
      collision_count = collision_count + 1
      game_state = 'game_over'
    end
  end
end

