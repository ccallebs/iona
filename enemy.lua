Enemy = {}

Enemy.__index = Enemy

function Enemy.create()
  local enemy = {}

  setmetatable(enemy, Enemy)

  enemy.movement_length = math.random(1)
  enemy.enemy_length = 25
  enemy.window_width = love.graphics.getWidth()
  enemy.window_height = love.graphics.getHeight()
  enemy.x = math.random(enemy.window_width)
  enemy.y = math.random(enemy.window_height)
  enemy.collision_radius = 8
  enemy.state = 'alive'

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
  love.graphics.setColor(255, 5, math.random(200))

  love.graphics.rectangle("fill", self.x, self.y, self.enemy_length, self.enemy_length)
end

function Enemy:collision()
  self.state = 'dead'
end
