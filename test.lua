function split(inputstr)
    local t = {}
    for char in inputstr:gmatch(".") do
        table.insert(t, char)
    end
    return t
end

for i, v in ipairs(split("hello")) do
    print(i)
    print(v)
end