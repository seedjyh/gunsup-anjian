#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/20
import os

from meta.dumpable import Dumpable


class File(Dumpable):
    """
    Store raw data from file.
    """
    def __init__(self):
        self.name = ""
        self.content_lines = []

    def load(self, path: str):
        self.name = os.path.basename(path)
        with open(file=path, mode="r", encoding="utf-8") as fp:
            self.content_lines = fp.readlines()


if __name__ == "__main__":
    pass
