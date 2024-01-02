local M = {
  position = 0,
  column = 0,
  row = 0,
}


function M.parse(test)
  for i = 0, 10 do
    print('test:');
    print(tostring(i), ":", test:sub(i, i))
  end
end

return M
