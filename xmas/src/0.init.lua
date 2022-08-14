-- xmas is coming
-- by peippo

function _init()
    flakes = {}
    flake_colors = {5, 6, 7}
    wind_speeds = {-0.4, -0.2, 0, 0.2, 0.4}
    wind = rnd(wind_speeds)
end
   
function _draw()
    cls(0)
    
    --background
    map(16,0,0,0,16,16)
    
    --foreground
    map(0,0,0,0,16,16)
    
    add_flake()

    for flake in all(flakes) do
        flake:draw()
    end
end

function _update60()
    randomize_wind()

    for flake in all(flakes) do
        flake:update(wind)
    end
end
