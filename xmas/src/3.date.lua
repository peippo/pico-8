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
        local x = 18

        if days_to_go > 99 then
            x = 25
        elseif days_to_go > 9 then
            x = 22
        end

        cursor(x, 75)
        print(days_to_go == 1 and "day to go!!" or "days to go!", 6)
    end
end
