function init_terrain()

  platforms = {}
  walls = {}

  map = {}
  map.width = screenWidth
  map.height = 6000
  map.canvas = love.graphics.newCanvas(map.width, map.height)
  map.ypos = -1 * (map.height - screenHeight)
  map.initial_ypos = map.ypos
  map.top_margin = 100

  createPlatform(0, (map.height - 20), screenWidth, 20) -- floor.
  
  buildMap()
  paintMap()
end

function buildMap()
  for y=0,map.height,140 do
    local x = love.math.random(0,500)
    local width = love.math.random(100,400)
    createPlatform(x, (map.height-y), width, 20)

  end
end

function drawMap()
  love.graphics.setBlendMode("alpha", "premultiplied")
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(map.canvas, 0, map.ypos)
  love.graphics.setBlendMode("alpha")
end

function paintMap()
  love.graphics.setCanvas(map.canvas)
  -- love.graphics.setColor(0.3,0.2,0.2,1)
  -- love.graphics.rectangle("fill", 0,0,map.width,map.height)

  -- local greyscale = gradient {
  --   direction = 'vertical';
  --   {0, 0, 0};
  --   {255, 255, 255};
  -- }
  -- drawinrect(greyscale, 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

  rainbow = gradientMesh("vertical",
    {0.1, 0.1, 0.2}, --sky
    {0.7, 0.7, 1},
    {0.3, 0.2, 0.2} --ground
  )
  love.graphics.draw(rainbow, 0, 0, 0, map.width, map.height)
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