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
  xLow = self.object2.x - self.object2.collision_radius
  xHigh = self.object2.x + self.object2.collision_radius

  yLow = self.object2.y - self.object2.collision_radius
  yHigh = self.object2.y + self.object2.collision_radius

  collides_along_x = self.object1.x >= xLow and self.object1.x <= xHigh
  collides_along_y = self.object1.y >= yLow and self.object1.y <= yHigh

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
