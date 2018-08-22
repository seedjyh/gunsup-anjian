#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/21
from meta.directory import Directory


class Compiler:
    def __init__(self, newline="\n"):
        self._newline = newline

    def compile(self, path: str, source: Directory) -> str:
        """
        Compile meta data in a directory to Q language code and return.
        :param path: relative path in source. For example, path="abc/def", means directory "abc" in root of source.
        :param source: Object of class Directory
        :param newline:
        :return:
        """
        pass

    @staticmethod
    def get_function_name(path):
        return path.replace("\\", "_")

    @staticmethod
    def get_function_prefix(path):
        return "_".join(path.split("\\")[:-1]) + "_"

if __name__ == "__main__":
    pass
