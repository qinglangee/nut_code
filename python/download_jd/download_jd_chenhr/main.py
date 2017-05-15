# -*- coding: utf-8 -*-
import config
import sys
for src_path in config.src_paths:
    sys.path.append(src_path)


import fun
import download_frame


download_frame.start(fun)