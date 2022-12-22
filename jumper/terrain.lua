function init_terrain()

  platforms = {}
  walls = {}

  map = {}
  map.width = 800
  map.height = 4000
  map.canvas = love.graphics.newCanvas(map.width, map.height)
  map.ypos = -3400
  map.top_margin = 100

  createPlatform(0, 3980, 800, 20) -- floor.
  createPlatform(400, 3780, 200, 20)
  createPlatform(0, 3840, 200, 20)
  createPlatform(100, 3900, 200, 20)

  paintMap()
end

function drawMap()
  love.graphics.setBlendMode("alpha", "premultiplied")
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(map.canvas, 0, map.ypos)
end

function paintMap()
  love.graphics.setCanvas(map.canvas)
  love.graphics.setColor(0.3,0.2,0.2,1)
  love.graphics.rectangle("fill", 0,0,map.width,map.height)
  drawPlatforms()
  love.graphics.setCanvas()
end

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