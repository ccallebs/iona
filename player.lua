Player = {}

Player.__index = Player

function Player.create()
  local player = {}

  setmetatable(player, Player)

  player.x = 0
  player.y = 0
  player.movement_length = 2
  player.player_length = 50
  player.window_width = love.graphics.getWidth()
  player.window_height = love.graphics.getHeight()

  -- Setting self color
  love.graphics.setColor(5, 255, 85)

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
  love.graphics.rectangle("fill", self.x, self.y, self.player_length, self.player_length)
end

function Player:moveRight()
  if self:withinBounds() then
    self.x = self.x + self.movement_length
  end
end

function Player:moveLeft()
  if self:withinBounds() then
    self.x = self.x - self.movement_length
  end
end

function Player:moveUp()
  if self:withinBounds() then
    self.y = self.y - self.movement_length
  end
end

function Player:moveDown()
  if self:withinBounds() then
    self.y = self.y + self.movement_length
  end
end

function Player:withinBounds(type)
  if type == 'x' then
    return (self.x >= 0 or layer.x < self.window_width)
  else
    return (self.y >= 0 or self.y < self.window_height)
  end
end
