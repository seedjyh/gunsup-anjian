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
            "Call" : self.generate_line_call,
            "MoveTo": self.generate_line_moveto,
            "Delay": self.generate_line_delay,
            "KeyPress": self.generate_line_keypress,
        }
        return generator_map[words[0]](words[1:], path)

    def generate_line_call(self, parameters, path):
        return "Call %s%s(%s)" % (self.get_function_prefix(path), parameters[0], ", ".join(self.rect_parameter_list))

    @staticmethod
    def generate_line_moveto(parameters, path):
        if len(parameters) != 2:
            raise InvalidMetaLine("Require 2 parameters, found %d" % len(parameters))
        if parameters[0][-1] != ",":
            raise InvalidMetaLine("First parameter should end with comma(\",\"), found " + parameters[0][-1])
        return "MoveTo left+%s top+%s" % (parameters[0], parameters[1])

    @staticmethod
    def generate_line_delay(parameters, path):
        if len(parameters) != 1:
            raise InvalidMetaLine("Require 1 parameter, found %d" % len(parameters))
        return "Delay %s" % (parameters[0])

    @staticmethod
    def generate_line_keypress(parameters, path):
        if len(parameters) != 2:
            raise InvalidMetaLine("Require 2 parameters, found %d" % len(parameters))
        if parameters[0][-1] != ",":
            raise InvalidMetaLine("First parameter should end with comma(\",\"), found " + parameters[0][-1])
        return "KeyPress " + " ".join(parameters)


if __name__ == "__main__":
    pass
