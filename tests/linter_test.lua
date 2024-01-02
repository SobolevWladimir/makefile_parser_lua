local linter = require('src.linter');
local token_types = require('src.token_types')


lu = require('luaunit')

-- function dump(o)
--   if type(o) == 'table' then
--     local s = '{ '
--     for k, v in pairs(o) do
--       if type(k) ~= 'number' then k = '"' .. k .. '"' end
--       s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
--     end
--     return s .. '} '
--   else
--     return tostring(o)
--   end
-- end

-- local text = require('tests.file').getTextSimple()
-- local result = linter.parse(text)


function testSimple()
  local text   = require('tests.file').getTextSimple()
  local result = linter.parse(text)


  lu.assertEquals(result[1].type, token_types.SPECIAL_TARGET_NAME)
  lu.assertEquals(result[1].value, "DEFAULT_GOAL")
  lu.assertEquals(result[1].command, "help")

  lu.assertEquals(result[2].type, token_types.SPECIAL_TARGET_NAME)
  lu.assertEquals(result[2].value, "PHONY")
  lu.assertEquals(result[2].command, "help build up start down logs sh composer vendor sf cc test")


  lu.assertEquals(result[3].type, token_types.COMMENT)
  lu.assertEquals(result[3].value, "# —— Docker 🐳 ————————————————————————————————————————————————————————————————")

  lu.assertEquals(result[4].type, token_types.COMMENT)
  lu.assertEquals(result[4].value, "# Builds the Docker images")

  lu.assertEquals(result[5].type, token_types.RECIPE)
  lu.assertEquals(result[5].value, "@$(DOCKER_COMP) build")

  lu.assertEquals(result[6].type, token_types.COMMENT)
  lu.assertEquals(result[6].value, "# Builds the Docker")

  lu.assertEquals(result[7].type, token_types.RECIPE)
  lu.assertEquals(result[7].value, "@$(DOCKER_COMP) build --pull --no-cache")
end

os.exit(lu.LuaUnit.run())
