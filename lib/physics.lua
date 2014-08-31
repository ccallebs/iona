--Static utility methods to do physics calculations
Physics = {}

--[[
Returns new x and y coordinates for the given object, based on it's direction vector.
Also returns the new velocity, based on it's acceleration vector.

Args:
Object: The moving object.
x_direction, y_direction: direction vector
dt: change in time
x_forces, y_forces: force vector for any additional forces you want applied to the object
--]]
function Physics.getPosition(object, x_direction, y_direction, dt, x_forces, y_forces)
  --force = direction * power (power == thrust)
  local x_force = x_direction * object.power
  local y_force = y_direction * object.power

  --Acceleration = Force / mass
  local x_acceleration = (x_force + x_forces) / object.mass
  local y_acceleration = (y_force + y_forces) / object.mass

  --Velocity += Acceleration * time
  local x_velocity = object.x_velocity + x_acceleration * dt
  local y_velocity = object.y_velocity + y_acceleration * dt

  -- Prevent our objects from going too fast
  if(x_velocity > object.speed_cap) then
    x_velocity = object.x_velocity
  end

  if(y_velocity > object.speed_cap) then
    y_velocity = object.y_velocity
  end

  --Position += Velocity * time
  local x_pos = object.x + x_velocity * dt
  local y_pos = object.y + y_velocity * dt

  --Prevent objects from moving beyond the window. Also makes them stop when hitting an edge.
  if not Physics.withinBoundsX(x_pos, object.side_length) then
    x_pos = object.x
    x_velocity = 0
  end

  if not Physics.withinBoundsY(y_pos, object.side_length) then    
    y_pos = object.y
    y_velocity = 0
  end

  return {x = x_pos, y = y_pos, x_velocity = x_velocity, y_velocity = y_velocity}
end

function Physics.withinBoundsX(new_x, side_length)
  return new_x >= 0 and new_x <= love.graphics.getWidth() - side_length
end

function Physics.withinBoundsY(new_y, side_length)
  return new_y >= 0 and new_y <= love.graphics.getHeight() - side_length
end
