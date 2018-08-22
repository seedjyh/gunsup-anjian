#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/17
from meta.compiler import Compiler
from meta.directory import Directory


class GeneralOperation(Compiler):
    """
    An function of <<*.op>>, no argument, no result value.
    """
    def compile(self, path: str, source: Directory) -> str:
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
        result = ""
        result += "Function %s()" % self.get_function_name(path) + self._newline
        for line in source.locate(path).lines():
            result += "    " + line + self._newline
        result += "End Function" + self._newline
        return result


if __name__ == "__main__":
    pass
