_G.love = require("love")

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

print("How many players are there? [2/3/6]")
valid = false
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


function output(grid)
  blue = {grid[5][5], grid[5][6], grid[6][5], grid[5][7], grid[6][6], grid[7][5], grid[5][8], grid[6][7], grid[7][6], grid[8][5], ""}
  for b = 1, #blue do
    if blue[b] == "" then 
      love.graphics.print("Blue wins!", 10, 10)
      return true
    end
    if blue[i] ~= "[B]" then break end   
  end
  red = {grid[10][13], grid[11][12], grid[12][11], grid[13][10], grid[11][13], grid[12][12], grid[13][11], grid[12][13], grid[13][12], grid[13][13], ""}
  for r = 1, #red do
    if red[r] == "" then    
      love.graphics.print("Red wins!", 10, 10)
      return true
    end
    if red[r] ~= "[R]" then break end   
  end
  purple = {grid[5][14], grid[5][15], grid[6][14], grid[5][16], grid[6][15], grid[7][14], grid[5][17], grid[6][16], grid[7][15], grid[8][14], ""}
  for p = 1, #purple do
    if purple[p] == "" then 
      love.graphics.print("Purple wins!", 10, 10)
      return true
    end
    if purple[p] ~= "[P]" then break end   
  end
  orange = {grid[14][5], grid[14][6], grid[15][5], grid[14][7], grid[15][6], grid[16][5], grid[14][8], grid[15][7], grid[16][6], grid[17][5], ""}
  for o = 1, #orange do
    if orange[o] == "" then 
      love.graphics.print("Orange wins!", 10, 10)
      return true
    end
    if orange[o] ~= "[O]" then break end   
  end
  green = {grid[1][13], grid[2][12], grid[3][11], grid[4][10], grid[2][13], grid[3][12], grid[4][11], grid[3][13], grid[4][12], grid[4][13], ""}
  for g= 1, #green do
    if green[g] == "" then 
      love.graphics.print("Green wins!", 10, 10)
      return true
    end
    if green[i] ~= "[G]" then break end   
  end
  yellow = {grid[10][4], grid[11][3], grid[12][2], grid[13][1], grid[11][4], grid[12][3], grid[13][2], grid[12][4], grid[13][3], grid[13][4], ""}
  for y = 1, #yellow do
    if yellow[y] == "" then 
      love.graphics.print("Yellow wins!", 10, 10)
      return true
    end
    if yellow[y] ~= "[Y]" then break end   
  end
  return false
end

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
  for m = 1, #moves do
    if moves[m][1] == x and moves[m][2] == y then remove = deepcopy(m) end
  end
  table.remove(moves, remove)
  return moves
end

function love.load()
    love.graphics.setBackgroundColor(151/255, 147/255, 141/255)
    current = 1
    gameEnded = false
    mouseStates = {
      isDragging = false,
      startX = 0,
      startY = 0,
      endX = 0,
      endY = 0
  }
end

