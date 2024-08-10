board = {
    {"[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[ ]", "[x]", "[x]", "[x]", "[x]"},
    {"[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[ ]", "[ ]", "[x]", "[x]", "[x]", "[x]"},
    {"[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[ ]", "[ ]", "[ ]", "[x]", "[x]", "[x]", "[x]"},
    {"[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[ ]", "[ ]", "[ ]", "[ ]", "[x]", "[x]", "[x]", "[x]"},
    {"[x]", "[x]", "[x]", "[x]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]"},
    {"[x]", "[x]", "[x]", "[x]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[x]"},
    {"[x]", "[x]", "[x]", "[x]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[x]", "[x]"},
    {"[x]", "[x]", "[x]", "[x]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[x]", "[x]", "[x]"},
    {"[x]", "[x]", "[x]", "[x]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[x]", "[x]", "[x]", "[x]"},
    {"[x]", "[x]", "[x]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[x]", "[x]", "[x]", "[x]"},
    {"[x]", "[x]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[x]", "[x]", "[x]", "[x]"},
    {"[x]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[x]", "[x]", "[x]", "[x]"},
    {"[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[x]", "[x]", "[x]", "[x]"},
    {"[x]", "[x]", "[x]", "[x]", "[ ]", "[ ]", "[ ]", "[ ]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]"},
    {"[x]", "[x]", "[x]", "[x]", "[ ]", "[ ]", "[ ]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]"},
    {"[x]", "[x]", "[x]", "[x]", "[ ]", "[ ]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]"},
    {"[x]", "[x]", "[x]", "[x]", "[ ]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]", "[x]"}
}

-- Prints the Grid
function printGrid(grid)
  print("                   -")
  print(string.format("                  %s", grid[5][5]))
  print(string.format("                %s|%s", grid[5][6], grid[6][5]))
  print(string.format("               %s%s%s", grid[5][7], grid[6][6], grid[7][5]))
  print(string.format("             %s%s|%s%s", grid[5][8], grid[6][7], grid[7][6], grid[8][5]))
  print(string.format("%s%s%s%s%s%s%s%s%s%s%s%s%s", grid[1][13], grid[2][12], grid[3][11], grid[4][10], grid[5][9], grid[6][8], grid[7][7], grid[8][6], grid[9][5], grid[10][4], grid[11][3], grid[12][2], grid[13][1]))
  print(string.format(" %s%s%s%s%s%s|%s%s%s%s%s%s", grid[2][13], grid[3][12], grid[4][11], grid[5][10], grid[6][9], grid[7][8], grid[8][7], grid[9][6], grid[10][5], grid[11][4], grid[12][3], grid[13][2]))
  print(string.format("   %s%s%s%s%s%s%s%s%s%s%s", grid[3][13], grid[4][12], grid[5][11], grid[6][10], grid[7][9], grid[8][8], grid[9][7], grid[10][6], grid[11][5], grid[12][4], grid[13][3]))
  print(string.format("    %s%s%s%s%s|%s%s%s%s%s", grid[4][13], grid[5][12], grid[6][11], grid[7][10], grid[8][9], grid[9][8], grid[10][7], grid[11][6], grid[12][5], grid[13][4]))
  print(string.format("      %s%s%s%s%s%s%s%s%s", grid[5][13], grid[6][12], grid[7][11], grid[8][10], grid[9][9], grid[10][8], grid[11][7], grid[12][6], grid[13][5]))
  print(string.format("    %s%s%s%s%s|%s%s%s%s%s", grid[5][14], grid[6][13], grid[7][12], grid[8][11], grid[9][10], grid[10][9], grid[11][8], grid[12][7], grid[13][6], grid[14][5]))
  print(string.format("   %s%s%s%s%s%s%s%s%s%s%s", grid[5][15], grid[6][14], grid[7][13], grid[8][12], grid[9][11], grid[10][10], grid[11][9], grid[12][8], grid[13][7], grid[14][6], grid[15][5]))
  print(string.format(" %s%s%s%s%s%s|%s%s%s%s%s%s", grid[5][16], grid[6][15], grid[7][14], grid[8][13], grid[9][12], grid[10][11], grid[11][10], grid[12][9], grid[13][8], grid[14][7], grid[15][6], grid[16][5]))
  print(string.format("%s%s%s%s%s%s%s%s%s%s%s%s%s", grid[5][17], grid[6][16], grid[7][15], grid[8][14], grid[9][13], grid[10][12], grid[11][11], grid[12][10], grid[13][9], grid[14][8], grid[15][7], grid[16][6], grid[17][5]))
  print(string.format("             %s%s|%s%s", grid[10][13], grid[11][12], grid[12][11], grid[13][10]))
  print(string.format("               %s%s%s", grid[11][13], grid[12][12], grid[13][11]))
  print(string.format("                %s|%s", grid[12][13], grid[13][12]))
  print(string.format("                  %s", grid[13][13]))
end

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

