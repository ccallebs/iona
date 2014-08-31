require 'lib.actor'
require 'lib.particles'
require 'lib.physics'

Player = {}

Player.__index = Player

function Player.create()
  local player = Actor.create()

  setmetatable(player, Player)

  player.x = 0
  player.y = 0
  player.movement_length = 6
  player.side_length = 50
  player.half_width = player.side_length/2
  player.half_height = player.side_length/2
  player.color = {r = 5, g = 255, b = 85}
  player.x_velocity = 0
  player.y_velocity = 0
  player.power = 0
  player.mass = 1
  player.speed_cap = 200

  return player
end

function Player:update(dt)
  local x_direction = 0
  local y_direction = 0

  --Set the players direction vector. 
  if love.keyboard.isDown("right") then
    x_direction = 1
  end

  if love.keyboard.isDown("left") then
    x_direction = -1
  end

  if love.keyboard.isDown("up") then
    y_direction = -1
  end

  if love.keyboard.isDown("down") then
    y_direction = 1
  end

  --Player only has thrust when the user is trying to move
  if love.keyboard.isDown("right") or love.keyboard.isDown("left") or love.keyboard.isDown("up") or love.keyboard.isDown("down") then
    self.power = 1000
  else
    self.power = 0
  end

  local position = Physics.getPosition(self, x_direction, y_direction, dt, 0, 0)

  self.x = position.x
  self.x_velocity = position.x_velocity

  self.y = position.y
  self.y_velocity = position.y_velocity
end

function Player:draw()
  -- Setting player color
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)

  love.graphics.rectangle("fill", self.x, self.y, self.side_length, self.side_length)
end

function Player:collision()
  Particles.getInstance():emit(self.x + self.half_width, self.y + self.half_height, self.color.r, self.color.g, self.color.b)
end


