function love.load()
  --Create 2 rectangles
  player = {
    x = 10,
    y = 100,
    width = 20,
    height = 50
  }

  wall = {
    x = 250,
    y = 0,
    width = 20,
    height = 5000
  }
end

function love.update(dt)
  player.x = player.x + 100 * dt --Make one of rectangle move
end

function love.draw()
  local mode --We create a local variable called mode
  if checkWallCollision(player, wall) then
    mode = "fill" --If there is collision, draw the rectangles filled
  else
    mode = "line" --else, draw the rectangles as a line
  end

  --Use the variable as first argument
  love.graphics.rectangle(mode, player.x, player.y, player.width, player.height)
  love.graphics.rectangle(mode, wall.x, wall.y, wall.width, wall.height)
end

function checkWallCollision(player, wall)
  --With locals it's common usage to use underscores instead of camelCasing
  local player_left = player.x
  local player_right = player.x + player.width
  local player_top = player.y
  local player_bottom = player.y + player.height

  local wall_left = wall.x
  local wall_right = wall.x + wall.width
  local wall_top = wall.y
  local wall_bottom = wall.y + wall.height

  --Directly return this boolean value without using if-statement
  return player_right > wall_left
      and player_left < wall_right
      and player_bottom > wall_top
      and player_top < wall_bottom
end
