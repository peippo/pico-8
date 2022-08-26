-- worm

function init_worm()
    return {
        body = {},
        x = 64,
        y = 64,
        length = 10,
        turn_speed = 10,
        dir = 90,
        draw = function(self)
            for p in all(self.body) do
                pset(p.x,p.y,1)
            end
            
            print(self.dir, 10, 4, 1)
            print(self.dir, 10, 3, 15)            
        end,
        update = function(self)
            local pixel = {}

            if (self.dir >= 0 and self.dir <= 89) then
                add(self.body, {
                    x = self.x+1,
                    y = self.y-1
                })
                self.x+=1
                self.y-=1
            end

            if (self.dir >= 90 and self.dir <= 179) then
                add(self.body, {
                    x = self.x+1,
                    y = self.y+1
                })
                self.x+=1
                self.y+=1
            end

            if (self.dir >= 179 and self.dir <= 269) then
                add(self.body, {
                    x = self.x-1,
                    y = self.y+1
                })
                self.x-=1
                self.y+=1
            end

            if (self.dir >= 269 and self.dir <= 360) then
                add(self.body, {
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
            if (self.x > 119) then self.x = 10 end
            if (self.y > 119) then self.y = 11 end
            if (self.x < 9) then self.x = 120 end
            if (self.y < 10) then self.y = 120 end

            -- body length
            if (#self.body > self.length) then deli(self.body, 1) end

            -- check for sushi collect
            if self.x > sushi.x
            and self.x < sushi.x + 8
            and self.y > sushi.y
            and self.y < sushi.y + 8
            then
                sushi:collect()
            end
        end
    }
end
