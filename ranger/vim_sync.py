
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
        envdir = "/tmp/vsh/fm/"
        if not os.path.isdir(envdir):
            os.makedirs(envdir)
        envfile = envdir + VIM_SESSION + ".vim"

        def update_vim():
            macros = {k:v for k,v in fm.get_macros().items() if len(k) == 1 and v != MACRO_FAIL}
            del macros['p']
            for m in [k for k in "sft" if k in macros.keys()]:
                if isinstance(macros[m],list):
                    macros[m] = [os.path.join(fm.thisdir.path, f) for f in macros[m]]
                else:
                    macros[m] = os.path.join(fm.thisdir.path, macros[m])
            source = "let g:fm_macros=" + str(macros)
            with open(envfile, 'w') as fileobj:
                fileobj.write(source)

            #LOG.info("--- MACROS --")
            #for k,v in macros.items():
            #    LOG.info(str(k)+":"+str(v))

        fm.signal_bind('move', update_vim)
