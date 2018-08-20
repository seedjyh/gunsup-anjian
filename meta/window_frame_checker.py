#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/20
from meta.function import Function


class WindowFrameChecker(Function):
    def dump(self, newline="\n"):
        function_prefix = self.get_function_prefix(self.path)
        function_name = function_prefix + self.name
        result = "Function %s(left, top, right, bottom)" % function_name + newline
        for index, line in enumerate(self.content_lines):
            result += "    %s Not (%s%s()) Then" % ("If" if index == 0 else "ElseIf", function_prefix, line) + newline
            result += "        %s = False" % function_name + newline
        result += "    Else" + newline
        result += "        %s = True" % function_name + newline
        result += "    End If" + newline
        result += "End Function" + newline
        return result

if __name__ == "__main__":
    pass
