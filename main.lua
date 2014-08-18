require 'player'

local player = Player.create()

function love.draw()
  player:draw()
end

function love.load()
end

function love.update(dt)
  if love.keyboard.isDown("right") then
    player:moveRight()
  end

  if love.keyboard.isDown("left") then
    player:moveLeft()
  end

  if love.keyboard.isDown("up") then
    player:moveUp()
  end

  if love.keyboard.isDown("down") then
    player:moveDown()
  end
end

