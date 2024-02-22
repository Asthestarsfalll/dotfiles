local wezterm = require('wezterm')
local platform = require('utils.platform')()

-- Seeding random numbers before generating for use
-- Known issue with lua math library
-- see: https://stackoverflow.com/questions/20154991/generating-uniform-random-numbers-in-lua
math.randomseed(os.time())
math.random()
math.random()
math.random()

local PATH_SEP = platform.is_win and '\\' or '/'

---@class BackDrops
---@field current_idx number index of current image
---@field files string[] background images
local BackDrops = {}

--- Initialise backdrop controller
---@private
function BackDrops:init()
   self.__index = self
   local inital = {
      current_idx = 1,
      files = {},
   }
   local backdrops = setmetatable(inital, self)
   self.opacity = 0.5
   self.is_empty = true
   return backdrops
end

---MUST BE RUN BEFORE ALL OTHER `BackDrops` functions
---Workaround to set the `files` after instantiating `BackDrops`.
---WezTerm's fs utilities `read_dir` and `glob` work by running on a spawned child process.
---This throws a coroutine error if either of these functions are invoked in outside of `wezterm.lua`
---in the initial load of the Terminal config
function BackDrops:set_files()
   self.files = wezterm.read_dir('/data/wezterm_background')
   wezterm.GLOBAL.background = '/data/wezterm_background/space man.png'
   self.is_empty = false
   return self
end

---Override the current window options for background
---@private
---@param window any WezTerm Window see: https://wezfurlong.org/wezterm/config/lua/window/index.html
function BackDrops:set_opt(window, d_opacity)
   self.opacity = self.opacity + d_opacity
   local background = {}
   if not self.is_empty then
      table.insert(background, { source = { File = wezterm.GLOBAL.background } })
   end
   table.insert(background, {
      source = { Color = '#191724' },
      height = '100%',
      width = '100%',
      opacity = self.opacity,
   })
   window:set_config_overrides({ background = background })
end

---Convert the `files` array to a table of `InputSelector` choices
---see: https://wezfurlong.org/wezterm/config/lua/keyassignment/InputSelector.html
function BackDrops:choices()
   local choices = {}
   for idx, file in ipairs(self.files) do
      local name = file:match('([^' .. PATH_SEP .. ']+)$')
      table.insert(choices, {
         id = tostring(idx),
         label = name,
      })
   end
   return choices
end

---MUST BE RUN BEFORE APPEARANCE OPTIONS ARE SET
---Select a random file and redefine the global `wezterm.GLOBAL.background` variable
---Pass in `Window` object to override the background options to apply change
---@param window any? WezTerm `Window` see: https://wezfurlong.org/wezterm/config/lua/window/index.html
function BackDrops:random(window)
   self.current_idx = math.random(#self.files)
   wezterm.GLOBAL.background = self.files[self.current_idx]

   if window ~= nil then
      self:set_opt(window, 0)
   end
end

---Cycle the loaded `files` and select the next background
---@param window any WezTerm `Window` see: https://wezfurlong.org/wezterm/config/lua/window/index.html
function BackDrops:cycle_forward(window)
   self.is_empty = false
   if self.current_idx == #self.files then
      self.current_idx = 1
   else
      self.current_idx = self.current_idx + 1
   end
   wezterm.GLOBAL.background = self.files[self.current_idx]
   self:set_opt(window, 0)
end

---Cycle the loaded `files` and select the next background
---@param window any WezTerm `Window` see: https://wezfurlong.org/wezterm/config/lua/window/index.html
function BackDrops:cycle_back(window)
   self.is_empty = false
   if self.current_idx == 1 then
      self.current_idx = #self.files
   else
      self.current_idx = self.current_idx - 1
   end
   wezterm.GLOBAL.background = self.files[self.current_idx]
   self:set_opt(window, 0)
end

---Set a specific background from the `files` array
---@param window any WezTerm `Window` see: https://wezfurlong.org/wezterm/config/lua/window/index.html
---@param idx number index of the `files` array
function BackDrops:set_img(window, idx)
   if idx > #self.files or idx < 0 then
      wezterm.log_error('Index out of range')
      return
   end

   self.current_idx = idx
   self.is_empty = false
   wezterm.GLOBAL.background = self.files[self.current_idx]
   self:set_opt(window, 0)
end

function BackDrops:remove(window)
   self.is_empty = true
   self:set_opt(window, 0)
end

function BackDrops:decrease_opacity(window)
   self:set_opt(window, -0.05)
end

function BackDrops:increase_opacity(window)
   self:set_opt(window, 0.05)
end

return BackDrops:init()
