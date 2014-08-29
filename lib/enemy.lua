require 'lib.actor'
require 'lib.particles'

Enemy = {}

Enemy.__index = Enemy

function Enemy.create()
  local enemy = Actor.create()

  setmetatable(enemy, Enemy)

  enemy.side_length = 26
  enemy.half_width = enemy.side_length/2
  enemy.half_height = enemy.side_length/2
  enemy.movement_length = math.random(3)
  enemy.x = math.random(enemy.window_width)
  enemy.y = math.random(enemy.window_height)
  enemy.state = 'alive'
  enemy.color = {r = 255, g = 5, b = math.random(200)}

  return enemy
end

function Enemy:update(player)
  calculateTrajectory = (function(player, enemy)
    if player > enemy then
      return self.movement_length
    else
      return -self.movement_length
    end
  end)

  self.x = self.x + calculateTrajectory(player.x, self.x)
  self.y = self.y + calculateTrajectory(player.y, self.y)
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
