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
    def __init__(self, name="", child_directories=None, child_files=None):
        self.__name = name
        if child_directories is None:
            child_directories = {}
        self.__child_directories = child_directories
        if child_files is None:
            child_files = {}
        self.__child_files = child_files

    def name(self):
        return self.__name

    def locate(self, path: str):
        stack = path.split("\\")
        if len(stack) > 1:
            return self.__child_directories[stack[0]].locate("\\".join(stack[1:]))
        else:
            return self.__child_files.get(stack[0], self.__child_directories.get(stack[0]))

    def load(self, path: str):
        """
        Load a directory in file system specified by parameter path.
        All data previously stored would be cleaned and replaced.
        :param path: Full path of directory to load in file system.
        :return: (None).
        """
        self.__name = os.path.basename(path)
        for name in os.listdir(path):
            current_path = os.path.join(path, name)
            if os.path.isfile(current_path):
                new_file = File()
                new_file.load(current_path)
                self.__child_files[name] = new_file
            else:
                new_directory = Directory()
                new_directory.load(current_path)
                self.__child_directories[name] = new_directory


if __name__ == "__main__":
    pass
