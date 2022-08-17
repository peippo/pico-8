-- text scroller
-- based on https://demobasics.pixienop.net/

function init_scroller(_text)
    return {
        text = _text,
        x_add = 0,

        speed = 30,
        draw = function(self)
            local t1 = time()

            last_letter_x = (128 + self.x_add - t1 * self.speed) + (#self.text) * 4

            if last_letter_x < 0 then
                self.x_add += 128
                self.x_add += (#self.text) * 4
            end

            for i = 1, #self.text, 1 do
                letter = sub(self.text, i, i)
                letter_t = t1 - (0.1 * i)
                base_x = 128 + self.x_add - t1 * self.speed

                print(letter, base_x + i * 4, 10 + sin(letter_t * 0.5) * 3.9, 13)
            end
        end
    }
end
