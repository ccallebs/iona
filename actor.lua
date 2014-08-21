Actor = {}

Actor.__index = Actor

function Actor.create(object1, object2)
  local actor = {}

  setmetatable(actor, Actor)

  actor.side_length = 0

  actor.half_width = (function()
    return actor.side_length / 2
  end)()

  actor.half_height = (function()
    return actor.side_length / 2
  end)()

  actor.window_width = love.graphics.getWidth()
  actor.window_height = love.graphics.getHeight()

  return actor
end
