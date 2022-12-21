
function drawPlatforms()
  love.graphics.setColor(0, 1, 0, 1)
  for i, plat in ipairs(platforms) do
    love.graphics.rectangle("fill", plat.x, plat.y, plat.width, plat.height)
  end
end

function createPlatform(x, y, width, height)
  local p = {}
  p.x = x
  p.y = y
  p.width = width
  p.height = 20
  -- platform height must be > 5 pixels because of player_raycast_down

  table.insert(platforms, p)
end

function drawWalls()

  love.graphics.setColor(0, 0.8, 0.5, 1)
  for i, plat in ipairs(walls) do
    love.graphics.rectangle("fill", plat.x, plat.y, plat.width, plat.height)
  end
end

function createWall(x,y,width,height)

end