function countOccurrencesList(list, target)
  local count = 0
  for i = 1, #list do
    if list[i][1] == target[1] and list[i][2] == target[2] then
      count = count + 1
    end
  end
  return count
end

-- Sets the board up
print("How much players are there? [2/3/6]")
repeat 
  players = tonumber(io.read("*n"))
  if players == 2 or players == 3 or players == 6 then
    board[5][5], board[5][6], board[6][5], board[5][7], board[6][6], board[7][5], board[5][8], board[6][7], board[7][6], board[8][5] = "[R]", "[R]", "[R]", "[R]", "[R]", "[R]", "[R]", "[R]", "[R]", "[R]"
    if players == 2 or players == 6 then 
      colours = {"[R]", "[B]"}
      board[10][13], board[11][12], board[12][11], board[13][10], board[11][13], board[12][12], board[13][11], board[12][13], board[13][12], board[13][13] = "[B]", "[B]", "[B]", "[B]", "[B]", "[B]", "[B]", "[B]", "[B]", "[B]"
    end
    if players == 3 or players == 6 then
      colours = {"[R]", "[G]", "[Y]"}
      board[5][14], board[5][15], board[6][14], board[5][16], board[6][15], board[7][14], board[5][17], board[6][16], board[7][15], board[8][14] = "[Y]", "[Y]", "[Y]", "[Y]", "[Y]", "[Y]", "[Y]", "[Y]", "[Y]", "[Y]"
      board[14][5], board[14][6], board[15][5], board[14][7], board[15][6], board[16][5], board[14][8], board[15][7], board[16][6], board[17][5] = "[G]", "[G]", "[G]", "[G]", "[G]", "[G]", "[G]", "[G]", "[G]", "[G]"
    end
    if players == 6 then
      colours = {"[R]", "[P]", "[G]", "[B]", "[Y]", "[O]"}
      board[1][13], board[2][12], board[3][11], board[4][10], board[2][13], board[3][12], board[4][11], board[3][13], board[4][12], board[4][13] = "[O]", "[O]", "[O]", "[O]", "[O]", "[O]", "[O]", "[O]", "[O]", "[O]"
      board[10][4], board[11][3], board[12][2], board[13][1], board[11][4], board[12][3], board[13][2], board[12][4], board[13][3], board[13][4] = "[P]", "[P]", "[P]", "[P]", "[P]", "[P]", "[P]", "[P]", "[P]", "[P]"
    end
    valid = true
  end
until valid

