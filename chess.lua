board = {{"[R]", "[N]", "[B]", "[Q]", "[K]", "[B]", "[N]", "[R]"},
         {"[P]", "[P]", "[P]", "[P]", "[P]", "[P]", "[P]", "[P]"},
         {"| |", "| |", "| |", "| |", "| |", "| |", "| |", "| |"}, 
         {"| |", "| |", "| |", "| |", "| |", "| |", "| |", "| |"},
         {"| |", "| |", "| |", "| |", "| |", "| |", "| |", "| |"},
         {"| |", "| |", "| |", "| |", "| |", "| |", "| |", "| |"},
         {"{P}", "{P}", "{P}", "{P}", "{P}", "{P}", "{P}", "{P}"}, 
         {"{R}", "{N}", "{B}", "{Q}", "{K}", "{B}", "{N}", "{R}"}}

whitePieces = {"{P}", "{N}", "{B}", "{R}", "{Q}"}
blackPieces = {"[P]", "[N]", "[B]", "[R]", "[Q]"}
letterToNumber = {["A"] = 1,
                  ["B"] = 2,
                  ["C"] = 3, 
                  ["D"] = 4, 
                  ["E"] = 5,
                  ["F"] = 6,
                  ["G"] = 7,
                  ["H"] = 8}

-- Prints the grid
function printGrid(grid)
    io.write("  /-----------------------------------------------\\")
    for i = 1, 8 do
        io.write("\n")  
        io.write("".. 9-i .." | ")
        for j = 1, 8 do
            io.write(grid[i][j] .. " | ")
        end
        io.write("\n") 
        if i ~= 8 then
            io.write("  |-----|-----|-----|-----|-----|-----|-----|-----|")
        end
    end
    io.write("  \\-----------------------------------------------/")
    io.write("\n")
    io.write("     A     B     C     D     E     F     G     H")
    io.write("\n") 
    io.write("\n") 
end

function split(inputstr)
    local t = {}
    for char in inputstr:gmatch(".") do
        table.insert(t, char)
    end
    return t
end

function countOccurrences(str, sub)
    local _, count = string.gsub(str, sub, "")
    return count
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

-- CHECK FOR SQUARE DEFENDED
function squareDefended(grid)
    return false
end

function replace(grid, x1, y1, x2, y2)
    grid[y2][x2] = grid[y1][x1]
    grid[y1][x1] = "| |"
    return true, grid
end

-- QUEEN MOVE
function moveQueen(grid, x1, y1, x2, y2)
    xMovement, yMovement = math.abs(x2 - x1), math.abs(y2 - y1)
    if (xMovement == yMovement or xMovement == 0 or yMovement == 0) and not (xMovement == 0 and yMovement == 0) then
        return replace(grid, x1, y1, x2, y2)
    else return false, grid end
end

-- KING MOVE
function moveKing(grid, x1, y1, x2, y2)
    xMovement, yMovement = math.abs(x2 - x1), math.abs(y2 - y1)
    if (xMovement == 1 or xMovement == 0) and (yMovement == 1 or yMovement == 0) and not (xMovement == 0 and yMovement == 0) then
        return replace(grid, x1, y1, x2, y2)
    else return false, grid end
end

-- BISHOP MOVE
function moveBishop(grid, x1, y1, x2, y2)
    xMovement, yMovement = math.abs(x2 - x1), math.abs(y2 - y1)
    if xMovement == yMovement and not (xMovement == 0 and yMovement == 0) then
        return replace(grid, x1, y1, x2, y2)
    else return false, grid end
end

-- KNIGHT MOVE
function moveKnight(grid, x1, y1, x2, y2)
    xMovement, yMovement = math.abs(x2 - x1), math.abs(y2 - y1)
    if (xMovement == 2 and yMovement == 1) or (yMovement == 2 and xMovement == 1) then
        return replace(grid, x1, y1, x2, y2)
    else return false, grid end
end

-- ROOK MOVE
function moveRook(grid, x1, y1, x2, y2)
    xMovement, yMovement = math.abs(x2 - x1), math.abs(y2 - y1)
    if (xMovement == 0 or yMovement == 0) and not (xMovement == 0 and yMovement == 0) then
        return replace(grid, x1, y1, x2, y2)
    else return false, grid end
end

