Player = Entity:extend()

function Player:new(x, y)
    Player.super.new(self, x, y, "assets/player.png")
    self.strength = 10 

    self.canJump = false
end

-- Update the player
function Player:update(dt)
    Player.super.update(self, dt)

    -- Check keyboard press to move character
    if love.keyboard.isDown("left") then
        self.x = self.x - 200 * dt
    elseif love.keyboard.isDown("right") then
        self.x = self.x + 200 * dt
    end

    -- Cant jump if player y position is changing
    if self.last.y ~= self.y then
        self.canJump = false
    end
end

-- Jump the player
function Player:jump()
    if self.canJump then
        self.fallspeed = -300
        self.canJump = false
    end
end

-- If player is colliding on the bottom, set canJump to true
function Player:collide(e, direction)
    Player.super.collide(self, e, direction)
    if direction == "bottom" then
        self.canJump = true
    end
end