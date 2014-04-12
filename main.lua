function love.load()

	love.graphics.setBackgroundColor(150, 153, 155) --for all colour thingies, it goes R,G,B
	xcloud = 0
	imgcloud = love.graphics.newImage("textures/cloud.png") --sets the variable for a picture to be drawn
	imgground = love.graphics.newImage("textures/ground.png") --MUST BE IN LOVE.LOAD!!
	imgshittyman = love.graphics.newImage("textures/shittyman.png")
	imgcurser = love.graphics.newImage("textures/curser.png")
	manx = 200
	many = 200
	state = not
	love.mouse.setVisible(state)
	sound = love.audio.newSource("sounds/sound.mp3", "stream")
	jump = love.audio.newSource("sounds/Jump.wav")
	jump:setVolume(0.2)
	
--Physics shit form here on
	love.physics.setMeter(64) --sets distance for one meter
	world = love.physics.newWorld(0, 9.81*64, true) --xgrav, ygrav(m/s/s * what you made your meter distance), then just true
	objects = {}
	
		objects.cloud = {}
		objects.cloud.body = love.physics.newBody(world, cloudx, 154)
		objects.cloud.shape = love.physics.newRectangleShape(50, 150)
		objects.cloud.fixture = love.physics.newFixture(objects.cloud.body, objects.cloud.shape)
	
		objects.wallr = {}
		objects.wallr.body = love.physics.newBody(world, 800, 600/2)
		objects.wallr.shape = love.physics.newRectangleShape(25, 800)
		objects.wallr.fixture = love.physics.newFixture(objects.wallr.body, objects.wallr.shape)
		objects.wallr.fixture:setRestitution(0)
		
		objects.walll = {}
		objects.walll.body = love.physics.newBody(world, 0, 600/2)
		objects.walll.shape = love.physics.newRectangleShape(25, 800)
		objects.walll.fixture = love.physics.newFixture(objects.walll.body, objects.walll.shape)
		objects.walll.fixture:setRestitution(0)

		objects.ceiling = {}
		objects.ceiling.body = love.physics.newBody(world, 800/2, 0)
		objects.ceiling.shape = love.physics.newRectangleShape(800, 25)
		objects.ceiling.fixture = love.physics.newFixture(objects.ceiling.body, objects.ceiling.shape)
		objects.ceiling.fixture:setRestitution(0)

		objects.ground = {}
		objects.ground.body = love.physics.newBody(world, 800/2, 600)
		objects.ground.shape = love.physics.newRectangleShape(800, 25)
		objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)
		objects.ground.fixture:setRestitution(0)
		
		--[[objects.ball = {}
		objects.ball.body = love.physics.newBody(world, 800/2, 600/2, "dynamic")
		objects.ball.shape = love.physics.newCircleShape(20)
		objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1)
		objects.ball.fixture:setRestitution(9) --makes things bouncy]]
		
		objects.dasblock = {}
		objects.dasblock.body = love.physics.newBody(world, 800/2 + 100, 600-200, "dynamic")
		objects.dasblock.shape = love.physics.newRectangleShape(20,20)
		objects.dasblock.fixture = love.physics.newFixture(objects.dasblock.body, objects.dasblock.shape, 1)
		objects.dasblock.fixture:setRestitution(0)
	
end
	
function love.draw()


	love.graphics.setColor(198, 241, 255, 255)
	love.graphics.rectangle("fill", 0, 0, 800, 300) --sky
	
	--love.graphics.setColor(255,255,255,255)
	--love.graphics.rectangle("fill", xcloud - 256, 128, 256, 64) --cloud place holder
	
	love.graphics.setColor(6,15,150,255)
	love.graphics.polygon("fill", objects.cloud.body:getWorldPoints(objects.cloud.shape:getPoints()))
	
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(imgcloud, xcloud-256, 128, 0, 1, 1, 0, 0) --actual cloud placement
	
	love.graphics.setColor(6, 150, 6, 255)
	love.graphics.rectangle("fill", 0, 300, 800, 300) --ground
	
	love.graphics.setColor(255, 255,255,255)
	love.graphics.draw(imgground,0, 300-64,0,1.02,1,0,0) --drawn ground
	
	love.graphics.setColor(25, 25, 25, 155)
	love.graphics.draw(imgcloud, xcloud-256, 350, 0, 1, 1, 0, 0) --cloud Shadow
	
	love.graphics.setColor(6,150,150,255)
	love.graphics.polygon("fill", objects.ceiling.body:getWorldPoints(objects.ceiling.shape:getPoints()))
		
	love.graphics.setColor(6,150,150,255)
	love.graphics.polygon("fill", objects.walll.body:getWorldPoints(objects.walll.shape:getPoints()))
		
	love.graphics.setColor(6,150,150,255)
	love.graphics.polygon("fill", objects.wallr.body:getWorldPoints(objects.wallr.shape:getPoints()))
		
	love.graphics.setColor(6,150,150,255)
	love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
	
	love.graphics.setColor(6,15,150,255)
	love.graphics.polygon("fill", objects.dasblock.body:getWorldPoints(objects.dasblock.shape:getPoints()))
	
	--love.graphics.draw(imgshittyman, manx, many) --the man sprite, probably temp
	
	--[[love.graphics.setColor(64,56,73,225)
	love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())
	]]
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(imgcurser, x, y) --the curser
	
end

function love.update(dt)
	world:update(dt)
		--[[if love.keyboard.isDown("w") then
			objects.dasblock.body:applyForce(0, -200)  
		elseif love.keyboard.isDown("s") then
			objects.dasblock.body:applyForce(0, 200)]]
		if love.keyboard.isDown("d") then
			objects.dasblock.body:applyForce(100,0)
		elseif love.keyboard.isDown("a") then
			objects.dasblock.body:applyForce(-100,0)
		end
		
 x = love.mouse.getX()
 y = love.mouse.getY()
	
	xcloud = xcloud + 60*dt
	if xcloud >= (800 + 256) then 
		xcloud = 0
	end
	cloudx = 0
	cloudx = cloudx + 60*dt
	if cloudx >= (800 + 256) then 
		cloudx = 0
	end
	
	if love.mouse.isDown("l") then
		print("x pos:", x)
		print("y pos:", y)
	end
end

function love.keypressed(key)
	if key == "w" then
		objects.dasblock.body:applyForce(0,-20000)
	elseif key == "s" then
		objects.dasblock.body:applyForce(0, 20000)
	end
	if key == "w" then
		love.audio.play(jump)
	end
end

function love.focus(bool)
	if not bool then
		print("Unfocused")
	else
		print("Focused")
	end
end

function love.quit()
	
end