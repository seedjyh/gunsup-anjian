#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/20
import os


class File:
    """
    Store raw data from file.
    """
    def __init__(self, name="", content_lines=None):
        self.__name = name # Just file name itself, no name of directory contains the file.
        if content_lines is None:
            content_lines = []
        self.__content_lines = content_lines

    def name(self):
        return self.__name

    def lines(self):
        return self.__content_lines

    def load(self, path: str):
        self.__name = os.path.basename(path)
        with open(file=path, mode="r", encoding="utf-8") as fp:
            self.__content_lines = fp.readlines()

if __name__ == "__main__":
    pass
