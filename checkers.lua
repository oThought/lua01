board = {{"[ ]", "{B}", "[ ]", "{B}", "[ ]", "{B}", "[ ]", "{B}"},
         {"{B}", "[ ]", "{B}", "[ ]", "{B}", "[ ]", "{B}", "[ ]"}, 
         {"[ ]", "{B}", "[ ]", "{B}", "[ ]", "{B}", "[ ]", "{B}"}, 
         {"{ }", "[ ]", "{ }", "[ ]", "{ }", "[ ]", "{ }", "[ ]"}, 
         {"[ ]", "{ }", "[ ]", "{ }", "[ ]", "{ }", "[ ]", "{ }"},
         {"{W}", "[ ]", "{W}", "[ ]", "{W}", "[ ]", "{W}", "[ ]"}, 
         {"[ ]", "{W}", "[ ]", "{W}", "[ ]", "{W}", "[ ]", "{W}"},
         {"{W}", "[ ]", "{W}", "[ ]", "{W}", "[ ]", "{W}", "[ ]"}}

function contains(list, x)
    for _, value in ipairs(list) do
        if value == x then
            return true
        end
    end
    return false
end

-- Prints the grid
function printGrid(grid)
    io.write("/-----------------------------------------------\\")
    for i = 1, 8 do
        io.write("\n")  
        io.write("| ")
        for j = 1, 8 do
            io.write(grid[i][j] .. " | ")
        end
        io.write("\n") 
        if i ~= 8 then
            io.write("|-----|-----|-----|-----|-----|-----|-----|-----|")
        end
    end
    io.write("\\-----------------------------------------------/")
    io.write("\n") 
    io.write("\n") 
end

function checkPromotion(grid)
    for i = 1, 8 do
        if grid[1][i] == "{W}" then
            grid[1][i] = "{Q}"
        end
        if grid[8][i] == "{B}" then
            grid[8][i] = "{K}"
        end
    end
    return grid
end

-- Takes (board, a, b, c, d)
-- [a, b] is position of piece, [c, d] is movement of piece
function move(grid, a, b, c, d, colour)
    a, c = 9-a, -c
    adjacent = grid[a + c * ((math.abs(c)-1) / math.abs(c))][b + d * ((math.abs(d)-1) / math.abs(d))]
    current = grid[a][b]
    if not (c/d == 1 or c/d == -1) then
        return false, grid
    end
    if current == "{W}" or current == "{Q}" then opposite = {"{B}", "{K}"}
    elseif current == "{B}" or current == "{K}" then opposite = {"{W}", "{Q}"}
    else return false, grid end
    if current == "{W}" and c >= 0 then return false, grid end
    if current == "{B}" and c <= 0 then return false, grid end
    if (c > 2 or c < -2) then return false, grid end
    if colour == "white" and (not contains({"{W}", "{Q}"}, current)) then return false, grid end
    if colour == "black" and (not contains({"{B}", "{K}"}, current)) then return false, grid end
    destination = grid[a + c][b + d]
    if destination == "{ }" and (adjacent == current or contains(opposite, adjacent)) then
        grid[a + c][b + d] = current
        grid[a + c * ((math.abs(c)-1) / math.abs(c))][b + d * ((math.abs(d)-1) / math.abs(d))] = "{ }"
        grid[a][b] = "{ }"
    else 
        return false, grid
    end
    return true, checkPromotion(grid)
end

-- Checks for a win or loss
function checkOutput(grid)
    whiteTotal = 0
    blackTotal = 0
    for i = 1, 8 do
        for j = 1, 8 do
            if grid[i][j] == "{W}" then whiteTotal = whiteTotal + 1 end
            if grid[i][j] == "{B}" then blackTotal = blackTotal + 1 end
        end
    end
    if whiteTotal == 0 then
        print("Black Wins!")
        return True
    end
    if blackTotal == 0 then
        print("White Wins!")
        return True
    end
end

-- Main Loop
print("Press P to Play")
P = io.read()
if P == "P" then
    printGrid(board)
    while not checkOutput(board) do
        -- White's Move
        repeat
            print("[White] enter location and movement, e.g 3311:")
            a, b, c, d = io.read("*n","*n","*n","*n")
            success, board = move(board, a, b, c, d, "white")
        until success
        printGrid(board)
        -- Win Check
        if checkOutput(board) then
            break
        end
        -- Black's Move
        repeat
            print("[Black] enter location and movement, e.g 3311:")
            a, b, c, d = io.read("*n","*n","*n","*n")
            success, board = move(board, a, b, c, d, "black")
        until success
        printGrid(board)
    end
end