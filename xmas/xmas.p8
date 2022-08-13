pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
-- xmas is coming
-- by peippo

function _init()
    flakes = {}
    flake_colors = {5, 6, 7}
    wind_speeds = {-0.4, -0.2, 0, 0.2, 0.4}
    wind = rnd(wind_speeds)
end
   
function _draw()
    cls(1)
    
    add_flake()

    for flake in all(flakes) do
        flake:draw()
    end
end

function _update60()
    randomize_wind()

    for flake in all(flakes) do
        flake:update(wind)
    end
end
-->8
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
-->8
-- utility functions

function random(a, b)
    if (a > b) a, b = b, a
    return a + flr(rnd(b - a + 1))
end
