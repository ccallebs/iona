require 'game'
require 'player'
require 'enemy'
require 'collision'

local game = Game.create()

function love.draw()
  -- Used for displaying status messages
  local middle_x = love.graphics.getWidth() / 2
  local middle_y = love.graphics.getHeight() / 2

  if game.state == 'playing' then
    game.player:draw()

    for i, enemy in ipairs(game.enemies) do
      enemy:draw()
    end

    love.graphics.setColor(255, 255, 0)
  elseif game.state == 'win' then
    love.graphics.setColor(0, 255, 0)
    love.graphics.printf("YOU WIN!", 0, middle_y, 800, 'center')
  else
    love.graphics.setColor(255, 0, 0)
    love.graphics.printf("YOU GOT HIT. GAME OVER.", 0, middle_y, 800, 'center')
  end
end

function love.load()
  love.graphics.setNewFont(28)
  game:reset()
end

function love.update(dt)
  game.player:update(dt)
  
  for i, enemy in ipairs(game.enemies) do 
    enemy:update(game.player)

    -- Test enemy -> player collision
    if Collision.create(game.player, enemy):collide() then
      game.state = 'game_over'
    end

    -- Test enemy -> enemy collision
    for j, other_enemy in ipairs(game.enemies) do
      if enemy ~= other_enemy then
        Collision.create(enemy, other_enemy):collide()
      end
    end
  end

  game:removeDeadEnemies()

  if #game.enemies == 0 and game.state ~= 'game_over' then
    game.state = 'win' 
  end
end


