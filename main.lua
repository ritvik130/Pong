push = require 'push'

WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

VIRTUAL_HEIGHT = 243
VIRTUAL_WIDTH = 432

-- speed at which we will move our paddle; multiplied by dt in update
PADDLE_SPEED = 200

--[[Used to initialize the game]]
function love.load()

    -- use nearest-neighbor filtering on upscaling and downscaling to prevent blurring of text 
    -- and graphics; try removing this function to see the difference!
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- more retro looking font 
    smallFont = love.graphics.newFont('font.ttf', 8)

    -- larger font for drawing the score on the screen
    scoreFont = love.graphics.newFont('font.ttf', 32)

    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {

        fullcreen = false,
        resizable = false,
        vsync = true
    })

    -- initialize score variables, used for rendering on the screen and keeping
    -- track of the winner
    player1Score = 0
    player2Score = 0

    -- paddle positions on the Y axis (they can only move up or down)
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50
end

--[[
    Runs every frame, with "dt" passed in, our delta in seconds 
    since the last frame, which LÖVE2D supplies us.
]]
function love.update(dt)

    -- y axis movement up is negative aand down is positive is love 2d

    -- Player 1 movement 
    if love.keyboard.isDown('w') then
        -- love.keyBoard.isDown() returns true if the key is keyPressed
        -- add negative paddle speed to current Y scaled by deltaTime
        player1Y = player1Y + -PADDLE_SPEED * dt

    elseif love.keyboard.isDown('s') then
        -- add positive paddle speed to current Y scaled by deltaTime
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    -- Player 2 movement
    if love.keyboard.isDown('up') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player2Y = player2Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        -- add positive paddle speed to current Y scaled by deltaTime
        player2Y = player2Y + PADDLE_SPEED * dt
    end
end

function love.keyPressed(key)
    -- accessing the using String
    if key == 'escape' then
        -- terminate application
        love.event.quit()
    end
end

function love.draw()
    -- begin rendering
    push:apply('start')

    -- clear the screen with specific color (R,G,B,Transparency)
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    love.graphics.setFont(smallFont)
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')
    --[[
        Hello Pong!',          -- text
        0,                      -- starting X (0 since we're going to center it based on width)
        WINDOW_HEIGHT / 2 - 6,  -- starting Y (halfway down the screen)
        WINDOW_WIDTH,           -- number of pixels to center within (the entire screen here)
        'center')               -- alignment mode, can be 'center', 'left', or 'right'
    ]]

    -- draw score on the left and right center of the screen
    -- need to switch font to draw before actually printing
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    -- render first paddle (left side) 
    -- (fill,x,y,width,height)
    love.graphics.rectangle('fill', 10, 30, 5, 20)

    -- render second paddle (right side)
    -- (fill,x,y,width,height)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)

    -- render ball (center)
    -- (fill,x,y,width,height)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    -- end rendering
    push:apply('end')
end
