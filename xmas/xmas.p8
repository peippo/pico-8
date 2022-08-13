pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- xmas is coming
-- by peippo

function _init()
    flakes = {}
    flake_colors = {5, 6, 7}
end
   
function _draw()
    cls(1)
    
    add_flake();

    for flake in all(flakes) do
        flake:draw()
    end
end

function _update60()
    for flake in all(flakes) do
        flake:update()
    end
end
-->8
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

