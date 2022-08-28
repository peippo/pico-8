-- game over screen

game_over_screen = {
    draw = function(self)
        local top = 0

        -- adjust position based on death position
        if worm.y < 40 or worm.y > 88 then top = 24
        elseif worm.y < 64 then top = 48 end

        rectfill(64 - 40, 40 - 15 + top, 64 + 38, 40 + 15 + top, 2)
        rectfill(64 - 40, 40 - 15 + top, 64 + 38, 35 + top, 14)
        print("game over!", 45, 28 + top, 2)
        print("\151 restart game", 33, 40 + top, 7)
        print("\131 title screen", 33, 47 + top, 7)

        -- button animations
        local timer = t() - flr(t())
        circfill(35, 42 + top, 2, 0)
        circfill(37, 42 + top, 2, 0)
        print("\151", 33, timer > 0.5 and 39 + top or 40 + top, 14)

        circfill(35, 49 + top, 2, 0)
        circfill(37, 49 + top, 2, 0)
        print("\131", 33, timer < 0.5 and 46 + top or 47 + top, 14)

        if (btn(5)) state = "game"
        if (btn(3)) _init()

        if (btn(5) or btn(3)) then
            worm:reset()
            splatter:reset()
        end
    end
}