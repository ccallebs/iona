require 'lib.actor'

Spawner = {}

Spawner.__index = Spawner

function Spawner.create()
  local spawner = Actor.create()

  setmetatable(spawner, Spawner)

  spawner.movement_length = 1
  spawner.side_length = 50
  spawner.velocity = { 
    ["x"] = 0,
    ["y"] = 0 
  }

  spawner.x = 0
  spawner.y = 0

  spawner.time_counter = 0
  
  return spawner
end

function Spawner:draw()
  love.graphics.setColor(70, 0, 255)
  love.graphics.rectangle("line", self.x, self.y, self.side_length, self.side_length)
end

function Spawner:update(dt)
  self:updateVelocity(dt)  

  self.x = self.x + self.velocity.x * self.movement_length
  self.y = self.y + self.velocity.y * self.movement_length
end

function Spawner:updateVelocity(dt)
  if self:atFarRight() and self:atTop() then
    self.velocity = { ["x"] = 0, ["y"] = 2 }
  elseif self:atFarRight() and self:atBottom() then 
    self.velocity = { ["x"] = -2, ["y"] = 0 }
  elseif self:atFarLeft() and self:atTop() then
    self.velocity = { ["x"] = 2, ["y"] = 0 }
  elseif self:atFarLeft() and self:atBottom() then
    self.velocity = { ["x"] = 0, ["y"] = -2 }
  end
end

function Spawner:atFarRight()
  return self.x >= (self.window_width - self.side_length)
end

function Spawner:atFarLeft()
  return self.x <= 0
end

function Spawner:atTop()
  return self.y <= 0
end

function Spawner:atBottom()
  return self.y >= (self.window_height - self.side_length)
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

