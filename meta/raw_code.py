#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/22
from meta.compiler import Compiler
from meta.directory import Directory


class RawCode(Compiler):
    def compile(self, path: str, source: Directory):
        result = ""
        for line in source.locate(path).lines():
            result += line + self._newline
        return result


if __name__ == "__main__":
    pass
