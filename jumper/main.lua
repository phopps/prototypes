require('player')
require('terrain')
require('util')
require('hud')

function love.load()
  love.window.setTitle("Jumper")

  screenWidth = 800
  screenHeight = 600

  init_player()

  gravity = 300

  init_terrain()
  init_hud()
end

function love.update(dt)
  updatePlayer(dt)
  update_hud(dt)
end

function love.draw()
  if hud.gamestate == "start" then
    drawMenuScreen()
  else
    drawMap()
    drawPlayer()
    drawHud()
  end
end

function love.keypressed(key, scancode, isrepeat)
  if hud.gamestate == "start" and scancode == "e" then
    hud.gamestate = "play"
  elseif hud.gamestate == "end" and scancode == "r" then
    restart()
  elseif scancode == "w" or scancode == "space" then
    jump()
  end
end

function love.mousepressed(x, y, button, istouch, presses)
  --print("clicked the mouse.")
  jump()
end
