require 'lib.game'
require 'lib.player'
require 'lib.enemy'
require 'lib.spawner'
require 'lib.collision'
require 'lib.menu'

local game = Game.create()
local menu = Menu.create()

function love.draw()
  -- Used for displaying status messages
  local middle_x = love.graphics.getWidth() / 2
  local middle_y = love.graphics.getHeight() / 2

  if game.state == 'playing' then
    game.player:draw()
    game.spawner:draw()

    for i, enemy in ipairs(game.enemies) do
      enemy:draw()
    end

    love.graphics.setColor(255, 255, 0)
  elseif game.state == 'menu' then
    menu:draw()
  elseif game.state == 'win' then
    love.graphics.printf("Press [Enter] to start a new game.", 0, 100, 800, 'center')
    love.graphics.setColor(0, 255, 0)
    love.graphics.printf("YOU WIN!", 0, middle_y, 800, 'center')
  else
    love.graphics.printf("Press [Enter] to start a new game.", 0, 100, 800, 'center')
    love.graphics.setColor(255, 0, 0)
    love.graphics.printf("YOU GOT HIT. GAME OVER.", 0, middle_y, 800, 'center')
  end
end

function love.load()
  love.graphics.setNewFont(28)
  game.state = 'menu'
end

function love.update(dt)
  if game.state == 'menu' then
    menu.game = game
    menu:update()
    return
  end

  -- Handle new game
  if love.keyboard.isDown("return") and (game.state ~= 'playing' and game.state ~= 'menu') then
    game:reset()
  end

  game.spawner:update(dt)

  game:removeDeadEnemies()

  game:tryToSpawnEnemies(dt)

  game.player:update(dt)


  for i, enemy in ipairs(game.enemies) do
    enemy:update(game.player)

    -- Test enemy -> player collision
    if Collision.create(game.player, enemy):collide() then
      game.state = 'game_over'
      game.enemies = {}
    end

    -- Test enemy -> enemy collision
    for j, other_enemy in ipairs(game.enemies) do
      if i ~= j then
        Collision.create(enemy, other_enemy):collide()
      end
    end
  end

  if #game.enemies == 0 and game.state ~= 'game_over' then
    game.state = 'win'
  end
end


