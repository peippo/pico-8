pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
-- xmas is coming
-- by peippo

function _init()
    flakes = {}
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
    print_days_to_go()

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
-->8
-- snow flakes

function add_flake()
    add(flakes, {
        x = random(-128 - 64, 128 + 64),
        y = -5,
        size = rnd(2),
        color = rnd(flake_colors),
        draw = function(self)
            circfill(self.x, self.y, self.size, self.color)
        end,
        update = function(self, wind)
            self.x = self.x + wind + sin(time() * rnd(3))
            self.y += rnd(2)

            if (self.y > 128) then
                del(flakes, self)
            end
        end
    })
end

function randomize_wind()
    change_wind = time() % 5 == 0

    if change_wind then
        wind = rnd(wind_speeds)
    end
end
-->8
-- logo

function draw_logo()
    for i = 0, 4 do
        t1 = t() * 30 + i * 4
        
        -- shadow
        x = i * 32 + cos(t1 / 90) * 3
        y = 34 + cos(t1 / 50) * 3 + 3

        pal(2, 0)
        pal(14, 0)
        pal(15, 0)
        sspr(i * 32, 64, 32, 32, x + 1, y)
        pal()

        -- foreground
        y = 34 + cos(t1 / 50) * 4

        sspr(i * 32, 64, 32, 32, x, y)

    end
end
-->8
--date
function calculate_days()
    local year = stat(90)
    local month = stat(91)
    local day = stat(92)
    local xmas_day_number = 359
    local days_in_months = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}

    -- check if leap year
    if (year % 4 ~= 0) then
        leap = false
    elseif (year % 100 ~= 0) then
        leap = true

    elseif (year % 400 ~= 0) then
        leap = false
    else
        leap = true
    end

    if (leap) then
        xmas_day_number = 360
        days_in_months[2] = 29
    end

    days_passed = 0

    for i = 1, month do
        if i < month then
            days_passed += days_in_months[i]
        end
    end

    days_passed += day

    return xmas_day_number - days_passed
end

function print_days_to_go()
    if days_to_go == 0 then
        cursor(18, 75)
        print("is today!!", 14)
    elseif days_to_go < 0 then
        color(13)
        cursor(6, 74)
        print("is fading away...", 13)
    else
        -- shadow
        cursor(10, 76)
        print(days_to_go, 0)

        -- days number
        cursor(10, 75)
        print(days_to_go, 14)

        -- text
        x = 18

        if days_to_go > 99 then
            x = 25
        elseif days_to_go > 9 then
            x = 22
        end

        cursor(x, 75)
        print(days_to_go == 1 and "day to go!!" or "days to go!", 6)
    end
end
-->8
-- utility functions

function random(a, b)
    if (a > b) a, b = b, a
    return a + flr(rnd(b - a + 1))
