--sushi-worm

function _init()
    worm = init_worm()
end

function _update()
    worm:update()
end

function _draw()
    cls(1)
    worm:draw()
end
