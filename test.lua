
board = {{"[R]", "{N}", "[B]", "[Q]", "[K]", "[B]", "[N]", "[R]"},
         {"[P]", "[P]", "[P]", "[P]", "[P]", "[P]", "{P}", "[P]"},
         {"| |", "| |", "| |", "| |", "| |", "| |", "| |", "| |"}, 
         {"| |", "| |", "| |", "| |", "| |", "| |", "[P]", "{P}"},
         {"| |", "| |", "| |", "| |", "| |", "| |", "| |", "| |"},
         {"| |", "| |", "| |", "| |", "| |", "{Q}", "| |", "| |"},
         {"{P}", "{P}", "| |", "{P}", "{P}", "| |", "| |", "{P}"}, 
         {"{R}", "{N}", "{B}", "| |", "{K}", "{B}", "{N}", "{R}"}}

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

for i = 1, 8 do
    print()
    for j = 1, 8 do
        io.write(squareDefended(board)[1][i][j])
    end
end       
print()

for i = 1, 8 do
    print()
    for j = 1, 8 do
        io.write(squareDefended(board)[2][i][j])
    end
end   
