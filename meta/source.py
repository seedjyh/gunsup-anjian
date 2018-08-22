#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/22
import os

from meta.compiler import Compiler
from meta.directory import Directory
from meta.general import General
from meta.raw_code import RawCode
from meta.windows import Windows


class Source(Compiler):
    def compile(self, path: str, source: Directory) -> str:
        result = ""
        result += General(self._newline).compile(os.path.join(path, "general"), source)
        result += Windows(self._newline).compile(os.path.join(path, "windows"), source)
        result += RawCode(self._newline).compile(os.path.join(path, "main.Q"), source)
        return result


if __name__ == "__main__":
    pass
