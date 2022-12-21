function init_player()
  player = {}
  player.x = 400
  player.y = 300
  player.width = 20
  player.height = 50
  player.y_velocity = 0
  player.terminal_velocity = 200
  player.jump_strength = -200
  player.about_to_land = false
end

function updatePlayer(dt)
  player.y_velocity = player.y_velocity + (gravity * dt)
  --terminal velocity
  if player.y_velocity > player.terminal_velocity then
    player.y_velocity = player.terminal_velocity
  end

  -- am I about to hit something?
  local dist = player_raycast_down()
  -- print(dist)
  if dist and dist < player.terminal_velocity then
    --about to land
    -- on *next frame* if we collide, then stop.
    player.about_to_land = true
  else
    player.about_to_land = false
  end

  if player.touch_ground == true and player.y_velocity > 0 then
    player.y_velocity = 0
  else
    player.y = player.y + (player.y_velocity * dt)
  end

  checkCollisions()
end

function drawPlayer()
  love.graphics.setColor(1, 0, 0, 1)
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

function jump()
  if player.touch_ground == true then
    player.y_velocity = player.jump_strength
    player.touch_ground = false
  end
end

function is_player_on_ground()
end

function player_raycast_down()
  local playermidx = player.x + (player.width/2)
  local player_bottom = player.y + player.height
  -- extend a ray downward (positive y)
  for ray=0,600,5 do -- make sure platform height is > 5 pixels
    --is playerx, playermidy + ray inside a collision box
    --print(ray)
    for i, plat in ipairs(platforms) do
      -- does this collide with the player?
      local plat_left, plat_right, plat_top, plat_bottom
      plat_left = plat.x
      plat_right = plat.x + plat.width
      plat_top = plat.y
      plat_bottom = plat.y + plat.height

      if playermidx < plat_right and playermidx > plat_left and player_bottom + ray > plat_top and player_bottom + ray < plat_bottom then
        -- ray hit platform. return useful data?
        return ray
      end

    end
  end

  return false
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
      -- print(player.about_to_land)
      -- print(player.y_velocity)
      if player.about_to_land and player.y_velocity > 0 then
        player.touch_ground = true
        player.y = plat_top - (player.height + 1)
      end
    -- elseif plat_left < player_right and plat_right > player_left and plat_top < player_bottom + 20 and plat_bottom > player_top then
    --   --print("downward check")
    --   player.touch_ground = true
    -- else
    --   player.touch_ground = false
    end
  end

  --extra step to check player feet?
end