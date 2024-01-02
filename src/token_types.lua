local M = {
  TARGET        = 'target',
  COMMAND       = 'command',
  PREREQUISITES = 'prerequisites',
  RECIPE        = 'recipe',
  VARIABLE      = 'variable'
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
