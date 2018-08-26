#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/21
from meta.compiler import Compiler
from meta.directory import Directory


class WindowRule(Compiler):
    def compile(self, path: str, source: Directory) -> str:
        rect_parameter_list = ("left", "top", "right", "bottom")
        result = ""
        result += "Function %s(%s)" % (self.get_function_name(path), ", ".join(rect_parameter_list)) + self._newline
        for index, line in enumerate(source.locate(path).lines()):
            checker, processor = line.split("=>")
            result += "    %s %s%s(%s) Then" % ("If" if index == 0 else "ElseIf", self.get_function_prefix(path), checker, ", ".join(rect_parameter_list)) + self._newline
            result += "        Call %s%s(%s)" % (self.get_function_prefix(path), processor, ", ".join(rect_parameter_list)) + self._newline
        if len(source.locate(path).lines()) > 0:
            result += "    End If" + self._newline
        result += "End Function" + self._newline
        return result


if __name__ == "__main__":
    pass
