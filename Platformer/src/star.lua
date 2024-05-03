Star = Entity:extend()

function Star:new(x, y)
    Wall.super.new(self, x, y, "assets/star.jpg", 1)
    self.strength = 100
    self.gravity = 0 -- Doesn't fall

    self.angle = 0
end