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
    map(0,0,0,0,16,16)
    worm:draw()
    sushi:draw()
end
