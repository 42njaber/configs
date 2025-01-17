
from logging import getLogger
from threading import Thread
import asyncio
import sys
import os
import subprocess

import ranger.api as api
from ranger.core.actions import MACRO_FAIL

def on_hook(obj,name):
    old = getattr(obj,name)
    def ret(func):
        def new(*args, **kwargs):
            func(*args, **kwargs)
            old(*args, **kwargs)
        setattr(obj,name,new)
        return func
    return ret

LOG = getLogger(__name__)

VIM_SESSION = os.environ.get("VIM_SESSION", None)

if VIM_SESSION:

    @on_hook(api,'hook_ready')
    def sync(fm):

        def update_vim():
            macros = {k:v for k,v in fm.get_macros().items() if len(k) == 1}
            subprocess.run(["vim","--servername",VIM_SESSION,"--remote-expr",
                            ["setenv('FM_"+str(k)+"','0')" for k,v in macros.items()].join(" | ")
                            ],
                           stdout=subprocess.DEVNULL,
                           stderr=subprocess.DEVNULL
                           )
            LOG.info("--- MACROS --")
            for k,v in macros.items():
                LOG.info(str(k)+":"+str(v))

        fm.signal_bind('move', update_vim)
