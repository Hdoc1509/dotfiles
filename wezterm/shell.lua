local user_os = require('wezterm').target_triple

local shell = {}
local shell_name = 'zsh'

local win_shell = 'C:/Program Files/Git/usr/bin/' .. shell_name .. '.exe'
local linux_shell = '/usr/bin/' .. shell_name

if user_os == 'x86_64-pc-windows-msvc' then
	shell = { win_shell }
else
  shell = { linux_shell }
end

table.insert(shell, '-l')

return shell
