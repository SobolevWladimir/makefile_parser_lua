local M = {
  COMMENT       = 'comment',
  COMMAND       = 'command',
  PREREQUISITES = 'prerequisites',
  RECIPE        = 'recipe'
}

function M.createToken(type, value, row, column)
  return {
    type   = type,
    value  = value,
    row    = row,
    column = column
  }
end

return M