-- PAWN MOVE
function movePawn(grid, x1, y1, x2, y2)
    xMovement, yMovement = math.abs(x2 - x1), math.abs(y2 - y1)
    -- First Move
    if grid[y1][x1] == "{P}" and y1 == 7 and x2 == x1 and y2 == 5 then 
        return replace(grid, x1, y1, x2, y2)
    elseif grid[y1][x1] == "[P]" and y1 == 2 and x2 == x1 and y2 == 4 then 
        return replace(grid, x1, y1, x2, y2)
    else
        -- Basic Move
        print(countOccurrencesList(blackPieces, grid[y2][x2]))
        if ((x1 == x2 and y1-y2 == 1 and grid[y1][x1] == "{P}") or (x1 == x2 and y2-y1 == 1 and grid[y1][x1] == "[P]")) and grid[y2][x2] == "| |" then
            return replace(grid, x1, y1, x2, y2)
        elseif (xMovement == 1 and y1-y2 == 1 and grid[y1][x1] == "{P}" and countOccurrencesList(blackPieces, grid[y2][x2]) == 1) or (xMovement == 1 and y2-y1 == 1 and grid[y1][x1] == "[P]" and countOccurrencesList(whitePieces, grid[y2][x2]) == 1) then
            return replace(grid, x1, y1, x2, y2)
        else return false, grid end
    end
end

-- CHECK PROMOTION
function checkPromotion(grid)
    for i = 1, 8 do
        if grid[1][i] == "{P}" then
            print("Choose the piece you want to promote into (N, B, R, Q)")
            promotion = string.upper(io.read())
            if promotion == "N" then grid[1][i] = "{N}" end
            if promotion == "B" then grid[1][i] = "{B}" end
            if promotion == "R" then grid[1][i] = "{R}" end
            if promotion == "Q" then grid[1][i] = "{Q}" end
        end
        if grid[8][i] == "[P]" then
            print("Choose the piece you want to promote into (N, B, R, Q)")
            promotion = string.upper(io.read())
            if promotion == "N" then grid[1][i] = "[N]" end
            if promotion == "B" then grid[1][i] = "[B]" end
            if promotion == "R" then grid[1][i] = "[R]" end
            if promotion == "Q" then grid[1][i] = "[Q]" end
        end
    end
    return grid
end

-- CASTLE

-- MOVE
function movePiece(grid, piece, x1, y1, x2, y2)
    if piece == "{K}" or piece == "[K]" then return moveKing(grid, x1, y1, x2, y2) end
    if piece == "{Q}" or piece == "[Q]" then return moveQueen(grid, x1, y1, x2, y2) end
    if piece == "{B}" or piece == "[B]" then return moveBishop(grid, x1, y1, x2, y2) end
    if piece == "{N}" or piece == "[N]" then return moveKnight(grid, x1, y1, x2, y2) end
    if piece == "{R}" or piece == "[R]" then return moveRook(grid, x1, y1, x2, y2) end
    if piece == "{P}" or piece == "[P]" then return movePawn(grid, x1, y1, x2, y2) end
    return false, grid
end

-- CHECK for CHECK

-- CHECK for CHECKMATE

-- CHECK for STALEMATE

-- Main Loop
print("Press P to Play")
P = string.upper(io.read())
if P == "P" then
    printGrid(board)
    while true do
        -- White's Move
        repeat
            success = false
            print("[WHITE] Move a piece [e.g E5D4]")
            input = io.read()
            a, b, c, d = split(input)[1], split(input)[2], split(input)[3], split(input)[4] 
            a, b, c, d = string.upper(a), tonumber(b), string.upper(c), tonumber(d)
            a, c = letterToNumber[a], letterToNumber[c]
            print(a, b, c, d)
            b, d = 9 - b, 9 - d
            if not (a >= 9 or a <= 0 or b >= 9 or b <= 0 or c >= 9 or c <= 0 or d >= 9 or d <= 0) then
                if countOccurrences(board[b][a], "%{") == 1 then
                    success, board = movePiece(board, board[b][a], a, b, c, d)
                    board = checkPromotion(board)
                    printGrid(board)
                end
            end
        until success
        -- Black's Move
        repeat
            success = false
            print("[BLACK] Move a piece [e.g E5D4]")
            a, b, c, d = io.read("*n","*n","*n","*n")
            b, d = 9 - b, 9 - d
            if not (a >= 9 or a <= 0 or b >= 9 or b <= 0 or c >= 9 or c <= 0 or d >= 9 or d <= 0) then
                if countOccurrences(board[b][a], "%[") == 1 then
                    success, board = movePiece(board, board[b][a], a, b, c, d)
                    board = checkPromotion(board)
                    printGrid(board)
                end
            end
        until success
    end
end
        