#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/16
import os


class RawFile:
    def __init__(self, path):
        self.path = path
        self.data = self.read_file(path=path)

    @staticmethod
    def read_file(path):
        with open(file=path, mode="r", encoding="utf-8") as fin:
            return fin.read()


def read_all_files(root_path=".",recursive=False):
    """
    Read all files in a directory.
    :param root_path: the root directory.
    :param recursive: True to get files recursively.
    :return: a list of RawFile
    """
    result = []
    for name in os.listdir(root_path):
        path = os.path.join(root_path, name)
        if os.path.isfile(path):
            result.append(RawFile(path))
        else:
            if recursive:
                result = result + read_all_files(path)
    return result


if __name__ == "__main__":
    files = read_all_files(root_path="E:\my_projects\gunsup-anjian\--------------rawdata",recursive=True)
    for file in files:
        print("=============== << %s >> ===============" % file.path)
        print(file.data)
