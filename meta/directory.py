#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/21
import os

from meta.file import File


class Directory:
    """
    Stores all metadata.
    With a method "load" to read child directories and files.
    """
    def __init__(self):
        self.name = "" # full path
        self.child_directories = {}
        self.child_files = {}

    def load(self, path: str):
        self.name = os.path.basename(path)
        for name in os.listdir(path):
            current_path = os.path.join(path, name)
            if os.path.isfile(current_path):
                new_file = File()
                new_file.load(current_path)
                self.child_files[name] = new_file
            else:
                new_directory = Directory()
                new_directory.load(current_path)
                self.child_directories[name] = new_directory


if __name__ == "__main__":
    pass
