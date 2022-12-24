function init_hud()

  hud = {}
  hud.score = 0
  hud.timer = 0
  hud.gamestate = "start"
  hud.r = 1
  hud.g = 0.5
  hud.b = 0
  hud.colorSpeed = 0.3

  --fonts
  font = love.graphics.newFont("assets/ChakraPetch-regular.ttf", 24)
  font2 = love.graphics.newFont("assets/Righteous-regular.ttf", 40)

end

function update_hud(dt)
  if hud.gamestate == "play" then
    hud.timer = hud.timer + dt

    if map.ypos >= 0 then
      -- reached top of map, game end.
      hud.gamestate = "end"
    end
  else
    hud.r = hud.r + hud.colorSpeed * dt
    hud.g = hud.g + hud.colorSpeed * dt
    hud.b = hud.b + hud.colorSpeed * dt
    if hud.r > 1 then
      hud.r = 0
    end
    if hud.g > 1 then
      hud.g = 0
    end
    if hud.b > 1 then
      hud.b = 0
    end
  end
end

function addPoints(amt)
  if hud.gamestate == "play" then
    hud.score = hud.score + math.abs(amt)
  end
end

function subtractPoints(amt)
  if hud.gamestate == "play" then
    hud.score = hud.score - math.abs(amt)
  end
end

function gameOver()
  -- when called, end game, show final score, allow for restart.
end

function restart()
  hud.score = 0
  hud.timer = 0
  map.ypos = map.initial_ypos
  hud.gamestate = "play"
end

function drawHud()
  love.graphics.setColor(0.2,0.2,0.2)
  love.graphics.rectangle("fill",45,45,110,40)
  love.graphics.rectangle("fill",645,45,110,40)
  love.graphics.setColor(hud.r,hud.g,hud.b)
  love.graphics.printf(math.floor(hud.score), font, 50,50,100)
  love.graphics.printf(math.floor(hud.timer), font, 650,50,100)

  if hud.gamestate == "end" then
    love.graphics.printf("Final score:"..math.floor(hud.score).."\nFinal time:"..math.floor(hud.timer).." seconds\n\nPress R to restart!", font, 250, 350, 300, "center")
  end
end

function drawMenuScreen()
  love.graphics.setColor(0.2,0.2,0.3)
  love.graphics.rectangle("fill",0,0,screenWidth, screenHeight)
  love.graphics.setColor(hud.r,hud.g,hud.b)
  love.graphics.printf("Jumper!\n(working title)", font2, 250, 150, 300, "center")
  love.graphics.printf("Use A-D to move left-right!\nW or Spacebar to jump!\n\nPress E to start!", font, 250, 350, 300, "center")
end