end
__gfx__
00000000000000006666666666666666666666666666666600000000000000000000000000000000000001111110000000000000000000000000000000000000
00000000000000007777777777777777777777777777777700006660000000000000000060666600000111111111100000000000000000000000000000000000
00000000343343437776777667667776666777666677666600066676d06660000006600666766660001111111111110000000000000000000000000000000000
00000000666666665655676556556765556666655566555500666777666676000066760067776660011111111111111000000000000000000000000000000000
000000006d5656d545445652455556544445665444555744dd666676666777000067776656766660011111111111111000000000000000000000000000000000
0000000055656d56244e45222477454424245544244466620d666666666676000006756665666660111111111111111100000000000000000000000000000000
00000000505505554422244244666444422254244644565400066666d06660000000666666666600111111111111111100000000000000000000000000000000
00000000000000004442444444565444442444444544454400006665600dddd0ddd00566765dd000111111111111111100000000000000000000000000000000
0000000000000000444444444444444444444444444444440000055766ddd20000dd665777d26600111111110000000110000000000000000000000000000000
0000000000000000444444444444444444444244444444440000067776d200000006676d7d066760111111110000001111000000000000000000000000000000
000000000000000044444244467442444444222444e4444400000667662000000006666dd0066660111111110000011111100000000000000000000000000000
00000000000000004244444446644444444442444222444400000066600000000000660dd0dd6600111111110000111111110000000000000000000000000000
000000000000000022244424455444242444444444244644000000ddd00000000000000ddd200000111111110001111111111000000000000000000000000000
0000000000000000424424444444244244242444444445420000000ddd0000000000000ddd000000111111110011111111111100000000000000000000000000
0000000000000000444444424444444442444444424244440000000ddd200000000000dd20000000111111110111111111111110000000000000000000000000
0000000000000000244444242444444444444424244444240000000ddd200000000000dd20000000111111111111111111111111000000000000000000000000
00000000000000000006666666666000244444444444444000000d0000077000000000000000000000000dddddd0000000000000000000000000000000000000
00000000000000000677777777777770024442444424442000066d00007067000000000000000000000dddddddddd00000000000000000000000000000000000
0000000000000000077677766667776000442224422244000066760000669990000000000000000000dddddddddddd0000000000000000000000000000000000
000000000000000056556765556666650024424444244200006666dd0006600000000000000000000dddddddddddddd000000000000000000000000000000000
000000000000000045445652444566540024444444444200d0066d00f005500f00000000000000000dddddddddddddd000000000000000000000000000000000
0000000000000000244e45222424554202242444444242200dd0d200047777400000000000000000dddddddddddddddd00000000000000000000000000000000
000000000000000044222442422254240244444444444420002dd000076666700000000000000000dddddddddddddddd00000000000000000000000000000000
0000000000000000244244444424444202444444444444200000d000066666600000000000000000dddddddddddddddd00000000000000000000000000000000
00000000000000000000000000000000024444444444442000000000000000000000000000000000dddddddd0000000dd0000000000000000000000000000000
00000000000000000000000000000000024444444444442000000000000000000000000000000000dddddddd000000dddd000000000000000000000000000000
0000000000000000000000000000000002e4444444444e2000000000000000000000000000000000dddddddd00000dddddd00000000000000000000000000000
00000000000000000000000000000000022244444444222000000000000000000000000000000000dddddddd0000dddddddd0000000000000000000000000000
00000000000000000000000000000000022446444464422000000000000000000000000000000000dddddddd000dddddddddd000000000000000000000000000
00000000000000000000000000000000002445422454420000000000000000000000000000000000dddddddd00dddddddddddd00000000000000000000000000
00000000000000000000000000000000002444444444420000000000000000000000000000000000dddddddd0dddddddddddddd0000000000000000000000000
00000000000000000000000000000000004444444444440000000000000000000000000000000000dddddddddddddddddddddddd000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000009995000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000099999992222000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000009999999922222220202000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000999999992222222220202020000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000099999999222222220202020200000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000009999999922222222020202020000000000000000000000000000000000000000000000000000000000000000000
00000000000007779999000000000000059992222222202020202000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000aaa9999000000000000022220202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000994440000000000000002020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000994440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000077777777777770000000000000000000000000000000000000000000000000000009995000000000000000000000000000000000000000000000000
00000000729766666666666000000000000000000000000000000000000000000000099999992222000000000000000000000000000000000000000000000000
00000007299976666676676600000000000000000000000000000000000009999999922222220202000000000000000000000000000000000000000000000000
00000072999997666666777660000000000000000000000000000999999992222222202020200000000000000000000000000000000000000000000000000000
00000729999999766666676666000000000000000000099999999222222220202020200000000000000000000000000000000000000000000000000000000000
00007299922999976666666676600000000009999999922222222020202020000000000000000000000000000000000000000000000000000000000000000000
00072999244299997666666767660000599992222222202020202000000000000000000000000000000000000000000000000000000000000000000000000000
00729999444499999766666676666000222220202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000
07299999a44a99999976667666666600202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
729999999aa999999997666666676660000000000000000000000000000000000000000000099950000000000000000000000000000000000000000000000000
29999999999999999999766666666666000000000000000000000000000000000009999999922220000000000000000000000000000000000000000000000000
09999994444449949992222222222220000000000000000000000000000099999992222222200000000000000000000000000000000000000000000000000000
09999494222249994994444444444440000000000000000000000999999922222220000000020200000000000000000000000000000000000000000000000000
09949994222249499492444444244240000000000000099999999222222200000000202020202000000000000000000000000000000000000000000000000000
09494944242249994944242444442420000000099999922222222000000002020202020202020200000000000000000000000000000000000000000000000000
04949494222249949492424242424240009999922222222222222222222222222222222222222200000000000000000000000000000000000000000000000000
eeeeeeeeeee0000000000000000000002eeeee000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeee00000000eeeeeeeeeeeeeeeeeeeeeeeeee00
efffffffffe0000000000000000000002efffee000000000000000000000000000eeeffffffffffffffffffffffeee0000eeeffffffffffffffffffffffffe00
efeeeeeeefe0000000000eeeeeeeeeee2efeefee0000000000000000eeeeeeee0eeffeeeeeeeeeeeeeeeeeeeeeeffee00eeffeeeeeeeeeeeeeeeeeeeeeeefe00
efeeeeeeefe0000000000efffffffffe2efeeefee00000000000000eeffffffe0efeeeeeeeeeeeeeeeeeeeeeeeeeefe00efeeeeeeeeeeeeeeeeeeeeeeeeefe00
efeeeeeeefe0000000000efeeeeeeefe2efeeeefee000000000000eefeeeeefe2eeeeeeeeeeeeeeeeeeeeeeeeeeeefee2efeeeeeeeeeeeeeeeeeeeeeeeeefe00
efeeeeeeeee0000000000efeeeeeeefe2efeeeeefee0000000000eefeeeeeefe2efeeeeeeeeeeeeeeeeeeeeeeeeeeefe2efeeeeeeeeeeeeeeeeeeeeeeeeefe00
efeeeeeeefe0000000000efeeeeeeefe2efeeeeeeeee00000000eefeeeeeeefe2eeeeeeeeeeeeeeeeeeeeeeeeeeeeefe2efeeeeeeeeeeeeeeeeeeeeeeeeefe00
eeeeeeeeeee0000000000eeeeeeeeefe2efeeeeeeefee000000eefeeeeeeeefe2eeeeeeeeeeeeeeeeeeeeeeeeeeeeefe2eeeeeeeeeeeeeeeeeeeeeeeeeeeee00
efeeeeeeeee0000000000eeeeeeeeeee2efeeeeeeeeeee0000eeeeeeeeeeeefe2eeeeeeeeee0000000000eeeeeeeeeee2eeeeeeeeeeeeeeeeeeeeeeeeeeefe00
eeeeeeeeeeee00000000eeeeeeeeeefe2eeeeeeeeeeeeee00eefeeeeeeeeeefe2eeeeeeeeee0000000000eeeeeeeeefe2eeeeeeeeeeeeeeeeeeeeeeeeeeeee00
eeeeeeeeeeee00000000eeeeeeeeeeee2efeeeeeeeeeeeeeeeeeeeeeeeeeeefe2eeeeeeeeee0000000000eeeeeeeeeee2eeeeeeeeee000000000000000000000
eeeeeeeeeeeee000000eeeeeeeeeeeee2efeeeeeeeeeeeeeeeeeeeeeeeeeeefe2eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2eeeeeeeeeeeeeeeeeeeeeeeeeee0000
eeeeeeeeeeeeeee00eeeeeeeeeeeeeee2eeeeeeeeeeeeeeeeeeeeeeeeeeeeefe2eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2eeeeeeeeeeeeeeeeeeeeeeeeeeeee00
0eeeeeeeeeeeeeeeeeeeeeeeeeeeeee02eeeeeeeeeeeeeeeeeeeeeeeeeeeeefe2eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2eeeeeeeeeeeeeeeeeeeeeeeeeeeeee0
0eeeeeeeeeeeeeeeeeeeeeeeeeeeeee02efeeeeeeeeeeeeeeeeeeeeeeeeeeeee2eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2eeeeeeeeeeeeeeeeeeeeeeeeeeeeee0
00eeeeeeeeeeeeeeeeeeeeeeeeeeee002eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
00eeeeeeeeeeeeeeeeeeeeeeeeeeee002eeeeeeeeeeeeeeeeeeeeeeeeeeeeefe2eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
0eeeeeeeeeeeeeeeeeeeeeeeeeeeeee02eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2eeeeeeeefeeeeeeeeeeeeeeeeeeeeee0eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
0eeeeeeeeeeeeeeeeeeeeeeeeeeeeee02eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2eeeeeeeeeeeeeeeeeeeeefeeeeeeeee0eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeffeeeeee00eeeeeeeeeeeeeee2eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2eeeeeffeee0000000000fffeeeeeeee00eeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeffffeee000000eeeeeeeeeeeee2eeeeeeeeeeeeeeeeeeeeeeeefeeeeee2eefeffffee0000000000efeeeeefeee0000eeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeffffee00000000eeeeeefeeeee2effeeefeeeeeeeeeeeeeeeefffeeeee2eeeeffffee0000000000eeeeffeeeee0000000000000000000000000efffeee
eeffeeeffeee00000000eeeefeeeeeee2ffffeeeeee0eefeefee0eeeefeeeeee2eeeeeffeef0000000000eeeffffeeee2eeeeeeeeeefffeeeeeeeeeeefffffee
eeffeeeeeee0000000000eefffeeeeee2ffffeeeeee00eeefff00ffeeeeeefee2efeeeeeeff0000000000feeffffeffe2eeeeeeeeeeefeeeeeffeeeeefffffee
eeeeefffeee0000000000eeefeeeeeee2effeeeffee000eeef000fffeeffeeee2fffefffeef0000000000fffeffeeffe2eefeeefeeeeeeeeeffffeeeefffffee
eeeefffffee0000000000eeeeeeffefe2eeeeeffffe0000ee0000fffeffffeee2efefffffee0000000000ffffeeeeeee2efffeeeeeeeeeeeeffffeeeeefffeee
effefffffee0000000000eeeeeffffee2fffeeffffe0000000000ffeeffffeee2eeefffffee0000000000fffffeeffee2eefeeeeeeeeeeffeeffeeeeeeeeeeee
fffffffffee0000000000efffeffffee2ffffeeffee0000000000eeeeeffeeff2ffefffffee0000000000fffffeffffe2eeeeefffeeeeffffeeeeeefeefeeeee
ffffefffeff0000000000fffffeffeee2ffffeeeeee0000000000eeffffeefff2fffefffeef0000000000fffffeffffe2eeefffffffeeffffeeeeeeeefffeef0
effeeeeeeff0000000000fffffeeefff2ffffeeeffe0000000000effffffefff2fffeeeeeff0000000000ffffeeeffee2eeefffffffeeeffeeeefffeeefeeff0
000000000000000000000fffffeeffff000000000000000000000effffffefff000000000000000000000000000000002eefffffffffeeeeeeefffffeeeeef00
000000000000000000000efffeeeffff000000000000000000000effffffeeff000000000000000000000000000000002eefffffffffeeeeeeefffffeeee0000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000001b1a1a0b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000a1c00000000001a1a1a1a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000a1a0b001a1a000000000a1a1a1a1a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000400000000000001a1a1a1b1a1a0a1a1a1c1a1a1a1a1a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000001a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000001a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000051520000001a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000006061626300001a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000007071727300001a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a00000000002a3a2b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000220504020323001a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a000000003b3a3a3a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000241414121525001a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a002a3c3b3a3a3a3a2b000000002a2b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000809000607000000121414131235001a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a3b3a3a3a3a3a3a3a3a000000003a3a2b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001819261617270000341312151225001a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a3a3a3a3a3a3a3a3a3a3c0000003a3a3a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
020503020304020404050402030402051a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a3a3a3a3a3a3a3a3a3a3a0000003a3a3a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
151214121514131215121412121512141a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

