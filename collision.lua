Collision = {}

Collision.__index = Collision

function Collision.create(object1, object2)
  local collision = {}

  setmetatable(collision, Collision)

  collision.object1 = object1
  collision.object2 = object2

  return collision
end

function Collision:doesCollide()
  x_low = self.object2.x
  x_high = self.object2.x + self.object2.side_length

  y_low = self.object2.y
  y_high = self.object2.y + self.object2.side_length

  collides_along_x = self.object1.x >= x_low and self.object1.x <= x_high
  collides_along_y = self.object1.y >= y_low and self.object1.y <= y_high

  return collides_along_x and collides_along_y
end

function Collision:collide()
  if self:doesCollide() then
    self.object1:collision()
    self.object2:collision()
    return true
  else
    return false
  end
end
