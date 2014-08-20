require 'player'
require 'enemy'
require 'collision'

local player = Player.create()

local enemies = (function()
  enemies = {}

  for i=1, 8, 1 do
    enemies[i] = Enemy.create()
  end

  return enemies
end)()

local game_state = 'playing'

function love.draw()
  -- Used for displaying status messages
  local middle_x = love.graphics.getWidth() / 2
  local middle_y = love.graphics.getHeight() / 2

  if game_state == 'playing' then
    player:draw()

    for i, enemy in ipairs(enemies) do
      enemy:draw()
    end

    love.graphics.setColor(255, 255, 0)
  elseif game_state == 'win' then
    love.graphics.setColor(0, 255, 0)
    love.graphics.printf("YOU WIN!", 0, middle_y, 800, 'center')
  else
    love.graphics.setColor(255, 0, 0)
    love.graphics.printf("YOU GOT HIT. GAME OVER.", 0, middle_y, 800, 'center')
  end
end

function love.load()
  love.graphics.setNewFont(28)
end

function love.update(dt)
  player:update(dt)
  
  for i, enemy in ipairs(enemies) do 
    enemy:update(player)

    -- Test enemy -> player collision
    if Collision.create(player, enemy):collide() then
      game_state = 'game_over'
    end

    -- Test enemy -> enemy collision
    for j, other_enemy in ipairs(enemies) do
      if enemy ~= other_enemy then
        Collision.create(enemy, other_enemy):collide()
      end
    end
  end

  removeDeadEnemies()

  if #enemies == 0 then
    game_state = 'win' 
  end
end

function removeDeadEnemies()
  enemies_to_remove = {}

  for i, enemy in ipairs(enemies) do
    if enemy.state == 'dead' then
      enemies_to_remove[i] = enemy
    end
  end

  for i, enemy in ipairs(enemies_to_remove) do
    table.remove(enemies, i)
  end
end

