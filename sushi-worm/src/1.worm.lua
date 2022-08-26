-- worm

function init_worm()
    return {
        worm = {},
        x = 64,
        y = 64,
        length = 10,
        turn_speed = 10,
        dir = 90,
        draw = function(self)
            for p in all(self.worm) do
                pset(p.x,p.y,14)
            end
            
            print(self.dir, 5, 5, 6)
        end,
        update = function(self)
            local pixel = {}

            if (self.dir >= 0 and self.dir <= 89) then
                add(self.worm, {
                    x = self.x+1,
                    y = self.y-1
                })
                self.x+=1
                self.y-=1
            end

            if (self.dir >= 90 and self.dir <= 179) then
                add(self.worm, {
                    x = self.x+1,
                    y = self.y+1
                })
                self.x+=1
                self.y+=1
            end

            if (self.dir >= 179 and self.dir <= 269) then
                add(self.worm, {
                    x = self.x-1,
                    y = self.y+1
                })
                self.x-=1
                self.y+=1
            end

            if (self.dir >= 269 and self.dir <= 360) then
                add(self.worm, {
                    x = self.x-1,
                    y = self.y-1
                })
                self.x-=1
                self.y-=1
            end

            -- controls
            if (btn(0)) then self.dir-=self.turn_speed end
            if (btn(1)) then self.dir+=self.turn_speed end

            if (self.dir > 360) then self.dir = 0 end
            if (self.dir < 0) then self.dir = 360 end

            -- wrap around edges
            if (self.x > 127) then self.x = 0 end
            if (self.y > 127) then self.y = 0 end
            if (self.x < 0) then self.x = 127 end
            if (self.y < 0) then self.y = 127 end

            -- worm length
            if (#self.worm > self.length) then deli(self.worm, 1) end
        end
    }
end
