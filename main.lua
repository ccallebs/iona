require 'player'

local player = Player.create()

function love.draw()
  player:draw()
end

function love.load()
end

function love.update(dt)
  player:update(dt)
end

