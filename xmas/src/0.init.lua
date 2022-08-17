-- xmas is coming
-- by peippo

function _init()
    flakes = {}
    ground_flakes = {}
    smokes = {}
    snowman = make_snowman()
    flake_colors = {5, 6, 7}
    wind_speeds = {-0.4, -0.2, 0, 0.2, 0.4}
    wind = rnd(wind_speeds)
    days_to_go = calculate_days()
    scroller = init_scroller("ho ho ho, it's august and 30^c outside so naturally the first idea for a pico-8 introductory project was to do a christmas countdown! pico-8 is a fantasy video game console that mimics the limited capabilities of 8-bit systems of the 1980s, we have a resolution of 128x128 pixels with 16 colors and four channels for chiptune sounds - seems really fun to play around with, try it out!")
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

    for smoke in all(smokes) do
        smoke:draw()
    end
    
    --foreground
    map(0,0,0,0,16,16)
    --stairs
    sspr(32, 32, 48, 32, 72, 80)
    
    add_flake()
    add_smoke()
    print_days_to_go()
    
    snowman:draw()
    scroller:draw()

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

    for smoke in all(smokes) do
        smoke:update(wind)
    end
end
