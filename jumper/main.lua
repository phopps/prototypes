function love.load()
  love.window.setTitle("Jumper")

  player = {}
  player.x = 400
  player.y = 300
  player.width = 20
  player.height = 50
  player.y_velocity = 0
  player.terminal_velocity = 20
  player.jump_strength = -200

  gravity = 20

  platforms = {}

  createPlatform(0, 580, 800, 20)
end

function love.update(dt)
  updatePlayer(dt)

  checkCollisions()
end

function love.draw()
  drawPlayer()
  drawPlatforms()
end

function love.keypressed(key, scancode, isrepeat)
  if scancode == "r" then
    local res = player_raycast_down(player.x+(player.width/2), player.y+(player.height/2))
    print(res)
  end
end

function love.mousepressed(x, y, button, istouch, presses)
  --print("clicked the mouse.")
  if player.touch_ground == true then
    player.y_velocity = player.jump_strength
    player.touch_ground = false
  end
end

function updatePlayer(dt)
  player.y_velocity = player.y_velocity + (gravity * dt)
  --terminal velocity
  if player.y_velocity > player.terminal_velocity then
    player.y_velocity = player.terminal_velocity
  end

  -- am I about to hit something?
  if player.touch_ground == true and player.y_velocity > 0 then
    player.y_velocity = 0
  else
    player.y = player.y + (player.y_velocity * dt)
  end
end

function drawPlayer()
  love.graphics.setColor(1, 0, 0, 1)
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
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

  table.insert(platforms, p)
end

function checkCollisions()
  -- check intersections between - player and each platform

  local player_left, player_right, player_top, player_bottom
  player_left = player.x
  player_right = player.x + player.width
  player_top = player.y
  player_bottom = player.y + player.height

  for i, plat in ipairs(platforms) do
    -- does this collide with the player?
    local plat_left, plat_right, plat_top, plat_bottom
    plat_left = plat.x
    plat_right = plat.x + plat.width
    plat_top = plat.y
    plat_bottom = plat.y + plat.height

    if plat_left < player_right and plat_right > player_left and plat_top < player_bottom and plat_bottom > player_top then
      print("COLLIDE")
    elseif plat_left < player_right and plat_right > player_left and plat_top < player_bottom + 20 and plat_bottom > player_top then
      --print("downward check")
      player.touch_ground = true
    -- else
    --   player.touch_ground = false
    end
  end

  --extra step to check player feet?
end

function is_player_on_ground()
end

function player_raycast_down(playermidx, playermidy)
  -- extend a ray downward (positive y)
  for ray=player.height/2,600,5 do
    --is playerx, playermidy + ray inside a collision box
    --print(ray)
    for i, plat in ipairs(platforms) do
      -- does this collide with the player?
      local plat_left, plat_right, plat_top, plat_bottom
      plat_left = plat.x
      plat_right = plat.x + plat.width
      plat_top = plat.y
      plat_bottom = plat.y + plat.height

      if playermidx < plat_right and playermidx > plat_left and playermidy + ray > plat_top and playermidy + ray < plat_bottom then
        -- ray hit platform. return useful data?
        return ray
      end

    end
  end

  return false
end
