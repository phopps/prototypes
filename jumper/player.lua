function init_player()
  player = {}
  player.x = 400
  player.y = 300
  player.width = 20
  player.height = 50
  player.y_velocity = 0
  player.x_velocity = 0
  player.x_accel = 300
  player.x_friction = 500
  player.x_max_speed = 200
  player.x_vel_deadzone = 15
  player.terminal_velocity = 200
  player.jump_strength = -200
  player.about_to_land = false
end

function ice_physics()
  player.x_accel = 100
  player.x_friction = 100
  player.x_max_speed = 200
end

function updatePlayer(dt)

  --Horizontal stuff
  if love.keyboard.isDown("a") then
    moveleft(dt)
  end
  if love.keyboard.isDown("d") then
    moveright(dt)
  end

  if joystick:isGamepadDown("dpleft") then
    moveleft(dt)
  end
  if joystick:isGamepadDown("dpright") then
    moveright(dt)
  end
  function love.joystickpressed(joystick, button)
    if joystick:isDown(1) and not joystick:isGamepadDown("dpright") and not joystick:isGamepadDown("dpleft") and not joystick:isGamepadDown("dpup") and not joystick:isGamepadDown("dpdown") then
      jump()
      print('jump')
    end
  end

  if not love.keyboard.isDown("d") and not love.keyboard.isDown("a") and not joystick:isGamepadDown("dpleft") and not joystick:isGamepadDown("dpright") then
    horiz_friction(dt)
  end

  if player.x_velocity > 0 and player.x_velocity > player.x_max_speed then
    player.x_velocity = player.x_max_speed
  elseif player.x_velocity < 0 and player.x_velocity < player.x_max_speed * -1 then
    player.x_velocity = player.x_max_speed * -1
  end
  player.x = player.x + (player.x_velocity * dt)

  --Vertical stuff
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

  if player.touch_ground == true and dist > 10 then
    player.touch_ground = false
  end

  if player.touch_ground == true and player.y_velocity > 0 then
    player.y_velocity = 0
  else
    player.y = player.y + (player.y_velocity * dt)
  end

  checkPlatformCollisions()
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

function moveleft(dt)
  moveside(-1, dt)
end

function moveright(dt)
  moveside(1, dt)
end

function moveside(whichside, dt)
  --whichside is -1 for left, 1 for right

  --air control? acceleration? momentum?
  if player.x_velocity == 0 then
    player.x_velocity = whichside * player.x_max_speed / 5
  end
  player.x_velocity = player.x_velocity + (whichside * player.x_accel * dt)
end

function horiz_friction(dt)
  -- every frame, x_velocity decays by half accel
  --print(player.x_velocity)
  if player.x_velocity > player.x_vel_deadzone then
    --subtract
    player.x_velocity = player.x_velocity + (-1 * player.x_friction * dt)
  elseif player.x_velocity < (player.x_vel_deadzone * -1) then
    --add
    player.x_velocity = player.x_velocity + (1 * player.x_friction * dt)
  else
    player.x_velocity = 0
  end
end

function is_player_on_ground()
end

function player_raycast_down()
  --local playermidx = player.x + (player.width/2)
  local player_left = player.x
  local player_right = player.x+player.width
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

      if player_left < plat_right and player_right > plat_left and player_bottom + ray > plat_top and player_bottom + ray < plat_bottom then
        -- ray hit platform. return useful data?
        return ray
      end

    end
  end

  return false
end

function checkPlatformCollisions()
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
    plat_bottom = plat.y + 5

    if plat_left < player_right and plat_right > player_left and plat_top < player_bottom and plat_bottom > player_bottom-5 then
      --print("COLLIDE")
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