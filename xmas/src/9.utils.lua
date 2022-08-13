-- utility functions

function random(a, b)
    if (a > b) a, b = b, a
    return a + flr(rnd(b - a + 1))
end