board = {"[ ]", "[ ]", "[ ]",
        "[ ]", "[ ]", "[ ]",
        "[ ]", "[ ]", "[ ]"}

-- Prints the grid
function printGrid(grid)
    io.write("---------------\n")
    io.write("| ")
    for i = 1, 9 do
        io.write(grid[i] .. " ")
        if i % 3 == 0 then
            io.write("|\n")
            if i < 9 then
                io.write("| ")
            end
        end
    end
    io.write("---------------\n")
end

-- Count occurences of a letter in a string
function countOccurrences(str, sub)
    local _, count = string.gsub(str, sub, "")
    return count
end

-- Finds the position of a letter in a string
function findPosition(str, letter)
    local startPos = string.find(str, letter)
    return startPos
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

-- Places the players move
function placeMove(grid, coordinate)
    grid[coordinate] = "[X]"
    return grid
end

-- Checks for a draw
function checkDraw(grid)
    if countOccurrencesList(grid, "[ ]") == 0 then
        return true
    end
    return false
end

 -- Checks if the Computer or the Player has won
function checkOutput(grid)
    if checkDraw(grid) then
        print("Draw!")
        return true
    end    
    triplets = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}, {1, 5, 9}, {3, 5, 7}, {1, 4, 7}, {2, 5, 8}, {3, 6, 9}}
    for _, triplet in ipairs(triplets) do
        line = ""
        for _, coordinate in ipairs(triplet) do
            line = line .. grid[coordinate]
        end
        if line == "[X][X][X]" then
            print("Player Wins!")
            return true
        end
        if line == "[O][O][O]" then
            print("Computer Wins!")
            return true
        end
    end
    return false
end

-- Automated Move
function computerMove(grid)
    -- Blocking Move
    triplets = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}, {1, 5, 9}, {3, 5, 7}, {1, 4, 7}, {2, 5, 8}, {3, 6, 9}}
    for _, triplet in ipairs(triplets) do
        line = ""
        for _, coordinate in ipairs(triplet) do
            line = line .. grid[coordinate]
        end
        if countOccurrences(line, "[O]") == 2 and countOccurrences(line, "[X]") == 0 then
            position = (findPosition(line, "[ ]") + 1) / 3
            grid[triplet[position]] = "[O]"
            return grid
        end
        if countOccurrences(line, "[X]") == 2 and countOccurrences(line, "[O]") == 0 then
            position = (findPosition(line, "[ ]") + 1) / 3
            grid[triplet[position]] = "[O]"
            return grid
        end
        
    end
    -- Random Move
    possible = {}
    numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9}
    for _, c in ipairs(numbers) do
        if grid[c] == "[ ]" then
            table.insert(possible, c)
        end
    end
    math.randomseed(os.time())
    randomSpot = possible[math.random(1, #possible)]
    grid[randomSpot] = "[O]"
    return grid
end
   
-- Main Loop
print("Press P to Play")
P = io.read()
if P == "P" then
    printGrid(board)
    while not checkOutput(board) do
        -- Player Move
        repeat
            print("Enter Row and Column e.g 3 // 3 to place your move")
            a,b = io.read("*n","*n")
            coordinate = a * 3 + b - 3
            if board[coordinate] == "[ ]" then
                board = placeMove(board, coordinate)
                break
            end
        until True
        printGrid(board)
        -- Win Check
        if checkOutput(board) then
            break
        end
        -- Computer Move
        board = computerMove(board)
        printGrid(board)
    end
end

