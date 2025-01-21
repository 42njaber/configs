
from logging import getLogger
from threading import Thread
import asyncio
import sys
import os
import subprocess

import ranger.api as api
from ranger.core.main import COMMANDS_EXCLUDE
from ranger.core.actions import Actions, MACRO_FAIL

def on_hook(obj,name,after = False):
    old = getattr(obj,name)
    if after:
        def ret(func):
            def new(*args, **kwargs):
                old(*args, **kwargs)
                func(*args, **kwargs)
            setattr(obj,name,new)
            return func
    else:
        def ret(func):
            def new(*args, **kwargs):
                func(*args, **kwargs)
                old(*args, **kwargs)
            setattr(obj,name,new)
            return func
    return ret

LOG = getLogger(__name__)

VIM_SESSION = os.environ.get("VIM_SESSION", None).upper()

if VIM_SESSION:

    @on_hook(api,'hook_init')
    def sync(fm):
        envdir = "/tmp/vsh/fm/"
        if not os.path.isdir(envdir):
            os.makedirs(envdir)
        envfile = envdir + VIM_SESSION + ".vim"

        def update_vimfile(*args,**kwargs):
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

        on_hook(fm,'tag_toggle',after=True)(update_vimfile)
        on_hook(fm,'mark_files',after=True)(update_vimfile)
        on_hook(fm,'copy',after=True)(update_vimfile)
        on_hook(fm,'cut',after=True)(update_vimfile)
        on_hook(fm,'uncut',after=True)(update_vimfile)
        fm.signal_bind('tab.change', update_vimfile)
        fm.signal_bind('move', update_vimfile)

        include = [name for name in dir(Actions) if name not in COMMANDS_EXCLUDE]
        fm.commands.load_commands_from_object(fm,include)
