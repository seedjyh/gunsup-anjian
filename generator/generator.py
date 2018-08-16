#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/16
import os
import path_loader


class Generator:
    """
    read all files in directory source_path, connect them, output to output_file.
    """
    def __init__(self, source_path, output_file):
        self.source_path = source_path
        self.output_file = output_file

    def generate(self):
        """
        read all files in directory self.source_path, connect them, output to self.output_file.
        :return: path of written file.
        """
        files = path_loader.read_all_files(self.source_path)
        with open(self.output_file, mode="w+", encoding="utf-8") as output_file:
            for file in files:
                output_file.write("// << %s >>\n" % file.path)
                output_file.write(file.data)
                output_file.write("\n")


if __name__ == "__main__":
    Generator("E:\my_projects\gunsup-anjian\--------------rawdata", "E:\my_projects\gunsup-anjian\--------------rawdata.txt").generate()
