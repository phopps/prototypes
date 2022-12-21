require('player')
require('terrain')

function love.load()
  love.window.setTitle("Jumper")

  init_player()
  local joysticks = love.joystick.getJoysticks()
  joystick = joysticks[1]

  gravity = 200

  platforms = {}
  walls = {}

  createPlatform(0, 580, 800, 20) -- floor.
  createPlatform(400, 380, 200, 20)
  createPlatform(0, 440, 200, 20)
  createPlatform(100, 500, 200, 20)
end

function love.update(dt)
  updatePlayer(dt)
end

function love.draw()
  drawPlayer()
  drawPlatforms()
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