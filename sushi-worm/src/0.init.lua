--sushi-worm

function _init()
    worm = init_worm()
    sushi = init_sushi()
end

function _update()
    worm:update()
end

function _draw()
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

    -- debug info
    print(worm.dir, 10, 4, 1)
    print(worm.dir, 10, 3, 15)  
end
