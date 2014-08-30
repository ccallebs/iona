Particles = {}

Particles.__index = Particles

local particles

function Particles.getInstance()
  if particles == nil then
    particles = {}

    setmetatable(particles, Particles)

    particles.particleImage = love.graphics.newImage('particle.png')
    
    particles.systems = {}

    return particles
  else
    return particles
  end
end


function Particles:emit(x, y, r, g, b)
  local p = self:getBaseSystem()

  p:setColors(255, 255, 255, 255, r, g, b, 0)
  p:setPosition(x, y)
  p:start()

  table.insert(self.systems, p)
end   

function Particles:getBaseSystem() 
  local p = love.graphics.newParticleSystem(self.particleImage, 5)

  p:setEmissionRate(100)
  p:setSpeed(300, 400)
  p:setLinearAcceleration(0, 0)
  p:setSizes(2, 1)
  p:setColors(255, 255, 255, 255, 58, 128, 255, 0)
  p:setPosition(400, 300)
  p:setEmitterLifetime(.4)
  p:setParticleLifetime(.4)
  p:setDirection(0)
  p:setSpread(360)
  p:setRadialAcceleration(-2000)
  p:setTangentialAcceleration(1000)
  p:setSizes(.06, .08, .1)
  p:stop()

  return p
end

function Particles:update(dt)
    for i, system in ipairs(self.systems) do
      system:update(dt)
    end
end 

function Particles:draw()
  for i, system in ipairs(self.systems) do
    love.graphics.draw(system, 0, 0)
  end
end
