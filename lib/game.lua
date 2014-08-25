Game = {}

Game.__index = Game

function Game.create()
  local game = {}

  setmetatable(game, Game)

  game.state = 'menu'
  game.enemies = {}
  game.player = nil
  game.spawner = {}

  return game
end

function Game:reset()
  self.enemies = { Enemy.create() } 
  self.player = Player.create()
  self.spawner = Spawner.create()
  self.state = 'playing'
end

function Game:removeDeadEnemies()
  new_enemies = {}

  for i, enemy in ipairs(self.enemies) do
    if enemy.state ~= 'dead' then
      table.insert(new_enemies, enemy)
    end
  end

  self.enemies = new_enemies
end

function Game:tryToSpawnEnemies(time)
  if self.state ~= 'playing' then
    return
  end

  if self.spawner:readyToSpawn(time) then
    self.spawner:spawn(self.enemies)
  end
end

