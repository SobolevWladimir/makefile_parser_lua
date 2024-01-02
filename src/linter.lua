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
  -- for i = 0, string.len(test) do
  --   table.insert(result, test:sub(i, i));
  -- end
  return result;
end

function M.readNext()
  while not M.isEnd() do
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
  if currentSymbol == "\n\r" or currentSymbol == "\n" or currentSymbol == "\r" then
    return true;
  end
  return false
end

function M.getCurrentSymbol()
  return M.text.sub(M.position, M.position)
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

return M
