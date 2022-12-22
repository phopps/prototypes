require('player')
require('terrain')

function love.load()
  love.window.setTitle("Jumper")

  init_player()

  gravity = 300

  init_terrain()
end

function love.update(dt)
  updatePlayer(dt)
end

function love.draw()
  drawMap()
  drawPlayer()
  -- drawPlatforms()
end

function love.keypressed(key, scancode, isrepeat)
  if scancode == "w" or scancode == "space" then
    jump()
  end
end

function love.mousepressed(x, y, button, istouch, presses)
  --print("clicked the mouse.")
  jump()
end
