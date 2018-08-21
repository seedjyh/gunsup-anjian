#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/21
import re

from meta.function import Function


class InvalidMetaLine(Exception):
    def __init__(self, command, description):
        pass


class WindowOperation(Function):
    def dump(self, newline="\n"):
        function_prefix = self.get_function_prefix(self.path)
        function_name = function_prefix + self.name
        result = "Function %s(left, top, right, bottom)" % function_name + newline
        for line in self.content_lines:
            result += "    " + self.generate_line(line) + newline
        result += "End Function" + newline
        return result

    def generate_line(self, line):
        words = re.split(r"[ \t]+", line.strip())
        words = [w.strip() for w in words]
        generator_map = {
            "Call" : self.generate_line_call,
            "MoveTo": self.generate_line_moveto,
            "Delay": self.generate_line_delay,
            "KeyPress": self.generate_line_keypress,
        }
        return generator_map[words[0]](words)

    def generate_line_call(self, words):
        command = words[0]
        parameters = words[1:]
        if len(parameters) != 1:
            raise InvalidMetaLine(command, "Require 1 parameter, found %d" % len(parameters))
        if parameters[0][-2:] != "()":
            raise InvalidMetaLine(command, "Parameter should end with \"()\", found " + parameters[0][-2])
        function_name = parameters[0][:-2]
        if function_name.find(".") != -1: # With dot(".") means called function is not in current window.
            final_function_name = function_name.replace(".", "_")
            return command + " " + final_function_name + "()" # no parameter.
        else: # Without dot(".") means function called is in current window.
            final_function_name = self.get_function_prefix(self.path) + function_name
            return command + " " + final_function_name + "(left, top, right, bottom)" # Requires RECT of window.

    @staticmethod
    def generate_line_moveto(words):
        command = words[0]
        parameters = words[1:]
        if len(parameters) != 2:
            raise InvalidMetaLine(command, "Require 2 parameters, found %d" % len(parameters))
        if parameters[0][-1] != ",":
            raise InvalidMetaLine(command, "First parameter should end with comma(\",\"), found " + parameters[0][-1])
        return "%s left+%s top+%s" % (command, parameters[0], parameters[1])

    @staticmethod
    def generate_line_delay(words):
        command = words[0]
        parameters = words[1:]
        if len(parameters) != 1:
            raise InvalidMetaLine(command, "Require 1 parameter, found %d" % len(parameters))
        return " ".join(words)

    @staticmethod
    def generate_line_keypress(words):
        command = words[0]
        parameters = words[1:]
        if len(parameters) != 2:
            raise InvalidMetaLine(command, "Require 2 parameters, found %d" % len(parameters))
        if parameters[0][-1] != ",":
            raise InvalidMetaLine(command, "First parameter should end with comma(\",\"), found " + parameters[0][-1])
        return " ".join(words)

if __name__ == "__main__":
    pass
