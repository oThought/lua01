board = {{"[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]"},
         {"[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]"}, 
         {"[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]"}, 
         {"[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]"}, 
         {"[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]"}, 
         {"[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]"}}

 -- Prints the grid
function printGrid(grid)
    io.write("-------------------------------")
    for i = 1, 6 do
        io.write("\n")  -- Newline after the closing |
        io.write("| ")
        for j = 1, 7 do
            -- Print each element with a space in between
            io.write(grid[i][j] .. " ")
            if j == 7 then
                io.write("|")  -- Print the starting | of the next row except for the last row
            end
        end
    end
    io.write("\n")
    io.write("-------------------------------\n")
end

function countOccurrencesList(list, target)
    local count = 0
    for i = 1, #list do
        if list[i] == target then
            count = count + 1
        end
    end
    return count
end

-- The player's move
function playerMove(grid, move, player)
    for k = 6, 1, -1 do
        if grid[k][move] == "[ ]" then
            grid[k][move] = player
            return true, grid
        end
    end
    return false, grid
end

-- Checks a line, returns win, loss or draw
function checkLine(line)
    if line == "[X][X][X][X]" then
        print("Player X Wins!")
        return true
    end
    if line == "[O][O][O][O]" then
        print("Player O Wins!")
        return true
    end
    return false
end

-- Check Top Right Diagonal
function checkTopRight(grid, a, b)
    local line = ""
    for row = a, a-3, -1 do
        column = b + a - row
        line = line .. grid[row][column]
    end
    return checkLine(line)
end
-- Check Top Left Diagonal
function checkTopLeft(grid, a, b)
    local line = ""
    for row = a, a-3, -1 do
        column = b - a + row
        line = line .. grid[row][column]
    end
    return checkLine(line)
end
-- Check Bottom Right Diagonal
function checkBottomRight(grid, a, b)
    local line = ""
    for row = a, a+3 do
        column = b - a + row
        line = line .. grid[row][column]
    end
    return checkLine(line)
end
-- Check Bottom Left Diagonal
function checkBottomLeft(grid, a, b)
    local line = ""
    for row = a, a+3 do
        column = b + a - row
        line = line .. grid[row][column]
    end
    return checkLine(line)
end
-- Check Left Horizontal
function checkHorizontalLeft(grid, a, b)
    local line = ""
    for i = 1, 4 do
        column = b - i + 1
        line = line .. grid[a][column]
    end
    return checkLine(line)
end
-- Check Up
function checkUp(grid, a, b)
    local line = ""
    for row = a, a-3, -1 do
        line = line .. grid[row][b]
    end
    return checkLine(line)
end
-- Check Down
function checkDown(grid, a, b)
    local line = ""
    for row = a, a+3 do
        line = line .. grid[row][b]
    end
    return checkLine(line)
end

-- Checks for a draw
function checkDraw(grid)
    for i = 1, 6 do
        if countOccurrencesList(grid[i], "[ ]") == 0 then
            return true
        end
    end
    return false
end

-- Checks for a win, loss or draw
function checkOutput(grid)
    if checkDraw(grid) then
        print("Draw!")
        return true
    end
    if checkTopRight(grid, 4, 1) or checkTopRight(grid, 4, 2) or checkTopRight(grid, 4, 3) or checkTopRight(grid, 4, 4) then
        return true
    end
    if checkTopLeft(grid, 4, 7) or checkTopLeft(grid, 4, 6) or checkTopLeft(grid, 4, 5) or checkTopLeft(grid, 4, 4) then
        return true
    end
    if checkBottomRight(grid, 3, 1) or checkBottomRight(grid, 3, 2) or checkBottomRight(grid, 3, 3) or checkBottomRight(grid, 3, 4) then
        return true
    end
    if checkBottomLeft(grid, 3, 7) or checkBottomLeft(grid, 3, 6) or checkBottomLeft(grid, 3, 5) or checkBottomLeft(grid, 3, 4) then
        return true
    end
    if checkUp(grid, 4, 1) or checkUp(grid, 4, 2) or checkUp(grid, 4, 3) or checkUp(grid, 4, 4) or checkUp(grid, 4, 5) or checkUp(grid, 4, 6) or checkUp(grid, 4, 7) then
        return true
    end
    if checkDown(grid, 3, 1) or checkDown(grid, 3, 2) or checkDown(grid, 3, 3) or checkDown(grid, 3, 4) or checkDown(grid, 3, 5) or checkDown(grid, 3, 6) or checkDown(grid, 3, 7) then
        return true
    end
    if checkHorizontalLeft(grid, 1, 4) or checkHorizontalLeft(grid, 2, 4) or checkHorizontalLeft(grid, 3, 4) or checkHorizontalLeft(grid, 4, 4) or checkHorizontalLeft(grid, 5, 4) or checkHorizontalLeft(grid, 6, 4) then
        return true
    end
    if checkHorizontalLeft(grid, 1, 5) or checkHorizontalLeft(grid, 2, 5) or checkHorizontalLeft(grid, 3, 5) or checkHorizontalLeft(grid, 4, 5) or checkHorizontalLeft(grid, 5, 5) or checkHorizontalLeft(grid, 6, 5) then
        return true
    end
    if checkHorizontalLeft(grid, 1, 6) or checkHorizontalLeft(grid, 2, 6) or checkHorizontalLeft(grid, 3, 6) or checkHorizontalLeft(grid, 4, 6) or checkHorizontalLeft(grid, 5, 6) or checkHorizontalLeft(grid, 6, 6) then
        return true
    end
    if checkHorizontalLeft(grid, 1, 7) or checkHorizontalLeft(grid, 2, 7) or checkHorizontalLeft(grid, 3, 7) or checkHorizontalLeft(grid, 4, 7) or checkHorizontalLeft(grid, 5, 7) or checkHorizontalLeft(grid, 6, 7) then
        return true
    end
end 

-- Main Loop
print("Press P to Play")
P = io.read()
if P == "P" then
    printGrid(board)
    while not checkOutput(board) do
        -- Player X Move
        repeat
            print("[X] Enter Column e.g 4:")
            coordinate = tonumber(io.read())
            success, board = playerMove(board, coordinate, "[X]")
        until success
        printGrid(board)
        -- Win Check
        if checkOutput(board) then
            break
        end
        -- Player O Move
        repeat
            print("[O] Enter Column e.g 4:")
            coordinate = tonumber(io.read())
            success, board = playerMove(board, coordinate, "[O]")
        until success
        printGrid(board)
    end
end