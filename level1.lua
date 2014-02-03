local level1 = {}
	function level1.update(time,csv,i,y)
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
		return y,i
	end
return level1
