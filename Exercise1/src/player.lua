Player = Entity:extend()

function Player:new(x, y)
    Player.super.new(self, x, y, "assets/player.png")
    self.strength = 10 
end

-- Update the player
function Player:update(dt)
    Player.super.update(self, dt)

    -- Add movement here!
    -- Hint: love.keyboard.isDown("left")

end