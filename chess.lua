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
moves = {{0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0}}

function deepcopy(orig)
    local copies = {} 
    local function _deepcopy(orig)
        if type(orig) ~= 'table' then
            return orig
        end
        if copies[orig] then
            return copies[orig]
        end
        local copy = {}
        copies[orig] = copy
        for k, v in next, orig, nil do
            copy[_deepcopy(k)] = _deepcopy(v)
        end
        setmetatable(copy, _deepcopy(getmetatable(orig)))
        return copy
    end
    return _deepcopy(orig)
end     

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

function within(x, y) 
    if x >= 1 and x <= 8 and y >= 1 and y <= 8 then return true else return false end
end
unchanged = deepcopy(moves)
-- CHECK FOR SQUARE DEFENDED
function squareDefended(grid)
    whiteDefended, blackDefended = deepcopy(unchanged), deepcopy(unchanged)
    for i = 1, 8 do
        for j = 1, 8 do
            if grid[i][j] == "{Q}" then
                SE, S, SW, W, NW, N, NE, E = true, true, true, true, true, true, true, true
                for k = 1,8 do
                    if within(i+k, j+k) and grid[i+k][j+k] == "| |" and SE then whiteDefended[i+k][j+k] = 1 elseif within(i+k, j+k) and grid[i+k][j+k] ~= "| |" and SE then SE, whiteDefended[i+k][j+k] = false, 1 end
                    if within(i+k, j-k) and grid[i+k][j-k] == "| |" and SW then whiteDefended[i+k][j-k] = 1 elseif within(i+k, j-k) and grid[i+k][j-k] ~= "| |" and SW then SW, whiteDefended[i+k][j-k] = false, 1 end
                    if within(i-k, j+k) and grid[i-k][j+k] == "| |" and NE then whiteDefended[i-k][j+k] = 1 elseif within(i-k, j+k) and grid[i-k][j+k] ~= "| |" and NE then NE, whiteDefended[i-k][j+k] = false, 1 end
                    if within(i-k, j-k) and grid[i-k][j-k] == "| |" and NW then whiteDefended[i-k][j-k] = 1 elseif within(i-k, j-k) and grid[i-k][j-k] ~= "| |" and NW then NW, whiteDefended[i-k][j-k] = false, 1 end
                    if within(i, j+k) and grid[i][j+k] == "| |" and W then whiteDefended[i][j+k] = 1 elseif within(i, j+k) and grid[i][j+k] ~= "| |" and W then W, whiteDefended[i][j+k] = false, 1 end
                    if within(i, j-k) and grid[i][j-k] == "| |" and E then whiteDefended[i][j-k] = 1 elseif within(i, j-k) and grid[i][j-k] ~= "| |" and E then E, whiteDefended[i][j-k] = false, 1 end
                    if within(i-k, j) and grid[i-k][j] == "| |" and S then whiteDefended[i-k][j] = 1 elseif within(i-k, j) and grid[i-k][j] ~= "| |" and S then S, whiteDefended[i-k][j] = false, 1 end
                    if within(i+k, j) and grid[i+k][j] == "| |" and N then whiteDefended[i+k][j] = 1 elseif within(i+k, j) and grid[i+k][j] ~= "| |" and N then N, whiteDefended[i+k][j] = false, 1 end     
                end
            elseif grid[i][j] == "{R}" then
                S, W, N, E = true, true, true, true
                for k = 1,8 do
                    if within(i, j+k) and grid[i][j+k] == "| |" and W then whiteDefended[i][j+k] = 1 elseif within(i, j+k) and grid[i][j+k] ~= "| |" and W then W, whiteDefended[i][j+k] = false, 1 end
                    if within(i, j-k) and grid[i][j-k] == "| |" and E then whiteDefended[i][j-k] = 1 elseif within(i, j-k) and grid[i][j-k] ~= "| |" and E then E, whiteDefended[i][j-k] = false, 1 end
                    if within(i-k, j) and grid[i-k][j] == "| |" and S then whiteDefended[i-k][j] = 1 elseif within(i-k, j) and grid[i-k][j] ~= "| |" and S then S, whiteDefended[i-k][j] = false, 1 end
                    if within(i+k, j) and grid[i+k][j] == "| |" and N then whiteDefended[i+k][j] = 1 elseif within(i+k, j) and grid[i+k][j] ~= "| |" and N then N, whiteDefended[i+k][j] = false, 1 end            
                end    
            elseif grid[i][j] == "{B}" then
                SE, SW, NW, NE = true, true, true, true
                for k = 1,8 do
                    if within(i+k, j+k) and grid[i+k][j+k] == "| |" and SE then whiteDefended[i+k][j+k] = 1 elseif within(i+k, j+k) and grid[i+k][j+k] ~= "| |" and SE then SE, whiteDefended[i+k][j+k] = false, 1 end
                    if within(i+k, j-k) and grid[i+k][j-k] == "| |" and SW then whiteDefended[i+k][j-k] = 1 elseif within(i+k, j-k) and grid[i+k][j-k] ~= "| |" and SW then SW, whiteDefended[i+k][j-k] = false, 1 end
                    if within(i-k, j+k) and grid[i-k][j+k] == "| |" and NE then whiteDefended[i-k][j+k] = 1 elseif within(i-k, j+k) and grid[i-k][j+k] ~= "| |" and NE then NE, whiteDefended[i-k][j+k] = false, 1 end
                    if within(i-k, j-k) and grid[i-k][j-k] == "| |" and NW then whiteDefended[i-k][j-k] = 1 elseif within(i-k, j-k) and grid[i-k][j-k] ~= "| |" and NW then NW, whiteDefended[i-k][j-k] = false, 1 end
                end
            elseif grid[i][j] == "{N}" then
                if within(i+2, j-1) then whiteDefended[i+2][j-1] = 1 end
                if within(i+2, j+1) then whiteDefended[i+2][j+1] = 1 end
                if within(i-2, j-1) then whiteDefended[i-2][j-1] = 1 end
                if within(i-2, j+1) then whiteDefended[i-2][j+1] = 1 end
                if within(i+1, j-2) then whiteDefended[i+1][j-2] = 1 end
                if within(i-1, j-2) then whiteDefended[i-1][j-2] = 1 end
                if within(i+1, j+2) then whiteDefended[i+1][j+2] = 1 end
                if within(i-1, j+2) then whiteDefended[i-1][j+2] = 1 end
            elseif grid[i][j] == "{P}" then
                if within(i-1, j-1) then whiteDefended[i-1][j-1] = 1 end
                if within(i-1, j+1) then whiteDefended[i-1][j+1] = 1 end
            elseif grid[i][j] == "{K}" then
                if within(i-1, j-1) then whiteDefended[i-1][j-1] = 1 end
                if within(i-1, j+1) then whiteDefended[i-1][j+1] = 1 end
                if within(i+1, j-1) then whiteDefended[i+1][j-1] = 1 end
                if within(i+1, j+1) then whiteDefended[i+1][j+1] = 1 end
                if within(i-1, j) then whiteDefended[i-1][j] = 1 end
                if within(i+1, j) then whiteDefended[i+1][j] = 1 end
                if within(i, j-1) then whiteDefended[i][j-1] = 1 end
                if within(i, j+1) then whiteDefended[i][j+1] = 1 end
            end

            if grid[i][j] == "[Q]" then
                SE, S, SW, W, NW, N, NE, E = true, true, true, true, true, true, true, true
                for k = 1,8 do
                    if within(i+k, j+k) and grid[i+k][j+k] == "| |" and SE then blackDefended[i+k][j+k] = 1 elseif within(i+k, j+k) and grid[i+k][j+k] ~= "| |" and SE then SE, blackDefended[i+k][j+k] = false, 1 end
                    if within(i+k, j-k) and grid[i+k][j-k] == "| |" and SW then blackDefended[i+k][j-k] = 1 elseif within(i+k, j-k) and grid[i+k][j-k] ~= "| |" and SW then SW, blackDefended[i+k][j-k] = false, 1 end
                    if within(i-k, j+k) and grid[i-k][j+k] == "| |" and NE then blackDefended[i-k][j+k] = 1 elseif within(i-k, j+k) and grid[i-k][j+k] ~= "| |" and NE then NE, blackDefended[i-k][j+k] = false, 1 end
                    if within(i-k, j-k) and grid[i-k][j-k] == "| |" and NW then blackDefended[i-k][j-k] = 1 elseif within(i-k, j-k) and grid[i-k][j-k] ~= "| |" and NW then NW, blackDefended[i-k][j-k] = false, 1 end
                    if within(i, j+k) and grid[i][j+k] == "| |" and W then blackDefended[i][j+k] = 1 elseif within(i, j+k) and grid[i][j+k] ~= "| |" and W then W, blackDefended[i][j+k] = false, 1 end
                    if within(i, j-k) and grid[i][j-k] == "| |" and E then blackDefended[i][j-k] = 1 elseif within(i, j-k) and grid[i][j-k] ~= "| |" and E then E, blackDefended[i][j-k] = false, 1 end
                    if within(i-k, j) and grid[i-k][j] == "| |" and S then blackDefended[i-k][j] = 1 elseif within(i-k, j) and grid[i-k][j] ~= "| |" and S then S, blackDefended[i-k][j] = false, 1 end
                    if within(i+k, j) and grid[i+k][j] == "| |" and N then blackDefended[i+k][j] = 1 elseif within(i+k, j) and grid[i+k][j] ~= "| |" and N then N, blackDefended[i+k][j] = false, 1 end     
                end
            elseif grid[i][j] == "[R]" then
                S, W, N, E = true, true, true, true
                for k = 1,8 do
                    if within(i, j+k) and grid[i][j+k] == "| |" and W then blackDefended[i][j+k] = 1 elseif within(i, j+k) and grid[i][j+k] ~= "| |" and W then W, blackDefended[i][j+k] = false, 1 end
                    if within(i, j-k) and grid[i][j-k] == "| |" and E then blackDefended[i][j-k] = 1 elseif within(i, j-k) and grid[i][j-k] ~= "| |" and E then E, blackDefended[i][j-k] = false, 1 end
                    if within(i-k, j) and grid[i-k][j] == "| |" and S then blackDefended[i-k][j] = 1 elseif within(i-k, j) and grid[i-k][j] ~= "| |" and S then S, blackDefended[i-k][j] = false, 1 end
                    if within(i+k, j) and grid[i+k][j] == "| |" and N then blackDefended[i+k][j] = 1 elseif within(i+k, j) and grid[i+k][j] ~= "| |" and N then N, blackDefended[i+k][j] = false, 1 end            
                end    
            elseif grid[i][j] == "[B]" then
                SE, SW, NW, NE = true, true, true, true
                for k = 1,8 do
                    if within(i+k, j+k) and grid[i+k][j+k] == "| |" and SE then blackDefended[i+k][j+k] = 1 elseif within(i+k, j+k) and grid[i+k][j+k] ~= "| |" and SE then SE, blackDefended[i+k][j+k] = false, 1 end
                    if within(i+k, j-k) and grid[i+k][j-k] == "| |" and SW then blackDefended[i+k][j-k] = 1 elseif within(i+k, j-k) and grid[i+k][j-k] ~= "| |" and SW then SW, blackDefended[i+k][j-k] = false, 1 end
                    if within(i-k, j+k) and grid[i-k][j+k] == "| |" and NE then blackDefended[i-k][j+k] = 1 elseif within(i-k, j+k) and grid[i-k][j+k] ~= "| |" and NE then NE, blackDefended[i-k][j+k] = false, 1 end
                    if within(i-k, j-k) and grid[i-k][j-k] == "| |" and NW then blackDefended[i-k][j-k] = 1 elseif within(i-k, j-k) and grid[i-k][j-k] ~= "| |" and NW then NW, blackDefended[i-k][j-k] = false, 1 end
                end
            elseif grid[i][j] == "[N]" then
                if within(i+2, j-1) then blackDefended[i+2][j-1] = 1 end
                if within(i+2, j+1) then blackDefended[i+2][j+1] = 1 end
                if within(i-2, j-1) then blackDefended[i-2][j-1] = 1 end
                if within(i-2, j+1) then blackDefended[i-2][j+1] = 1 end
                if within(i+1, j-2) then blackDefended[i+1][j-2] = 1 end
                if within(i-1, j-2) then blackDefended[i-1][j-2] = 1 end
                if within(i+1, j+2) then blackDefended[i+1][j+2] = 1 end
                if within(i-1, j+2) then blackDefended[i-1][j+2] = 1 end
            elseif grid[i][j] == "[P]" then
                if within(i+1, j-1) then blackDefended[i+1][j-1] = 1 end
                if within(i+1, j+1) then blackDefended[i+1][j+1] = 1 end
            elseif grid[i][j] == "[K]" then
                if within(i-1, j-1) then blackDefended[i-1][j-1] = 1 end
                if within(i-1, j+1) then blackDefended[i-1][j+1] = 1 end
                if within(i+1, j-1) then blackDefended[i+1][j-1] = 1 end
                if within(i+1, j+1) then blackDefended[i+1][j+1] = 1 end
                if within(i-1, j) then blackDefended[i-1][j] = 1 end
                if within(i+1, j) then blackDefended[i+1][j] = 1 end
                if within(i, j-1) then blackDefended[i][j-1] = 1 end
                if within(i, j+1) then blackDefended[i][j+1] = 1 end
            end
        end        
    end
    return {whiteDefended, blackDefended}
