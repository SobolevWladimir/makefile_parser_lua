local token_types = require "src.token_types"
local M = {
  position = 0,
  column = 0,
  row = 0,
  text = "",
}


function M.parse(text)
  M.text       = text
  M.position   = 0
  M.column     = 0
  M.row        = 0

  local result = {};
  while not M.isEnd() do
    local value = M.readNext()
    if value then
      table.insert(result, value)
    end
  end
  return result;
end

function M.readNext()
  while not M.isEnd() do
    if M.isComment() then
      return M.readComment();
    end
    M.nextSymbol()
  end
  return nil;
end

function M.nextSymbol()
  M.position = M.position + 1

  if M.isNewLine() then
    M.position = M.position + 1
    M.column = 0
    M.row = M.row + 1
  else
    M.column = M.column + 1
  end
end;

function M.isNewLine()
  local currentSymbol = M.getCurrentSymbol();
  return M.symbolIsNewLine(currentSymbol)
end

function M.symbolIsNewLine(currentSymbol)
  if currentSymbol == '\n\r' or currentSymbol == '\n' or currentSymbol == '\r' then
    return true;
  end
  return false
end

function M.getCurrentSymbol()
  return string.sub(M.text, M.position, M.position)
end;

function M.isEnd()
  return M.position >= string.len(M.text)
end

function M.isComment()
  local currentSymbol = M.getCurrentSymbol();
  if currentSymbol == '#' then
    return true;
  end
  return false
end

function M.readComment()
  M.nextSymbol();
  local row    = M.row
  local column = M.column
  local text   = ""
  while not M.isEnd() do
    text = text .. M.getCurrentSymbol();
    local nextSymbol = string.sub(M.text, M.position + 1, M.position + 1)
    if M.symbolIsNewLine(nextSymbol) then
      break
    end
    M.nextSymbol()
  end
  return token_types.createToken(token_types.COMMENT, text, row, column)
end

return M
