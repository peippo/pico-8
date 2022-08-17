-- snowman animation

function make_snowman()
    return {
        timing = 0.1,
        sprite = 39,
        walk_start = 39,
        wave_start = 54,
        walk_states = 3,
        wave_states = 4,
        x_min = 45,
        x_max = 65,
        x = 45,
        y = 104,
        dir = "r",
        flipped = false,
        waving = false,
        draw = function(self)
            spr(self.sprite, self.x, self.y, 1, 1, self.flipped)
        end,
        update = function(self)
            if (time() % 5 == 0) then self.waving = true end
            
            -- waving
            if self.waving == true then
                if self.sprite < self.wave_start then self.sprite = self.wave_start end

                self.sprite += self.timing / 1.5

                if self.sprite >= (self.wave_start + self.wave_states) then
                    self.sprite = self.wave_start
                end

                if (time() % 4 == 0) then self.waving = false end
            else
            -- walking
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
                if self.sprite >= (self.walk_start + self.walk_states) then
                    self.sprite = self.walk_start
                end
            end
        end
    }
end
