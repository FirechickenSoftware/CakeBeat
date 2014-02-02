function love.load()
   image = love.graphics.newImage("cake.png")
	love.keyboard.setKeyRepeat(true)
   y=100
   x=100
	height=image:getHeight()/2
	width=image:getWidth()/2
end
function love.keypressed(key, isrepeat)
   if key == 'up' then
      y=y-10
   elseif key == 'down' then
      y=y+10
	end
   if key == 'left' then
		x=x-10
   elseif key == 'right' then
      x=x+10
   end
	if key == "escape" then
      love.event.quit()
   end
end
function love.draw()
   love.graphics.draw(image, x, y)
   love.graphics.print("Click and drag the cake around or use the arrow keys", 10, 10)
end
function love.update()
	x, y = love.mouse.getPosition( )
	x=x-width
	y=y-height
end
function love.mousepressed()
end