function love.update(dt)
    if not gameEnded then
        if output(board) then
            gameEnded = true
            return
        end
        success = makeMove(mouseStates.startX, mouseStates.startY, mouseStates.endX, mouseStates.endY, colours[current])
        if success[1] then
          board[success[4]][success[5]] = colours[current]
          board[success[2]][success[3]] = "[ ]"
          current = (current % #colours) + 1
          mouseStates.startX, mouseStates.startY, mouseStates.endX, mouseStates.endY = 0, 0, 0, 0
          highlightedX, highlightedY = 0, 0
        end
        mouseStates.endX, mouseStates.endY = 0, 0
    end
end

function isPointInPolygon(px, py, vertices)
  local inside = false
  local n = #vertices
  for i = 1, n, 2 do
      local j = i + 2
      if j > n then j = 1 end
      local xi, yi = vertices[i], vertices[i+1]
      local xj, yj = vertices[j], vertices[j+1]
      if ((yi > py) ~= (yj > py)) and (px < (xj - xi) * (py - yi) / (yj - yi) + xi) then
          inside = not inside
      end
  end
  return inside
end

function mouseInput(x, y)
  for i = 1, #board do
    for j = 1, #board do
      if board[i][j] ~= "[x]" then
        pointX = (i-5) * (-16) + (j-5) * 16 + 300
        pointY = (i-5) * 28 + (j-5) * 28 + 70
        hexagonVertices = {pointX, pointY-12, pointX+16, pointY, pointX+16, pointY+16, pointX, pointY+28, pointX-16, pointY+16, pointX-16, pointY}
        if isPointInPolygon(x, y, hexagonVertices) then
          return {i, j}
        end
      end
    end
  end
  return {0, 0}
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then -- Left mouse button
        -- Record the starting point of the mouse press
        if mouseStates.startX == 0 and mouseStates.startY == 0 then
          mouseStates.isDragging = true
          mouseStates.startX = deepcopy(x)
          mouseStates.startY = deepcopy(y)
        elseif mouseStates.startX ~= 0 and mouseStates.startY ~= 0 then
          mouseStates.endX = deepcopy(x)
          mouseStates.endY = deepcopy(y)
          mouseStates.isDragging = false
        end
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if button == 1 and mouseStates.isDragging then -- Left mouse button
        -- Record the endpoint of the drag
        if not (mouseStates.startX == x and mouseStates.startY == y) then
          mouseStates.endX = deepcopy(x)
          mouseStates.endY = deepcopy(y)
          mouseStates.isDragging = false
        end
    end
end

function hexagon(x, y)
  posX = (x-5) * (-16) + (y-5) * 16 + 300
  posY = (x-5) * 28 + (y-5) * 28 + 70
  love.graphics.polygon("fill", posX, posY-12, posX+16, posY, posX+16, posY+16, posX, posY+28, posX-16, posY+16, posX-16, posY)
  love.graphics.setColor(0, 0, 0)
  love.graphics.polygon("line", posX, posY-12, posX+16, posY, posX+16, posY+16, posX, posY+28, posX-16, posY+16, posX-16, posY)
end

function hexagon2(x, y)
  posX = (x-5) * (-16) + (y-5) * 16 + 300
  posY = (x-5) * 28 + (y-5) * 28 + 70
  love.graphics.setColor(234/255, 210/255, 180/255, 0.3)
  love.graphics.polygon("fill", posX, posY-12, posX+16, posY, posX+16, posY+16, posX, posY+28, posX-16, posY+16, posX-16, posY)
end

function hexagon3(x, y)
  posX = (x-5) * (-16) + (y-5) * 16 + 300
  posY = (x-5) * 28 + (y-5) * 28 + 70
  love.graphics.setColor(208/255, 185/255, 156/255)
  love.graphics.polygon("fill", posX, posY-12, posX+16, posY, posX+16, posY+16, posX, posY+28, posX-16, posY+16, posX-16, posY)
end

function printGrid(board)
    for boardX = 1, #board do
        for boardY = 1, #board[boardX] do
            if (boardX == highlightedX and boardY == highlightedY) then
              hexagon2(boardX, boardY)
            end
            if board[boardX][boardY] ~= colours[current] or not (boardX == highlightedX and boardY == highlightedY) then
              if board[boardX][boardY] == "[ ]" then
                love.graphics.setColor(239/255, 215/255, 184/255)
                hexagon(boardX, boardY)
              elseif board[boardX][boardY] == "[R]" then
                  love.graphics.setColor(288/255, 76/255, 76/255, 0.85) 
                  if board[boardX][boardY] == colours[current] then love.graphics.setColor(288/255, 76/255, 76/255) end
                  hexagon(boardX, boardY)
              elseif board[boardX][boardY] == "[P]" then
                  love.graphics.setColor(197/225, 112/225, 228/225, 0.85) 
                  if board[boardX][boardY] == colours[current] then love.graphics.setColor(197/225, 112/225, 228/225) end
                  hexagon(boardX, boardY)
              elseif board[boardX][boardY] == "[G]" then
                  love.graphics.setColor(109/225, 190/225, 95/225, 0.85) 
                  if board[boardX][boardY] == colours[current] then love.graphics.setColor(109/225, 190/225, 95/225) end
                  hexagon(boardX, boardY)
              elseif board[boardX][boardY] == "[B]" then
                  love.graphics.setColor(73/225, 104/225, 176/225, 0.85)
                  if board[boardX][boardY] == colours[current] then love.graphics.setColor(73/225, 104/225, 176/225) end 
                  hexagon(boardX, boardY)
              elseif board[boardX][boardY] == "[Y]" then
                  love.graphics.setColor(255/225, 228/225, 73/225, 0.85) 
                  if board[boardX][boardY] == colours[current] then love.graphics.setColor(255/225, 228/225, 73/225) end
                  hexagon(boardX, boardY)
              elseif board[boardX][boardY] == "[O]" then
                  love.graphics.setColor(255/255, 175/255, 90/225, 0.85)
                  if board[boardX][boardY] == colours[current] then love.graphics.setColor(255/255, 175/255, 90/225) end
                  hexagon(boardX, boardY)
              end
              if nextMoves ~= nil and countOccurrencesList(nextMoves, {boardX, boardY}) == 1 and board[startingX][startingY] == colours[current] then
                hexagon3(boardX, boardY)
              end
            end
        end
    end
end

function makeMove(x1, y1, x2, y2, piece)
  location = mouseInput(x1, y1)
  if location[1] == 0 and location[2] == 0 then return {false} end
  if board[location[1]][location[2]] ~= piece then 
    mouseStates.startX, mouseStates.startY, mouseStates.endX, mouseStates.endY = 0, 0, 0, 0
    return {false} 
  end
  startingX, startingY = location[1], location[2]
  nextMoves = possibleMoves(board, startingX, startingY)
  highlightedX, highlightedY = deepcopy(startingX), deepcopy(startingY)
  location2 = mouseInput(x2, y2)
  if location2[1] == 0 and location2[2] == 0 then return {false} end
  finishingX, finishingY = location2[1], location2[2]
  if countOccurrencesList(nextMoves, {finishingX, finishingY}) == 1 then
    return {true, startingX, startingY, finishingX, finishingY}
  else
    mouseStates.startX, mouseStates.startY, mouseStates.endX, mouseStates.endY = 0, 0, 0, 0
    return {false}
  end
end

function love.draw()
    printGrid(board)
    if gameEnded then
      love.graphics.setColor(1, 1, 1)
      love.graphics.print("Game Over! Press R to Restart.", 10, 10)
    end
end


