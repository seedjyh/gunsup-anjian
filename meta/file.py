#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/20


class File:
    """
    Raw data read from file.
    """
    def __init__(self, path=None, name="", content_lines=None):
        """
        Position of file, name of file (without extension) and content of file.
        :param path: a list of name of path where the read file is, the further forward, the rooter.
        :param name: the file name without extension, case sensitive.
        :param content_lines: a list of str, each contains a line of file.
        """
        if content_lines is None:
            content_lines = []
        if path is None:
            path = []
        self.path = path
        self.name = name
        self.content_lines = content_lines

    def dump(self, newline="\n"):
        return ""


if __name__ == "__main__":
    pass
