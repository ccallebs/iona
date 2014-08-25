Game = {}

Game.__index = Game

function Game.create()
  local game = {}

  setmetatable(game, Game)

  game.state = 'playing'
  game.enemies = {}
  game.player = nil

  return game
end

function Game:reset()
  self.enemies = self:generateEnemies(8)
  self.player = Player.create()
  self.state = 'playing'
end

function Game:generateEnemies(count)
  self.enemies = {}

  for i=0, count, 1 do
    self.enemies[i] = Enemy.create()
  end

  return self.enemies
end

function Game:removeDeadEnemies()
  enemies_to_remove = {}

  for i, enemy in ipairs(self.enemies) do
    if enemy.state == 'dead' then
      table.insert(enemies_to_remove, i)
    end
  end

  for i, enemy in ipairs(enemies_to_remove) do
    table.remove(self.enemies, enemy)
  end
end
