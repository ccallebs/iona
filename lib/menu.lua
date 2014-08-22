require 'game'

Menu = {}

Menu.__index = Menu

function Menu.create()
	local menu = {}

	setmetatable(menu, Menu)

	menu.options = {'Play', 'Close'}
	menu.selected = 1
	menu.open = true

	return menu
end

function Menu:update(dt)
	if self.open then
		if love.keyboard.isDown("up") then
			self:moveUp()
		end

		if love.keyboard.isDown("down") then
	    	self:moveDown()
	  	end

	  	if love.keyboard.isDown("return") then
	  		self.open = false
	  		if self.options[self.selected] == 'Play' then
	  			self.game:reset()
  			elseif self.options[self.selected] == 'Close' then
  				love.event.quit()	
	  		end
	  	end

	end
end	

function Menu:draw()
	love.graphics.setColor(255, 0, 0)
	love.graphics.printf("Main Menu", 0, 100, 800, 'center')
	start_y = 200
	for i, option in ipairs(self.options) do
		love.graphics.setColor(0, 0, 255)
		if i == self.selected then
			love.graphics.setColor(0, 255, 0)
		end
		love.graphics.printf(option, 0, start_y, 800, 'center')
		start_y = start_y + 50
	end
end	

function Menu:moveUp()
	if self.selected > 1 then
		self.selected = self.selected - 1
	end
end

function Menu:moveDown()
	if self.selected < #(self.options) then
		self.selected = self.selected + 1
	end
end
