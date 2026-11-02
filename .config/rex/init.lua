-- https://www.superlogical.com/rex/docs/customize/config

-- https://www.superlogical.com/rex/docs/customize/key-sequences

rex.bind("ctrl+f>h", "pane.focus.left")
rex.bind("ctrl+f>j", "pane.focus.down")
rex.bind("ctrl+f>k", "pane.focus.up")
rex.bind("ctrl+f>l", "pane.focus.right")

rex.bind("ctrl+f>v", "pane.split.right")
rex.bind("ctrl+f>s", "pane.split.down")

rex.bind("ctrl+f>z", "pane.zoom")

-- ctrl+f now starts a sequence; press it twice to send one to the terminal.
rex.bind("ctrl+f>ctrl+f", "pane.send_key", { key = "ctrl+f" })
