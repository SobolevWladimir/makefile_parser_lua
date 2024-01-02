local parser = require('src.parser');
local token_types = require('src.token_types')


lu = require('luaunit')


function testSimple()
  local text = require('tests.file').getTextSimple()
  parser.parse(text)
  local targets = parser.targets

  lu.assertEquals(targets[1].value, "build")
  lu.assertEquals(targets[1].comment, "# Builds the Docker images")

  lu.assertEquals(targets[2].value, "build-cache")
  lu.assertEquals(targets[2].comment, "# Builds the Docker")
end

os.exit(lu.LuaUnit.run())
