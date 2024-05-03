Star = Entity:extend()

function Star:new(x, y)
    Star.super.new(self, x, y, "assets/star.png", 1)
    self.strength = 0
    self.gravity = 0 -- Doesn't fall
    self.angle = 0
end

function Star:update(dt)
    Star.super.update(self, dt)
    self.angle = self.angle + 0.5 * dt % (2 * math.pi)
end

function Star:draw()
    love.graphics.draw(self.image, self.x, self.y, self.angle, 1, 1, 25, 25)
end

function Star:collide(e, direction)

    print('You Win!')

    -- Quit the game
    love.event.quit()
end