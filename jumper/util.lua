function drawinrect(img, x, y, w, h, r, ox, oy, kx, ky)
  return -- tail call for a little extra bit of efficiency
  love.graphics.draw(img, x, y, r, w / img:getWidth(), h / img:getHeight(), ox, oy, kx, ky)
end

local COLOR_MUL = love._version >= "11.0" and 1 or 255

function gradientMesh(dir, ...)
  -- Check for direction
  local isHorizontal = true
  if dir == "vertical" then
    isHorizontal = false
  elseif dir ~= "horizontal" then
    error("bad argument #1 to 'gradient' (invalid value)", 2)
  end

  -- Check for colors
  local colorLen = select("#", ...)
  if colorLen < 2 then
    error("color list is less than two", 2)
  end

  -- Generate mesh
  local meshData = {}
  if isHorizontal then
    for i = 1, colorLen do
      local color = select(i, ...)
      local x = (i - 1) / (colorLen - 1)

      meshData[#meshData + 1] = {x, 1, x, 1, color[1], color[2], color[3], color[4] or (1 * COLOR_MUL)}
      meshData[#meshData + 1] = {x, 0, x, 0, color[1], color[2], color[3], color[4] or (1 * COLOR_MUL)}
    end
  else
    for i = 1, colorLen do
      local color = select(i, ...)
      local y = (i - 1) / (colorLen - 1)

      meshData[#meshData + 1] = {1, y, 1, y, color[1], color[2], color[3], color[4] or (1 * COLOR_MUL)}
      meshData[#meshData + 1] = {0, y, 0, y, color[1], color[2], color[3], color[4] or (1 * COLOR_MUL)}
    end
  end

  -- Resulting Mesh has 1x1 image size
  return love.graphics.newMesh(meshData, "strip", "static")
end

function gradient(colors)
  local direction = colors.direction or "horizontal"
  if direction == "horizontal" then
    direction = true
  elseif direction == "vertical" then
    direction = false
  else
    error("Invalid direction '" .. tostring(direction) .. "' for gradient.  Horizontal or vertical expected.")
  end
  local result = love.image.newImageData(direction and 1 or #colors, direction and #colors or 1)
  for i, color in ipairs(colors) do
    local x, y
    if direction then
      x, y = 0, i - 1
    else
      x, y = i - 1, 0
    end
    result:setPixel(x, y, color[1], color[2], color[3], color[4] or 255)
  end
  result = love.graphics.newImage(result)
  result:setFilter('linear', 'linear')
  return result
end