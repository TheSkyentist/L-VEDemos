Wall = Entity:extend()

function Wall:new(x, y)
    Wall.super.new(self, x, y, "assets/wall.png", 1)
    self.strength = 100
    self.gravity = 0 -- Doesn't fall
end