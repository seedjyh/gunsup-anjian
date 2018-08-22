#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/20
import re

from meta.compiler import Compiler
from meta.directory import Directory


class WindowColorChecker(Compiler):
    def __init__(self, newline="\n"):
        Compiler.__init__(self, newline)
        self.rect_parameter_list = ("left", "top", "right", "bottom")

    def compile(self, path: str, source: Directory) -> str:
        function_name = self.get_function_name(path)
        result = ""
        result += "Function %s(%s)" % (function_name, ", ".join(self.rect_parameter_list)) + self._newline
        for index, line in enumerate(source.locate(path).lines()):
            x, y, color, diff = re.split(r" +", line.strip())
            result += "    %sIf Not (similarColor(GetPixelColor(left+%s, top+%s), \"%s\", %s))  Then" % ("" if index == 0 else "Else", x, y, color, diff) + self._newline
            result += "        %s = False" % function_name + self._newline
        result += "    Else" + self._newline
        result += "        %s = True" % function_name + self._newline
        result += "    End If" + self._newline
        result += "End Function" + self._newline
        return result


if __name__ == "__main__":
    pass
