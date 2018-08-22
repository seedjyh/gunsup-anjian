#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/20
from meta.compiler import Compiler
from meta.directory import Directory


class WindowFrameChecker(Compiler):
    def compile(self, path: str, source: Directory) -> str:
        function_name = self.get_function_name(path)
        function_prefix = self.get_function_prefix(path)
        rect_parameter_list = ("left", "top", "right", "bottom")
        result = ""
        result += "Function %s(%s)" % (function_name, ", ".join(rect_parameter_list)) + self._newline
        for index, line in enumerate(source.locate(path).lines()):
            result += "    %s Not (%s%s(left, top, right, bottom)) Then" % ("If" if index == 0 else "ElseIf", function_prefix, line) + self._newline
            result += "        %s = False" % function_name + self._newline
        result += "    Else" + self._newline
        result += "        %s = True" % function_name + self._newline
        result += "    End If" + self._newline
        result += "End Function" + self._newline
        return result


if __name__ == "__main__":
    pass
