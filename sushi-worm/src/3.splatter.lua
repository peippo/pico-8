-- death splatter

function init_splatter()
    return {
        size = 0,
        max_size = 5,
        reset = function(self)
            self.size = 0
        end,
        draw = function(self, _x, _y)
            circfill(_x, _y, self.size, 2)
        end,
        update = function(self)
            if self.size < self.max_size then
                self.size += 0.5
            end
        end
    }
end
