-- xmas is coming
-- by peippo

function _init()
    flakes = {}
    ground_flakes = {}
    snowman = make_snowman()
    flake_colors = {5, 6, 7}
    wind_speeds = {-0.4, -0.2, 0, 0.2, 0.4}
    wind = rnd(wind_speeds)
    days_to_go = calculate_days()
end
   
function _draw()
    cls(0)
    
    --background
    map(16,0,0,0,16,16)

    --middleground
    pal(13, 0)
    map(32,0,0,0,16,16)
    pal()

    draw_logo()
    
    --foreground
    map(0,0,0,0,16,16)
    --stairs
    sspr(32, 32, 48, 32, 72, 80)
    
    add_flake()
    snowman:draw()
    print_days_to_go()

    for flake in all(flakes) do
        flake:draw()
    end

    for flake in all(ground_flakes) do
        flake:draw()
    end
end

function _update60()
    randomize_wind()
    snowman:update()

    for flake in all(flakes) do
        flake:update(wind)
    end

    for flake in all(ground_flakes) do
        flake:update()
    end
end