end

function trackMoves(x, y)
    moves[y][x] = moves[y][x] + 1
end

function replace(grid, x1, y1, x2, y2)
    grid[y2][x2] = grid[y1][x1]
    grid[y1][x1] = "| |"
    trackMoves(x1, y1)
    return true, grid
end

function piecesBetween(grid, x1, y1, x2, y2)
    xMovement, yMovement = math.abs(x2 - x1), math.abs(y2 - y1)
    pieces = 0
    if xMovement <= 1 and yMovement <= 1 then return pieces end
    allX, allY = {}, {}
    for i = 1, 8 do
        if math.min(x1, x2) <= i and i <= math.max(x1, x2) then table.insert(allX, i) end
        if math.min(y1, y2) <= i and i <= math.max(y1, y2) then table.insert(allY, i) end
    end
    if #allX == 1 then
        for j = 1, #allY do
            if grid[allY[j]][allX[1]] ~= "| |" then pieces = pieces + 1 end
        end
    elseif #allY == 1 then
        for j = 1, #allX do
            if grid[allY[1]][allX[j]] ~= "| |" then pieces = pieces + 1 end
        end
    else
        if (x2 - x1) / (y2 - y1) == 1 then
            for j = 1, #allX do
                if grid[allY[j]][allX[j]] ~= "| |" then pieces = pieces + 1 end
            end
        else 
            for j = 1, #allX do
                if grid[allY[#allX+1-j]][allX[j]] ~= "| |" then pieces = pieces + 1 end
            end
        end
    end
    if grid[y2][x2] == "| |" then pieces = pieces + 1 end
    return pieces - 2
end

-- QUEEN MOVE
function moveQueen(grid, x1, y1, x2, y2)
    xMovement, yMovement = math.abs(x2 - x1), math.abs(y2 - y1)
    if (xMovement == yMovement or xMovement == 0 or yMovement == 0) and not (xMovement == 0 and yMovement == 0) and piecesBetween(grid, x1, y1, x2, y2) == 0 then
        return replace(grid, x1, y1, x2, y2)
    else return false, grid end
end

-- KING MOVE
function moveKing(grid, x1, y1, x2, y2)
    xMovement, yMovement = math.abs(x2 - x1), math.abs(y2 - y1)
    -- Castle
    if x1 == 5 and y1 == 8 and xMovement == 2 and yMovement == 0 and moves[y1][x1] == 0 then
        if x2 == 3 and moves[8][1] == 0 and piecesBetween(grid, 5, 8, 1, 8) == 0 then
            if squareDefended(grid)[2][8][2] == 0 and squareDefended(grid)[2][8][3] == 0 and squareDefended(grid)[2][8][4] == 0 and squareDefended(grid)[2][8][5] == 0 then
                grid[8][3], grid[8][5], grid[8][4], grid[8][1], moves[8][5] = "{K}", "| |", "{R}", "| |", 1
                return true, grid
            else return false, grid end
        elseif x2 == 7 and moves[8][8] == 0 and piecesBetween(grid, 5, 8, 8, 8) == 0 then
            if squareDefended(grid)[2][8][7] == 0 and squareDefended(grid)[2][8][6] == 0 and squareDefended(grid)[2][8][5] == 0 then
                grid[8][7], grid[8][5], grid[8][6], grid[8][8], moves[8][5] = "{K}", "| |", "{R}", "| |", 1
                return true, grid
            else return false, grid end
        else return false, grid end
    elseif x1 == 5 and y1 == 1 and xMovement == 2 and yMovement == 0 and moves[y1][x1] == 0 then
        if x2 == 3 and moves[1][1] == 0 and piecesBetween(grid, 5, 1, 1, 1) == 0 then
            if squareDefended(grid)[1][1][2] == 0 and squareDefended(grid)[1][1][3] == 0 and squareDefended(grid)[1][1][4] == 0 and squareDefended(grid)[1][1][5] == 0 then
                grid[1][3], grid[1][5], grid[1][4], grid[1][1], moves[1][5] = "[K]", "| |", "[R]", "| |", 1
                return true, grid
            else return false, grid end
        elseif x2 == 7 and moves[1][8] == 0 and piecesBetween(grid, 5, 1, 8, 1) == 0 then
            if squareDefended(grid)[1][1][7] == 0 and squareDefended(grid)[1][1][6] == 0 and squareDefended(grid)[1][1][5] == 0 then
                grid[1][7], grid[1][5], grid[1][6], grid[1][8], moves[1][5] = "[K]", "| |", "[R]", "| |", 1
                return true, grid
            else return false, grid end
        else return false, grid end
    elseif (xMovement == 1 or xMovement == 0) and (yMovement == 1 or yMovement == 0) and not (xMovement == 0 and yMovement == 0) then
        if (squareDefended(grid)[1][y2][x2] == 0 and grid[y1][x1] == "[K]") or ((squareDefended(grid)[2][y2][x2] == 0 and grid[y1][x1] == "{K}")) then
            return replace(grid, x1, y1, x2, y2)
        else return false, grid end
    else return false, grid end
end

-- BISHOP MOVE
function moveBishop(grid, x1, y1, x2, y2)
    xMovement, yMovement = math.abs(x2 - x1), math.abs(y2 - y1)
    if xMovement == yMovement and not (xMovement == 0 and yMovement == 0) and piecesBetween(grid, x1, y1, x2, y2) == 0 then
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
    if (xMovement == 0 or yMovement == 0) and not (xMovement == 0 and yMovement == 0) and piecesBetween(grid, x1, y1, x2, y2) == 0 then
        return replace(grid, x1, y1, x2, y2)
    else return false, grid end
end

-- PAWN MOVE
function movePawn(grid, x1, y1, x2, y2)
    xMovement, yMovement = math.abs(x2 - x1), math.abs(y2 - y1)
    -- First Move
    if grid[y1][x1] == "{P}" and y1 == 7 and x2 == x1 and y2 == 5 and piecesBetween(grid, x1, y1, x2, y2) == 0 then 
        return replace(grid, x1, y1, x2, y2)
    elseif grid[y1][x1] == "[P]" and y1 == 2 and x2 == x1 and y2 == 4 and piecesBetween(grid, x1, y1, x2, y2) == 0 then 
        return replace(grid, x1, y1, x2, y2)
    -- En passant
    elseif xMovement == 1 and y1-y2 == 1 and grid[y1][x1] == "{P}" and grid[y2][x2] == "| |" and grid[y1][x2] == "[P]" and i == x2 and j == y1-2 and k == x2 and l == y1 then
        grid[y1][x1], grid[y2][x2], grid[y1][x2] = "| |", "{P}", "| |"
        return true, grid
    elseif xMovement == 1 and y2-y1 == 1 and grid[y1][x1] == "[P]" and grid[y2][x2] == "| |" and grid[y1][x2] == "{P}" and e == x2 and f == y1+2 and g == x2 and h == y1 then
        grid[y1][x1], grid[y2][x2], grid[y1][x2] = "| |", "[P]", "| |"
        return true, grid
    else
        -- Basic Move
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
            if promotion == "N" then grid[8][i] = "[N]" end
            if promotion == "B" then grid[8][i] = "[B]" end
            if promotion == "R" then grid[8][i] = "[R]" end
            if promotion == "Q" then grid[8][i] = "[Q]" end
        end
    end
    return grid
end

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
function checkCheck(grid, move)
    for i = 1, 8 do
        for j = 1, 8 do
            if squareDefended(grid)[1][i][j] == 1 and grid[i][j] == "[K]" and move == "black" then
                return 1
            end
            if squareDefended(grid)[2][i][j] == 1 and grid[i][j] == "{K}" and move == "white" then
                return 2
            end
        end
    end
    return 3
end

-- CHECK for CHECKMATE
function checkCheckmate(grid)
    for i = 1, 8 do
        for j = 1, 8 do
            if squareDefended(grid)[1][i][j] == 1 and grid[i][j] == "[K]" then
                if not (not within(i+1, j+1) or countOccurrences(grid[i+1][j+1], "%[") == 1 or squareDefended(grid)[1][i+1][j+1] == 1) then return false end
                if not (not within(i, j+1) or countOccurrences(grid[i][j+1], "%[") == 1 or squareDefended(grid)[1][i][j+1] == 1) then return false end
                if not (not within(i-1, j+1) or countOccurrences(grid[i-1][j+1], "%[") == 1 or squareDefended(grid)[1][i-1][j+1] == 1) then return false end
                if not (not within(i-1, j) or countOccurrences(grid[i-1][j], "%[") == 1 or squareDefended(grid)[1][i-1][j] == 1) then return false end
                if not (not within(i-1, j-1) or countOccurrences(grid[i-1][j-1], "%[") == 1 or squareDefended(grid)[1][i-1][j-1] == 1) then return false end
                if not (not within(i, j-1) or countOccurrences(grid[i][j-1], "%[") == 1 or squareDefended(grid)[1][i][j-1] == 1) then return false end
                if not (not within(i+1, j-1) or countOccurrences(grid[i+1][j-1], "%[") == 1 or squareDefended(grid)[1][i+1][j-1] == 1) then return false end
                if not (not within(i+1, j) or countOccurrences(grid[i+1][j], "%[") == 1 or squareDefended(grid)[1][i+1][j] == 1) then return false end
                return true
            end
            if squareDefended(grid)[2][i][j] == 1 and grid[i][j] == "{K}" then
                if not (not within(i+1, j+1) or countOccurrences(grid[i+1][j+1], "%{") == 1 or squareDefended(grid)[2][i+1][j+1] == 1) then return false end
                if not (not within(i, j+1) or countOccurrences(grid[i][j+1], "%{") == 1 or squareDefended(grid)[2][i][j+1] == 1) then return false end
                if not (not within(i-1, j+1) or countOccurrences(grid[i-1][j+1], "%{") == 1 or squareDefended(grid)[2][i-1][j+1] == 1) then return false end
                if not (not within(i-1, j) or countOccurrences(grid[i-1][j], "%{") == 1 or squareDefended(grid)[2][i-1][j] == 1) then return false end
                if not (not within(i-1, j-1) or countOccurrences(grid[i-1][j-1], "%{") == 1 or squareDefended(grid)[2][i-1][j-1] == 1) then return false end
                if not (not within(i, j-1) or countOccurrences(grid[i][j-1], "%{") == 1 or squareDefended(grid)[2][i][j-1] == 1) then return false end
                if not (not within(i+1, j-1) or countOccurrences(grid[i+1][j-1], "%{") == 1 or squareDefended(grid)[2][i+1][j-1] == 1) then return false end
                if not (not within(i+1, j) or countOccurrences(grid[i+1][j], "%{") == 1 or squareDefended(grid)[2][i+1][j] == 1) then return false end
                return true
            end
        end
    end
end
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
            if string.len(input) == 4 then
                a, b, c, d = split(input)[1], split(input)[2], split(input)[3], split(input)[4] 
                a, b, c, d = string.upper(a), tonumber(b), string.upper(c), tonumber(d)
                a, c = letterToNumber[a], letterToNumber[c]
                b, d = 9 - b, 9 - d
                e, f, g, h = deepcopy(a), deepcopy(b), deepcopy(c), deepcopy(d)
                if not (a >= 9 or a <= 0 or b >= 9 or b <= 0 or c >= 9 or c <= 0 or d >= 9 or d <= 0) then
                    if countOccurrences(board[b][a], "%{") == 1 then
                        x = deepcopy(board)
                        success2, board2 = movePiece(x, x[b][a], a, b, c, d)
                        if checkCheck(board2, "white") ~= 2 then
                            success, board = movePiece(board, board[b][a], a, b, c, d)
                            board = checkPromotion(board)
                            printGrid(board)
                        end
                    end
                end
            end
        until success
        if checkCheckmate(board) then 
            print("White Wins!")
            break 
        end
        -- Black's Move
        repeat
            success = false
            print("[BLACK] Move a piece [e.g E5D4]")
            input = io.read()
            if string.len(input) == 4 then
                a, b, c, d = split(input)[1], split(input)[2], split(input)[3], split(input)[4] 
                a, b, c, d = string.upper(a), tonumber(b), string.upper(c), tonumber(d)
                a, c = letterToNumber[a], letterToNumber[c]
                print(a, b, c, d)
                b, d = 9 - b, 9 - d
                i, j, k, l = deepcopy(a), deepcopy(b), deepcopy(c), deepcopy(d) 
                if not (a >= 9 or a <= 0 or b >= 9 or b <= 0 or c >= 9 or c <= 0 or d >= 9 or d <= 0) then
                    if countOccurrences(board[b][a], "%[") == 1 then
                        x = deepcopy(board)
                        success2, board2 = movePiece(x, x[b][a], a, b, c, d)
                        if checkCheck(board2, "black") ~= 1 then
                            success, board = movePiece(board, board[b][a], a, b, c, d)
                            board = checkPromotion(board)
                            printGrid(board)
                        end
                    end
                end
            end
        until success
        if checkCheckmate(board) then
            print("Black Wins!")
            break
        end
    end
end
        