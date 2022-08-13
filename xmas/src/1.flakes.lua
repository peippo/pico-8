-- snow flakes

function add_flake()
    add(flakes, {
        x = rnd(128),
        y = -5,
        size = rnd(2),
        color = rnd(flake_colors),
        draw = function(self)
            circfill(self.x, self.y, self.size, self.color)
        end,
        update = function(self)
            self.x = self.x + sin(time() * rnd(3))
            self.y += rnd(2)

            if (self.y > 128) then
                del(flakes, self)
            end
        end
    })
end