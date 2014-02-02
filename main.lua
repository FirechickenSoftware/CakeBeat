function love.load()
   image = love.graphics.newImage("cake.png")
	love.keyboard.setKeyRepeat(true)
	y=100
	x=100
	height=image:getHeight()/2
	width=image:getWidth()/2
	local f = assert(io.open("game.csv", "r"))
	local t = f:read("*line")
	csv = ParseCSVLine(t) 
	time = love.timer.getTime( )
	time = math.floor(time)
	i=1
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
	love.graphics.print(time)
	love.graphics.print(time2,0,50)
	love.graphics.print(csv[i],0,100)
end
function love.update()
	--x, y = love.mouse.getPosition( )
	--x=x-width
	--y=y-height
	
	time2 = math.floor(love.timer.getTime( )) - time
	if time2 == tonumber(csv[i]) then
		if csv[i+1] ~= nil then
			i=i+1
		end
		y=10*i
		time = math.floor(love.timer.getTime( ))
	end
end
function love.mousepressed()
end
function ParseCSVLine (line,sep) 
	local res = {}
	local pos = 1
	sep = sep or ','
	while true do 
		local c = string.sub(line,pos,pos)
		if (c == "") then break end
		if (c == '"') then
			-- quoted value (ignore separator within)
			local txt = ""
			repeat
				local startp,endp = string.find(line,'^%b""',pos)
				txt = txt..string.sub(line,startp+1,endp-1)
				pos = endp + 1
				c = string.sub(line,pos,pos) 
				if (c == '"') then txt = txt..'"' end 
				-- check first char AFTER quoted string, if it is another
				-- quoted string without separator, then append it
				-- this is the way to "escape" the quote char in a quote. example:
				--   value1,"blub""blip""boing",value3  will result in blub"blip"boing  for the middle
			until (c ~= '"')
			table.insert(res,txt)
			assert(c == sep or c == "")
			pos = pos + 1
		else	
			-- no quotes used, just look for the first separator
			local startp,endp = string.find(line,sep,pos)
			if (startp) then 
				table.insert(res,string.sub(line,pos,startp-1))
				pos = endp + 1
			else
				-- no separator found -> use rest of string and terminate
				table.insert(res,string.sub(line,pos))
				break
			end 
		end
	end
	return res
end
