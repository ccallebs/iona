Player = {}

Player.__index = Player

function Player.create()
  local player = {}

  setmetatable(player, Player)

  player.x = 0
  player.y = 0
  player.movement_length = 6
  player.side_length = 50
  player.half_width = player.side_length/2
  player.half_height = player.side_length/2
  player.window_width = love.graphics.getWidth()
  player.window_height = love.graphics.getHeight()
  player.collision_radius = 8

  return player
end

function Player:update(dt)
  if love.keyboard.isDown("right") then
    self:moveRight()
  end

  if love.keyboard.isDown("left") then
    self:moveLeft()
  end

  if love.keyboard.isDown("up") then
    self:moveUp()
  end

  if love.keyboard.isDown("down") then
    self:moveDown()
  end
end

function Player:draw()
  -- Setting player color
  love.graphics.setColor(5, 255, 85)

  love.graphics.rectangle("fill", self.x, self.y, self.side_length, self.side_length)
end

function Player:moveRight()
  if self:withinBounds('x') then
    self.x = self.x + self.movement_length
  end
end

function Player:moveLeft()
  if self:withinBounds('x') then
    self.x = self.x - self.movement_length
  end
end

function Player:moveUp()
  if self:withinBounds('y') then
    self.y = self.y - self.movement_length
  end
end

function Player:moveDown()
  if self:withinBounds('y') then
    self.y = self.y + self.movement_length
  end
end

function Player:withinBounds(type)
  if type == 'x' then
    return (self.x >= 0 or self.x < self.window_width)
  else
    return (self.y >= 0 or self.y < self.window_height)
  end
end

function Player:collision()
  return nil
end
