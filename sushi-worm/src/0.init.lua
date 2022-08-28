--sushi-worm

function _init()
    state = "title"
    worm = init_worm()
    sushi = init_sushi()
    splatter = init_splatter()
    score = 0
    music(0)
end

function _update()
    if state == "title" then
        title_screen:update()
    end

    if state == "game" then
        worm:update()
        music(-1, 600)
    end
end

function _draw()
    if state == "title" then
        title_screen:draw()
    end

    if state == "game" then
        cls(0)
        
        -- map background
        map(0,0,0,0,16,16)
        
        worm:draw()
        sushi:draw()

        -- map shadows
        for i=8,118,2 do
            pset(i,10,0)
            pset(i+1,11,0)
            pset(9,i+1,0)
            pset(10,i,0)
        end

        -- map borders
        map(16,0,0,0,16,16)
        line(8,8,118,8,4)
        line(8,9,118,9,0)
        line(119,9,119,119,4)
        line(8,9,8,119,0)

        print("sushi worm", 78, 4, 1)
        print("sushi worm", 78, 3, 15)
        print("score " .. score, 10, 4, 1)
        print("score " .. score, 10, 3, 7)

        if not worm.alive then
            game_over_screen:draw()
        end
    end
end
