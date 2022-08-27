-- worm

function init_worm()
    return {
        body = {},
        x = 20,
        y = 20,
        length = 10,
        turn_speed = 10,
        angle = 315,
        palette={3,3,3,3,3,11,11,11,11,11},
        draw = function(self)
            for p in all(self.body) do
                circfill(p.x,p.y,1,p.col)
            end          
        end,
        update = function(self)
            -- movement
            add(self.body, {
                x = self.x + 1 * sin(self.angle/360),
                y = self.y + 1 * cos(self.angle/360),
                col = self.palette[1]
            }, 1)
            self.x = self.body[1]["x"]
            self.y = self.body[1]["y"]

            -- controls
            if (btn(0)) then self.angle-=self.turn_speed end
            if (btn(1)) then self.angle+=self.turn_speed end

            if (self.angle > 360) then self.angle = 0 end
            if (self.angle < 0) then self.angle = 360 end

            -- wrap around edges
            if (self.x > 119) then self.x = 10 end
            if (self.y > 119) then self.y = 11 end
            if (self.x < 9) then self.x = 120 end
            if (self.y < 10) then self.y = 120 end

            -- body length
            if (#self.body > self.length) then deli(self.body) end

            for i in pairs(self.body) do
                self.body[i].col = self.palette[i % #self.palette + 1]
            end

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
