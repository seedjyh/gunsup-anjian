#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/17

from meta.function import Function


class GeneralOperation(Function):
    """
    An function of <<*.op>>, no argument, no result value.
    """
    def dump(self, newline="\n"):
        """
        Generate a ".Q" code such as
        Function {self.name}()
            {self.lines[0]}
            {self.lines[1]}
            ...
            {self.lines[len(self.lines) - 1]}
        End Function
        :return: a str with "\t" and "\n".
        """
        result = "Function %s%s()" % (self.get_function_prefix(self.path), self.name) + newline
        for line in self.content_lines:
            result += "    " + line + newline
        result += "End Function" + newline
        return result


if __name__ == "__main__":
    pass
