require 'lib.actor'
require 'lib.particles'
require 'lib.physics'

Enemy = {}

Enemy.__index = Enemy

function Enemy.create()
  local enemy = Actor.create()

  setmetatable(enemy, Enemy)

  enemy.side_length = 26
  enemy.half_width = enemy.side_length/2
  enemy.half_height = enemy.side_length/2

  enemy.power = 1
  enemy.mass = 1
  enemy.x_velocity = 0
  enemy.y_velocity = 0
  enemy.speed_cap = 500

  enemy.x = math.random(enemy.window_width)
  enemy.y = math.random(enemy.window_height)
  enemy.state = 'alive'
  enemy.color = {r = 255, g = 5, b = math.random(200)}

  return enemy
end

function Enemy:update(player, dt)

  --Calculate enemies direction vector uses the enemies position and the players position. Divide by 2 to normalize.
  local x_direction = (player.x - self.x)/2
  local y_direction = (player.y - self.y)/2

  local position = Physics.getPosition(self, x_direction, y_direction, dt, 0, 0)
  self.x = position.x
  self.y = position.y
  self.x_velocity = position.x_velocity
  self.y_velocity = position.y_velocity
end

function Enemy:draw()
  -- Setting enemy color
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)

  love.graphics.rectangle("fill", self.x, self.y, self.side_length, self.side_length)
end

function Enemy:collision()
  self.state = 'dead'
  Particles.getInstance():emit(self.x + self.half_width, self.y + self.half_height, self.color.r, self.color.g, self.color.b)
end

