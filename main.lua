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
	rectangle={}
	rectangle.x=100
	rectangle.length=500
	windowHeight=love.graphics.getHeight()/2
	mouse={}
	mouse.x=0
	mouse.y=0
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
		love.graphics.print("Cutting", 10, 30)
		--love.graphics.print(mouse.x..mouse.y,20,40)
		--love.graphics.print((windowHeight+10)..windowHeight-10,30,60)
		love.graphics.setColor(255, 0, 0)
		love.graphics.rectangle( "fill", rectangle.x, windowHeight-10, rectangle.length, 20 )
	end
end
function love.update()
	--x, y = love.mouse.getPosition( )
	--x=x-width
	--y=y-height
	if level==1 then
		time2 = love.timer.getTime( ) - time
		if time2 >= tonumber(csv[i]) then
			if csv[i+1] ~= nil then
				i=i+1
			else
				level=2
			end
			y=10*i
			--time = love.timer.getTime( )
		end
	end
end
function love.mousepressed()
	if level==2 then
		mouse.x, mouse.y = love.mouse.getPosition( )
		if (mouse.y<(windowHeight+10)) and (mouse.y>(windowHeight-10)) then
			if (rectangle.length>rectangle.length-mouse.x+rectangle.x) and (0<rectangle.length-mouse.x+rectangle.x) then
				rectangle.length=rectangle.length-mouse.x+rectangle.x
				rectangle.x=mouse.x
			end
		end	
	end
end
