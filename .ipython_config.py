""" iPython Config

# Features

- Autoreload;
- Autoimport based on projects;
 

# Genereae a config file

$ ipython profile create
[ProfileCreate] Generating default config file: '/Users/eric/.ipython/profile_default/ipython_config.py'

"""
import os
import getpass

AUTO_RELOAD = True
AUTO_IMPORT = True

# Relative import
AI_AUTO_IMPORT_MODULES = [("django.conf", "settings"), ("django.core.cache", "cache")]


cwd = os.getcwd()
prj = os.path.relpath(cwd, os.path.expanduser("~"))
usn = getpass.getuser()

c.InteractiveShell.banner2 = "-> Hello {} welcome to {}\n".format(usn, prj)

if AUTO_RELOAD:
    # Magic autoreload
    c.InteractiveShellApp.extensions = ["autoreload"]
    c.InteractiveShellApp.exec_lines = ["%autoreload 2"]
    c.InteractiveShellApp.exec_lines.append('print("-> Autoreload is On")')

# Auto import


def build_import(module_item):
    size = len(module_item)
    if size == 3:
        return "from {} import {} as {}".format(*module_item)
    if size == 2:
        return "from {} import {}".format(*module_item)
    if size == 1:
        return "import {}".format(*module_item)
    return ""


def _auto_import(modules):
    for module in modules:
        _import = build_import(module)
        if not _import:
            continue
        _echo = 'print(" {}")'.format(_import)
        c.InteractiveShellApp.exec_lines.append(_import)
        c.InteractiveShellApp.exec_lines.append(_echo)


def auto_import():
    """ main"""
    if "algorithm" in prj:
        li_echo = 'print("-> Licaishi auto imports are")'
        c.InteractiveShellApp.exec_lines.append(li_echo)
        _auto_import(AI_AUTO_IMPORT_MODULES)


if AUTO_IMPORT:
    c.InteractiveShellApp.exec_lines.append('print("-> Autoimport is On")')
    auto_import()
