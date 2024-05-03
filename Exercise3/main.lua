function love.load()
    
    Object = require "lib.classic"
    require "src.entity"
    require "src.player"
    require "src.wall"
    require "src.star"

    player = Player(100, 100)
    star = Star(675, 225)

    objects = {}
    table.insert(objects, player)
    table.insert(objects, box)
    table.insert(objects, star)

    local map = {
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1},
        {1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
    }

    -- Create the walls
    walls = {}
    for i,v in ipairs(map) do
        for j,w in ipairs(v) do
            if w == 1 then
                table.insert(walls, Wall((j-1)*50, (i-1)*50))
            end
        end
    end
end

function love.update(dt)

    -- Update the objects
    for i,v in ipairs(objects) do
        v:update(dt)
    end

    -- Update the walls
    for i,v in ipairs(walls) do
        v:update(dt)
    end

    
    local loop = true
    local limit = 0

    while loop do
        loop = false

        -- Limit the number of iterations to prevent infinite loops.
        limit = limit + 1
        if limit > 100 then
            break
        end

        -- For each object check collision with every other object.
        for i=1,#objects-1 do
            for j=i+1,#objects do
                local collision = objects[i]:resolveCollision(objects[j])

                -- If there was a collision, set loop to true.
                if collision then
                    loop = true
                end
            end
        end

        -- For each object check collision with every wall.
        for i,wall in ipairs(walls) do
            for j,object in ipairs(objects) do
                local collision = object:resolveCollision(wall)
                
                -- If there was a collision, set loop to true.
                if collision then
                    loop = true
                end
            end
        end

    end
end

function love.draw()

    -- Draw the objects
    for i,v in ipairs(objects) do
        v:draw()
    end

    -- Draw the walls
    for i,v in ipairs(walls) do
        v:draw()
    end
end

function love.keypressed(key)
    -- Let the player jump when the up-key is pressed
    if key == "up" then
        player:jump()
    end
end