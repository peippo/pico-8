-- xmas is coming
-- by peippo

function _init()
    flakes = {}
    flake_colors = {5, 6, 7}
end
   
function _draw()
    cls(1)
    
    add_flake();

    for flake in all(flakes) do
        flake:draw()
    end
end

function _update60()
    for flake in all(flakes) do
        flake:update()
    end
end
