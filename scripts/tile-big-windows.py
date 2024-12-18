#!/usr/bin/python

# This script requires i3ipc-python package (install it from a system package manager
# or pip).
# It makes inactive windows transparent. Use `transparency_val` variable to control
# transparency strength in range of 0…1 or use the command line argument -o.

import argparse
import i3ipc
import signal
import sys
from functools import partial

def on_new_window(width, height, ipc, event):
    win = event.container
    if win.geometry.width > width and win.geometry.height > height:
        win.command("floating disabled")
        #win.command

if __name__ == "__main__":
    transparency_val = "0.80"

    parser = argparse.ArgumentParser(
        description="This script automatically tiles windows above a certain size in sway.",
        add_help=False
    )
    parser.add_argument(
        "--width", "-w",
        type=int, default=1000,
        help="Min width for auto-tiling",
    )
    parser.add_argument(
        "--height", "-h",
        type=int, default=800,
        help="Min height for auto-tiling",
    )
    args = parser.parse_args()

    ipc = i3ipc.Connection()

    ipc.on("window::new", partial(on_new_window, args.width, args.height))
    ipc.main()
