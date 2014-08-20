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
  x1 = self.object2.x - self.object2.collision_radius
  x2 = self.object2.x + self.object2.collision_radius

  y1 = self.object2.y - self.object2.collision_radius
  y2 = self.object2.y + self.object2.collision_radius

  collides_along_x = self.object1.x >= x1 and self.object1.x <= x2
  collides_along_y = self.object1.y >= y1 and self.object1.x <= y2

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
