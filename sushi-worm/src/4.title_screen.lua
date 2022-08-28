-- title screen

title_screen = {
    draw = function(self)
        cls(15)
        map(32,0,0,0,16,16)
        print("press \151 to start", 33, 116, 1)

        circfill(60, 118, 2, 0)
        local timer = t() - flr(t())
        print("\151", 57, timer > 0.5 and 115 or 116, 14)

        -- blinking
        if (timer > 0.2) then
            circfill(76, 90, 3, 0)
            circfill(85, 92, 3, 0)
        else
            line(73, 90, 79, 90, 0)
            line(82, 92, 88, 92, 0)
        end

        line(80, 102, 85, 102, 0)

        if (btn(5)) state = "game"
    end,
    update = function(self)
    end
}