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
  
  return spawner
end

function Spawner:draw()
  love.graphics.setColor(70, 0, 255)
  love.graphics.rectangle("fill", self.x, self.y, self.side_length, self.side_length)
end
