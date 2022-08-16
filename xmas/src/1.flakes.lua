-- snow flakes

function add_flake()
    add(flakes, {
        x = random(-128 - 64, 128 + 64),
        y = -5,
        size = rnd(2),
        color = rnd(flake_colors),
        draw = function(self)
            circfill(self.x, self.y, self.size, self.color)
        end,
        update = function(self, wind)
            self.x = self.x + wind + sin(time() * rnd(3))
            self.y += rnd(2)

            if (self.y > 112) then
                add_ground_flake(self.x, self.color)
                del(flakes, self)
            end
        end
    })
end

function add_ground_flake(_x)
    add(ground_flakes, {
        x = _x,
        y = 111,
        timer = t() + 4,
        draw = function(self)
            circfill(self.x, self.y, 0, 6)
        end,
        update = function(self)
            if (self.timer == t()) then
                del(ground_flakes, self)
            end
        end

    })
end

function randomize_wind()
    change_wind = time() % 5 == 0

    if change_wind then
        wind = rnd(wind_speeds)
    end
end