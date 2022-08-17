-- chimney smoke

function add_smoke()
    add(smokes, {
        spread = rnd(2),
        life = rnd(15),
        x = random(94, 98),
        y = 60,
        color = flr(random(5,6)),
        size = 3,
        draw = function(self)
            pset(self.x, self.y, self.color)
        end,
        update = function(self, wind)
            if (time() % 0.25 == 0) then
                self.x += wind
                self.y -= self.spread
                self.life -= 1
            end
            if self.life < 0 then
                del(smokes, self)
            end
        end
    })
end
