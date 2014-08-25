require 'lib.actor'

Spawner = {}

Spawner.__index = Spawner

function Spawner.create()
  local spawner = Actor.create()

  setmetatable(spawner, Spawner)

  spawner.x = 400
  spawner.y = 400
  spawner.movement_length = 0
  spawner.side_length = 50

  spawner.time_counter = 0
  
  return spawner
end

function Spawner:draw()
  love.graphics.setColor(70, 0, 255)
  love.graphics.rectangle("fill", self.x, self.y, self.side_length, self.side_length)
end

function Spawner:readyToSpawn(time)
  self.time_counter = self.time_counter + time

  if self.time_counter > 2 then
    self.time_counter = 0
    return true
  else
    return false
  end
end

function Spawner:spawn(enemies)
  enemy = Enemy.create()
  enemy.x = self.x + self.side_length / 2
  enemy.y = self.y + self.side_length / 2
  table.insert(enemies, enemy)
end
