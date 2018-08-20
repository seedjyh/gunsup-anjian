#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/20
import re

from meta.function import Function


class WindowColorChecker(Function):
    def dump(self, newline="\n"):
        function_name = self.get_function_name()
        result = "Function %s(left, top, right, bottom)" % function_name + newline
        for index, line in enumerate(self.content_lines):
            x, y, color, diff = re.split(r" +", line.strip())
            result += "    %sIf Not (similarColor(GetPixelColor(left+%s, top+%s), \"%s\", %s))  Then" % ("" if index == 0 else "Else", x, y, color, diff) + newline
            result += "        %s = False" % function_name + newline
        result += "    Else" + newline
        result += "        %s = True" % function_name + newline
        result += "    End If" + newline
        result += "End Function" + newline
        return result


if __name__ == "__main__":
    pass
