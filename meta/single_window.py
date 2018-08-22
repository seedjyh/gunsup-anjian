#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/22
import os

from meta.compiler import Compiler
from meta.directory import Directory
from meta.window_color_checker import WindowColorChecker
from meta.window_frame_checker import WindowFrameChecker
from meta.window_operation import WindowOperation
from meta.window_rule import WindowRule


class SingleWindow(Compiler):
    def compile(self, path: str, source: Directory) -> str:
        result = ""
        result += self.compile_color_checker(path, source)
        result += self.compile_frame_checker(path, source)
        result += self.compile_operation(path, source)
        result += self.compile_rule(path, source)
        return result

    def compile_color_checker(self, path: str, source: Directory) -> str:
        for file in source.locate(path).child_files().values():
            if file.name()[-4:] == ".clr":
                return WindowColorChecker(self._newline).compile(os.path.join(path, file.name()), source) + self._newline
        return ""

    def compile_frame_checker(self, path: str, source: Directory) -> str:
        for file in source.locate(path).child_files().values():
            if file.name()[-4:] == ".frm":
                return WindowFrameChecker(self._newline).compile(os.path.join(path, file.name()), source) + self._newline
        return ""

    def compile_operation(self, path: str, source: Directory) -> str:
        for file in source.locate(path).child_files().values():
            if file.name()[-3:] == ".op":
                return WindowOperation(self._newline).compile(os.path.join(path, file.name()), source) + self._newline
        return ""

    def compile_rule(self, path: str, source: Directory) -> str:
        for file in source.locate(path).child_files().values():
            if file.name() == "rule":
                return WindowRule(self._newline).compile(os.path.join(path, file.name()), source) + self._newline
        return ""


if __name__ == "__main__":
    pass
