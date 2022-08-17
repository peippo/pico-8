-- logo

function draw_logo()
    for i = 0, 4 do
        local t1 = t() * 30 + i * 4
        
        -- shadow
        local x = i * 32 + cos(t1 / 90) * 3
        local y = 34 + cos(t1 / 50) * 3 + 3

        pal(2, 0)
        pal(14, 0)
        pal(15, 0)
        sspr(i * 32, 64, 32, 32, x + 1, y)
        pal()

        -- foreground
        y = 34 + cos(t1 / 50) * 4

        sspr(i * 32, 64, 32, 32, x, y)
    end
end