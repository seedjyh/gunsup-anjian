#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/22
import os

from meta.compiler import Compiler
from meta.directory import Directory
from meta.single_window import SingleWindow


class Windows(Compiler):
    def compile(self, path: str, source: Directory) -> str:
        result = ""
        for dir in source.locate(path).child_directories().values():
            result += SingleWindow(self._newline).compile(os.path.join(path, dir.name()), source)
        return result

if __name__ == "__main__":
    pass
