push = require 'push'

WINDOW_HEIGHT = 721
WINDOW_WIDTH = 1280

VIRTUAL_HEIGHT = 243
VIRTUAL_WIDTH = 432

--[[Used to initialize the game]]
function love.load()

    -- use nearest-neighbor filtering on upscaling and downscaling to prevent blurring of text 
    -- and graphics; try removing this function to see the difference!
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT {

        fullcreen = false,
        resizable = false,
        vsync = true
    })
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

    love.graphics.printf('Hello Pong', 0, WINDOW_HEIGHT / 2 - 6, WINDOW_WIDTH, 'center')
    --[[
        Hello Pong!',          -- text
        0,                      -- starting X (0 since we're going to center it based on width)
        WINDOW_HEIGHT / 2 - 6,  -- starting Y (halfway down the screen)
        WINDOW_WIDTH,           -- number of pixels to center within (the entire screen here)
        'center')               -- alignment mode, can be 'center', 'left', or 'right'
    ]]
    -- end rendering
    push:apply('end')
end
