local wezterm = require('wezterm')

return {
   animation_fps = 60,
   max_fps = 60,
   -- front_end = 'WebGpu',
   -- webgpu_power_preference = 'HighPerformance',

   -- color scheme
   color_scheme = 'rose-pine',

   -- background
   background = {
      {
         source = { Color = '#191919' },
         height = '100%',
         width = '100%',
         opacity = 0.5,
      },
   },

   -- scrollbar
   enable_scroll_bar = false,

   -- tab bar
   enable_tab_bar = true,
   hide_tab_bar_if_only_one_tab = true,
   use_fancy_tab_bar = false,
   tab_max_width = 25,
   show_tab_index_in_tab_bar = false,
   switch_to_last_active_tab_when_closing_tab = true,

   -- window
   window_padding = {
      left = 5,
      right = 10,
      top = 12,
      bottom = 7,
   },
   window_close_confirmation = 'NeverPrompt',
   window_frame = {
      active_titlebar_bg = '#090909',
      -- font = fonts.font,
      -- font_size = fonts.font_size,
   },
   inactive_pane_hsb = {
      saturation = 0.7,
      brightness = 0.6,
   },
}
