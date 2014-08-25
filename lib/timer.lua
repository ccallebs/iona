
require 'lib.actor'

Timer = {}

Timer.__index = Timer

function Timer.create()
  local timer = {}

  setmetatable(timer, Timer)

  timer.x = 0
  timer.y = 0
  timer:reset()
  
  return timer
end

function Timer:reset()
  self.timer_start = love.timer.getTime()
end

function Timer:draw()
  love.graphics.printf(self:formatString(self:getElapsed()), 0, 0, 800, 'center')  
end

function Timer:getElapsed()
  return love.timer.getTime() - self.timer_start
end

function Timer:formatString(seconds)
  return string.format("%.2d:%.2d:%.2d", seconds/(60*60), seconds/60%60, seconds%60) 
end
