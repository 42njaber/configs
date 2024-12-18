
from __future__ import (absolute_import, division, print_function)

from logging import getLogger
from threading import Thread
import asyncio
import sys
import os

import ranger.api as api

def on_hook(obj,name):
    old = getattr(obj,name)
    def ret(func):
        def new(*args, **kwargs):
            func(*args, **kwargs)
            old(*args, **kwargs)
        setattr(obj,name,new)
        return func
    return ret

LOG = None
@on_hook(api,'hook_ready')
def logger(fm):
    LOG = getLogger("ranger")

task_loop = asyncio.new_event_loop()
def task_loop_main():
    asyncio.set_event_loop(task_loop)
    task_loop.run_forever()
task_thread = Thread(target=task_loop_main, daemon=True)
task_thread.start()

def reset_callback(func):
    def task_func(*args, **kwargs):
        try:
            if hasattr(task_func,"task"):
                if task_func.task and not task_func.task.cancelled():
                    task_func.task.cancel()
            task_func.task = task_loop.create_task(func(*args, **kwargs))
        except Exception as e:
            LOG.error(e)

    def run_async(*args, **kwargs):
        task_loop.call_soon_threadsafe(task_func, *args, **kwargs)
    return run_async

SESSION = os.environ.get("RANGER_SESSION", None)

if SESSION:

    @on_hook(api,'hook_ready')
    def save_session(fm):
        tabfile = fm.datapath(SESSION + ".conf")
        if os.path.isfile(tabfile):
            fm.source(tabfile)

        @reset_callback
        async def savetabs():
            try:
                await asyncio.sleep(5)
                source = "\n".join(
                            ("tab_open " + str(n) + " " + str(t.thisdir))
                            for (n,t) in fm.tabs.items()
                        )
                source += "\ntab_move " + str(fm.current_tab)
                with open(tabfile, 'w') as fileobj:
                    fileobj.write(source)
            except Exception as e:
                LOG.error(e)

        fm.signal_bind('move', savetabs)
        fm.signal_bind('tab.change', savetabs)
