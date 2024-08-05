--[[

                             R
                            [A]
                          [A]|[A]
                         [A][A][A]
         P             [A][A]|[A][A]              G 
          [A][A][A][A][ ][ ][ ][ ][ ][A][A][A][A]
           [A][A][A][ ][ ][ ]|[ ][ ][ ][A][A][A]
             [A][A][ ][ ][ ][ ][ ][ ][ ][A][A]
              [A][ ][ ][ ][ ]|[ ][ ][ ][ ][A]
                [ ][ ][ ][ ][ ][ ][ ][ ][ ]  
              [A][ ][ ][ ][ ]|[ ][ ][ ][ ][A]   
  q          [A][A][ ][ ][ ][ ][ ][ ][ ][A][A]           q
   p       [A][A][A][ ][ ][ ]|[ ][ ][ ][A][A][A]        p
    o     [A][A][A][A][ ][ ][ ][ ][ ][A][A][A][A]      o
      n  O             [A][A]|[A][A]              Y  n
        m                [A][A][A]                 m
         l                [A]|[A]                 l 
           k                [A]                 k
             j               B                j
              i                              i
                h                          h
                 g                        g
                  f                      f
                   e                    e
                      d              d  
                        c          c
                          b      b
                           a    a


]]--

grid = {
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
      if list[i] == target then
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
    grid[5][5], grid[5][6], grid[6][5], grid[5][7], grid[6][6], grid[7][5], grid[5][8], grid[6][7], grid[7][6], grid[8][5] = "[R]", "[R]", "[R]", "[R]", "[R]", "[R]", "[R]", "[R]", "[R]", "[R]"
    if players == 2 or players == 6 then 
      colours = {"R, B"}
      grid[10][13], grid[11][12], grid[12][11], grid[13][10], grid[11][13], grid[12][12], grid[13][11], grid[12][13], grid[13][12], grid[13][13] = "[B]", "[B]", "[B]", "[B]", "[B]", "[B]", "[B]", "[B]", "[B]", "[B]"
    end
    if players == 3 or players == 6 then
      colours = {"R", "G", "Y"}
      grid[5][14], grid[5][15], grid[6][14], grid[5][16], grid[6][15], grid[7][14], grid[5][17], grid[6][16], grid[7][15], grid[8][14] = "[Y]", "[Y]", "[Y]", "[Y]", "[Y]", "[Y]", "[Y]", "[Y]", "[Y]", "[Y]"
      grid[14][5], grid[14][6], grid[15][5], grid[14][7], grid[15][6], grid[16][5], grid[14][8], grid[15][7], grid[16][6], grid[17][5] = "[G]", "[G]", "[G]", "[G]", "[G]", "[G]", "[G]", "[G]", "[G]", "[G]"
    end
    if players == 6 then
      colours = {"R", "P", "G", "B", "Y", "O"}
      grid[1][13], grid[2][12], grid[3][11], grid[4][10], grid[2][13], grid[3][12], grid[4][11], grid[3][13], grid[4][12], grid[4][13] = "[O]", "[O]", "[O]", "[O]", "[O]", "[O]", "[O]", "[O]", "[O]", "[O]"
      grid[10][4], grid[11][3], grid[12][2], grid[13][1], grid[11][4], grid[12][3], grid[13][2], grid[12][4], grid[13][3], grid[13][4] = "[P]", "[P]", "[P]", "[P]", "[P]", "[P]", "[P]", "[P]", "[P]", "[P]"
    end
    valid = true
  end
until valid

-- Finds all possible moves for a certain piece
function possibleMoves(grid, x, y)
  moves = {}
  -- Adjacent
  if grid[x+1][y] == "[ ]" then moves[#moves + 1] = {x+1, y} end 
  if grid[x+1][y-1] == "[ ]" then moves[#moves + 1] = {x+1, y-1} end 
  if grid[x][y+1] == "[ ]" then moves[#moves + 1] = {x, y+1} end 
  if grid[x][y-1] == "[ ]" then moves[#moves + 1] = {x, y-1} end 
  if grid[x-1][y] == "[ ]" then moves[#moves + 1] = {x-1, y} end 
  if grid[x-1][y+1] == "[ ]" then moves[#moves + 1] = {x+1, y+1} end 
  -- Jumps
  jumps = {}
  while true do
    currentX, currentY = deepcopy(x), deepcopy(y)
    repeat
      lastX, lastY = deepcopy(currentX, currentY)    
      if grid[currentX+2][currentY] == "[ ]" and grid[currentX+1][currentY] ~= "[ ]" and grid[currentX+1][currentY] ~= "[x]" and countOccurrencesList({currentX+2, currentY}) == 0 then
        jumps[#jumps+1] = {currentX+2, currentY}
        currentX = currentX+2
        newPath = true
      end
      if grid[currentX-2][currentY+2] == "[ ]" and grid[currentX-1][currentY+1] ~= "[ ]" and grid[currentX-1][currentY+1] ~= "[x]" and countOccurrencesList({currentX-2, currentY+2}) == 0 then
        jumps[#jumps+1] = {currentX+2, currentY}
        currentX, currentY = currentX-2, currentY+2
        newPath = true
      elseif lastX == x and lastY == y then
        break
      end
      currentX, currentY = deepcopy(lastX), deepcopy(lastY)
    until newPath
    break
  end
end
