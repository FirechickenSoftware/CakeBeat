local core = require "core"
level1 = require "level1"
function love.load()
   image = love.graphics.newImage("cake.png")
	love.keyboard.setKeyRepeat(true)
	y=0
	x=100
	height=image:getHeight()/2
	width=image:getWidth()/2
	local f = assert(io.open("game.csv", "r"))
	local t = f:read("*line")
	csv = core.ParseCSVLine(t) 
	time = love.timer.getTime( )
	--time = math.floor(time)
	i=1
	level=1
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
	if level == 1 then
		love.graphics.draw(image, x, y)
		love.graphics.print("Click and drag the cake around or use the arrow keys", 10, 10)
		love.graphics.print(time)
		love.graphics.print(time2,0,50)
		love.graphics.print(csv[i],0,100)
	elseif level==2 then
		love.graphics.print("LEVEL 2", 10, 30)
	end
end
function love.update()
	--x, y = love.mouse.getPosition( )
	--x=x-width
	--y=y-height
	if level==1 then
		y,i=level1.update(time,csv,i,y)
	end
end
function love.mousepressed()
end
