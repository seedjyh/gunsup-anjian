#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/21
import re

from meta.compiler import Compiler
from meta.directory import Directory


class InvalidMetaLine(Exception):
    def __init__(self, command, description):
        pass


class WindowOperation(Compiler):
    def __init__(self, newline="\n"):
        Compiler.__init__(self, newline)
        self.rect_parameter_list = ("left", "top", "right", "bottom")

    def compile(self, path: str, source: Directory) -> str:
        result = ""
        result += "Function %s(%s)" % (self.get_function_name(path), ", ".join(self.rect_parameter_list)) + self._newline
        for line in source.locate(path).lines():
            result += "    " + self.generate_line(line, path) + self._newline
        result += "End Function" + self._newline
        return result

    def generate_line(self, line, path):
        words = re.split(r"[ \t]+", line.strip())
        words = [w.strip() for w in words]
        generator_map = {
            "Call": self.generate_line_call,
            "MoveTo": self.generate_line_moveto,
            "Delay": self.just_copy,
            "KeyPress": self.just_copy,
            "LeftClick": self.just_copy,
        }
        return generator_map[words[0]](words[0], words[1:], path)

    def generate_line_call(self, command, parameters, path):
        return "%s %s%s(%s)" % (command, self.get_function_prefix(path), parameters[0], ", ".join(self.rect_parameter_list))

    @staticmethod
    def generate_line_moveto(command, parameters, path):
        if len(parameters) != 2:
            raise InvalidMetaLine("Require 2 parameters, found %d" % len(parameters))
        if parameters[0][-1] != ",":
            raise InvalidMetaLine("First parameter should end with comma(\",\"), found " + parameters[0][-1])
        return "%s left+%s top+%s" % (command, parameters[0], parameters[1])

    @staticmethod
    def just_copy(command, parameters, path):
        return "%s %s" % (command, " ".join(parameters))


if __name__ == "__main__":
    pass
