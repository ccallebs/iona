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
  object1_center_x = self.object1.x + self.object1.half_width
  object1_center_y = self.object1.y + self.object1.half_height

  object2_center_x = self.object2.x + self.object2.half_width
  object2_center_y = self.object2.y + self.object2.half_height

  return (math.abs(object1_center_x - object2_center_x) < (self.object1.half_width + self.object2.half_width)) and 
         (math.abs(object1_center_y - object2_center_y) < (self.object1.half_height + self.object2.half_height))
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
