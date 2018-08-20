#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/17

from meta.file import File


class GeneralOperation(File):
    """
    An function of <<*.op>>, no argument, no result value.
    """
    def get_function_name(self):
        """
        If path path[0] = "A", path[1] = "B", name = "X", this function returns "A_B_X".
        :return: Name of function of this object specified in final dumped result.
        """
        result = self.name
        for n in self.path[::-1]:
            result = n + "_" + result
        return result

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
        result = "Function %s()%s" % (self.get_function_name(), newline)
        for line in self.content_lines:
            result += "    " + line + newline
        result += "End Function" + newline
        return result


if __name__ == "__main__":
    pass
