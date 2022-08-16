-- snowman animation

function make_snowman()
    return {
        timing = 0.1,
        sprite = 39,
        x_min = 45,
        x_max = 65,
        x = 45,
        y = 104,
        dir = "r",
        flipped = false,
        draw = function(self)
            spr(self.sprite, self.x, self.y, 1, 1, self.flipped)
        end,
        update = function(self)
            if (self.dir == "r") then
                if (self.x < self.x_max) then
                    self.x += self.timing
                else
                    self.dir = "l"
                    self.flipped = true
                end
            else
                if (self.x > self.x_min) then
                    self.x -= self.timing
                else
                    self.dir = "r"
                    self.flipped = false
                end
            end

            self.sprite += self.timing / 1.5
            if self.sprite >= 42 then self.sprite = 39 end
        end
    }
end