-- Finds all possible moves for a certain piece
function possibleMoves(grid, x, y)
  moves = {{x, y}}
  -- Adjacent
  if x+1 <= #grid and grid[x+1][y] == "[ ]" then moves[#moves + 1] = {x+1, y} end 
  if x+1 <= #grid and y-1 >= 1 and grid[x+1][y-1] == "[ ]" then moves[#moves + 1] = {x+1, y-1} end 
  if y+1 <= #grid and grid[x][y+1] == "[ ]" then moves[#moves + 1] = {x, y+1} end 
  if y-1 >= 1 and grid[x][y-1] == "[ ]" then moves[#moves + 1] = {x, y-1} end 
  if x-1 >= 1 and grid[x-1][y] == "[ ]" then moves[#moves + 1] = {x-1, y} end 
  if x-1 >= 1 and y+1 <= #grid and grid[x-1][y+1] == "[ ]" then moves[#moves + 1] = {x-1, y+1} end 
  -- Jumps
  currentX, currentY = deepcopy(x), deepcopy(y)
  alwaysFalse = false
  complete = false
  while not complete do
    repeat 
      if currentX == x and currentY == y then 
        lastX, lastY = {deepcopy(x)}, {deepcopy(y)} 
      end
      if currentX+2 <= #grid and grid[currentX+2][currentY] == "[ ]" and grid[currentX+1][currentY] ~= "[ ]" and grid[currentX+1][currentY] ~= "[x]" and countOccurrencesList(moves, {currentX+2, currentY}) == 0 then
        moves[#moves+1] = {currentX+2, currentY}
        currentX = currentX+2
        lastX[#lastX+1], lastY[#lastY+1] = deepcopy(currentX), deepcopy(currentY)
        break
      elseif currentX+2 <= #grid and currentY-2 >= 1 and grid[currentX+2][currentY-2] == "[ ]" and grid[currentX+1][currentY-1] ~= "[ ]" and grid[currentX+1][currentY-1] ~= "[x]" and countOccurrencesList(moves, {currentX+2, currentY-2}) == 0 then
        moves[#moves+1] = {currentX+2, currentY-2}
        currentX, currentY = currentX+2, currentY-2
        lastX[#lastX+1], lastY[#lastY+1] = deepcopy(currentX), deepcopy(currentY)
        break
      elseif currentY+2 <= #grid and grid[currentX][currentY+2] == "[ ]" and grid[currentX][currentY+1] ~= "[ ]" and grid[currentX][currentY+1] ~= "[x]" and countOccurrencesList(moves, {currentX, currentY+2}) == 0 then
        moves[#moves+1] = {currentX, currentY+2}
        currentY = currentY+2
        lastX[#lastX+1], lastY[#lastY+1] = deepcopy(currentX), deepcopy(currentY)
        break
      elseif currentY-2 >= 1 and grid[currentX][currentY-2] == "[ ]" and grid[currentX][currentY-1] ~= "[ ]" and grid[currentX][currentY-1] ~= "[x]" and countOccurrencesList(moves, {currentX, currentY-2}) == 0 then
        moves[#moves+1] = {currentX, currentY-2}
        currentY = currentY-2
        lastX[#lastX+1], lastY[#lastY+1] = deepcopy(currentX), deepcopy(currentY)
        break
      elseif currentX-2 >= 1 and grid[currentX-2][currentY] == "[ ]" and grid[currentX-1][currentY] ~= "[ ]" and grid[currentX-1][currentY] ~= "[x]" and countOccurrencesList(moves, {currentX-2, currentY}) == 0 then
        moves[#moves+1] = {currentX-2, currentY}
        currentX, currentY = currentX-2, currentY
        lastX[#lastX+1], lastY[#lastY+1] = deepcopy(currentX), deepcopy(currentY)
        break
      elseif currentX-2 >= 1 and currentY+2 <= #grid and grid[currentX-2][currentY+2] == "[ ]" and grid[currentX-1][currentY+1] ~= "[ ]" and grid[currentX-1][currentY+1] ~= "[x]" and countOccurrencesList(moves, {currentX-2, currentY+2}) == 0 then
        moves[#moves+1] = {currentX-2, currentY+2}
        currentX, currentY = currentX-2, currentY+2
        lastX[#lastX+1], lastY[#lastY+1] = deepcopy(currentX), deepcopy(currentY)
        break
      elseif currentX == x and currentY == y then
        complete = true
        break
      end
      table.remove(lastX)
      table.remove(lastY)
      currentX, currentY = lastX[#lastX], lastY[#lastY]
    until alwaysFalse
  end
  return moves
end

-- Check Output
function output(grid)
  blue = deepcopy({grid[5][5], grid[5][6], grid[6][5], grid[5][7], grid[6][6], grid[7][5], grid[5][8], grid[6][7], grid[7][6], grid[8][5], ""})
  for b = 1, #blue do
    if blue[b] == "" then 
      print("Blue wins!")
      return true
    end
    if blue[i] ~= "[B]" then break end   
  end
  red = deepcopy({grid[10][13], grid[11][12], grid[12][11], grid[13][10], grid[11][13], grid[12][12], grid[13][11], grid[12][13], grid[13][12], grid[13][13], ""})
  for r = 1, #red do
    if red[r] == "" then 
      print("Red wins!")
      return true
    end
    if red[r] ~= "[R]" then break end   
  end
  purple = deepcopy({grid[5][14], grid[5][15], grid[6][14], grid[5][16], grid[6][15], grid[7][14], grid[5][17], grid[6][16], grid[7][15], grid[8][14], ""})
  for p = 1, #purple do
    if purple[p] == "" then 
      print("Purple wins!")
      return true
    end
    if purple[p] ~= "[P]" then break end   
  end
  orange = deepcopy({grid[14][5], grid[14][6], grid[15][5], grid[14][7], grid[15][6], grid[16][5], grid[14][8], grid[15][7], grid[16][6], grid[17][5], ""})
  for o = 1, #orange do
    if orange[o] == "" then 
      print("Orange wins!")
      return true
    end
    if orange[o] ~= "[O]" then break end   
  end
  green = deepcopy({grid[1][13], grid[2][12], grid[3][11], grid[4][10], grid[2][13], grid[3][12], grid[4][11], grid[3][13], grid[4][12], grid[4][13], ""})
  for g= 1, #green do
    if green[g] == "" then 
      print("Green wins!")
      return true
    end
    if green[i] ~= "[G]" then break end   
  end
  yellow = deepcopy({grid[10][4], grid[11][3], grid[12][2], grid[13][1], grid[11][4], grid[12][3], grid[13][2], grid[12][4], grid[13][3], grid[13][4], ""})
  for y = 1, #yellow do
    if yellow[y] == "" then 
      print("Yellow wins!")
      return true
    end
    if yellow[y] ~= "[Y]" then break end   
  end
  return false
end
-- Main Loop
current = 0
while not output(board) do
  printGrid(board)
  if current <= (#colours-1) then current = current + 1 else current = 1 end
  print("It is "..colours[current].." move")
  print("Player Move [E.G 6/7/ 7/7]")
  success = false
  repeat
    x1, y1, x2, y2 = io.read("*n","*n", "*n","*n")
    if board[x1][y1] == colours[current] then
      possibleMoves(board, x1, y1)
      test = countOccurrencesList(possibleMoves(board, x1, y1), {x2, y2})
      if test == 1 then
        success = true
      end
    end
  until success
  print("hi")
  board[x2][y2] = colours[current]
  board[x1][y1] = "[ ]"
end

