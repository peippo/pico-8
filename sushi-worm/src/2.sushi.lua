-- sushi

function init_sushi()
    return {
        x = 68,
        y = 91,
        sprite = get_random_sprite(),
        draw = function(self)            
            -- shadow
            for c=0,15 do
                pal(c, 0)
            end
            spr(self.sprite, self.x, self.y + 1)
            pal()

            -- sprite
            spr(self.sprite, self.x, self.y)
        end,
        collect = function(self)
            self.sprite = get_random_sprite()

            local pos = get_random_position()
            self.x = pos.x
            self.y = pos.y

            worm.length+=10
            score+=1
            sfx(0)
        end

    }
end

function get_random_sprite()
    return flr(rnd(6) + 1)
end


function get_random_position()
    local pos = {}
    pos.x = rnd(88) + 20
    pos.y = rnd(88) + 20

    return pos
end