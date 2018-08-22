#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/22
import os

from meta.compiler import Compiler
from meta.directory import Directory
from meta.general_operation import GeneralOperation
from meta.raw_code import RawCode


class General(Compiler):
    def compile(self, path: str, source: Directory) -> str:
        result = ""
        result += self.compile_raw_code(path, source)
        result += self.compile_operation(path, source)
        return result

    def compile_raw_code(self, path: str, source: Directory) -> str:
        result = ""
        for file in source.locate(path).child_files().values():
            if file.name()[-2:] == ".Q":
                result += RawCode(self._newline).compile(os.path.join(path, file.name()), source)
        return result

    def compile_operation(self, path: str, source: Directory) -> str:
        result = ""
        for file in source.locate(path).child_files().values():
            if file.name()[-3:] == ".op":
                result += GeneralOperation(self._newline).compile(os.path.join(path, file.name()), source)
        return result


if __name__ == "__main__":
    pass
