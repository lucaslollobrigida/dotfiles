local globals = require('lollo.globals')

if globals.finder == 'fzf' then
  require('lollo.finder.fzf')
else if globals.finder == 'telescope' then
    require('lollo.finder.telescope')
  end
end
