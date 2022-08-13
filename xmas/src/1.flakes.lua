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

            if (self.y > 128) then
                del(flakes, self)
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