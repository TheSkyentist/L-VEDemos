Entity = Object:extend()


function Entity:new(x, y, image_path)

    -- The x and y position of the entity
    self.x = x
    self.y = y

    -- The image of the entity
    self.image = love.graphics.newImage(image_path)
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    -- The last position of the entity
    self.last = {}
    self.last.x = self.x
    self.last.y = self.y

    -- The strength of the entity (can it be pushed)
    self.strength = 0
    self.tempStrength = 0

    -- Add the fallspeed and gravity properties
    self.fallspeed = 0 -- current fallspeed
    self.gravity = 400 -- rate of acceleration
end

function Entity:update(dt)

    -- Save the last position
    self.last.x = self.x
    self.last.y = self.y

    -- Save the strength
    self.tempStrength = self.strength

    -- Increase the fallspeed using the gravity
    self.fallspeed = self.fallspeed + self.gravity * dt

    -- Increase the y-position
    self.y = self.y + self.fallspeed * dt
end


-- Check if there is a collision between two entities
-- e will be the other entity with which we check if there is collision.
function Entity:checkCollision(e)
    -- Check each direction
    return self.x + self.width > e.x
    and self.x < e.x + e.width
    and self.y + self.height > e.y
    and self.y < e.y + e.height
end

function Entity:resolveCollision(e)

    -- Resolve the collision of the higher strenght entity
    if self.tempStrength > e.tempStrength then
        return e:resolveCollision(self)
    end

    -- Check if there is a collision
    if self:checkCollision(e) then
        self.tempStrength = e.tempStrength

        -- Check if the entities were vertically aligned
        if self:wasVerticallyAligned(e) then

            -- Check if the entity was on the left or right side
            if self.x + self.width/2 < e.x + e.width/2 then
                self:collide(e, "right")
            else
                self:collide(e, "left")
            end
        
        -- Check if the entities were horizontally aligned
        elseif self:wasHorizontallyAligned(e) then

            -- Check if the entity was on the top or bottom side
            if self.y + self.height/2 < e.y + e.height/2 then
                self:collide(e, "bottom")
            else
                self:collide(e, "top")
            end
        end

        return true

    end
    return false
end

-- Resolve the collision
function Entity:collide(e, direction)

    -- Resolve the collision based on the direction
    if direction == "right" then
        local pushback = self.x + self.width - e.x
        self.x = self.x - pushback
    elseif direction == "left" then
        local pushback = e.x + e.width - self.x
        self.x = self.x + pushback
    elseif direction == "bottom" then
        local pushback = self.y + self.height - e.y
        self.y = self.y - pushback
        self.fallspeed = 0
    elseif direction == "top" then
        local pushback = e.y + e.height - self.y
        self.y = self.y + pushback
    end
end

-- Check if the entity was vertically aligned
function Entity:wasVerticallyAligned(e)
    -- It's basically the collisionCheck function, but with the x and width part removed.
    -- It uses last.y because we want to know this from the previous position
    return self.last.y < e.last.y + e.height and self.last.y + self.height > e.last.y
end

-- Check if the entity was horizontally aligned
function Entity:wasHorizontallyAligned(e)
    -- It's basically the collisionCheck function, but with the y and height part removed.
    -- It uses last.x because we want to know this from the previous position
    return self.last.x < e.last.x + e.width and self.last.x + self.width > e.last.x
end

-- Draw the entity
function Entity:draw()
    love.graphics.draw(self.image, self.x, self.y)
end