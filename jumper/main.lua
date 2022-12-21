require('player')

function love.load()
  love.window.setTitle("Jumper")

  init_player()

  gravity = 200

  platforms = {}

  createPlatform(0, 580, 800, 20)
end

function love.update(dt)
  updatePlayer(dt)
end

function love.draw()
  drawPlayer()
  drawPlatforms()
end

function love.keypressed(key, scancode, isrepeat)
  if scancode == "r" then
    local res = player_raycast_down()
    print(res)
  end
end

function love.mousepressed(x, y, button, istouch, presses)
  --print("clicked the mouse.")
  jump()
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
  p.height = height
  -- platform height must be > 5 pixels because of player_raycast_down

  table.insert(platforms, p)
end
