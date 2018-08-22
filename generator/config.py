#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/16

from configparser import ConfigParser


class Config():
    def __init__(self, source_directory, output_file):
        self.source_directory = source_directory
        self.output_file = output_file


def read_config(file_name):
    parser = ConfigParser()
    read_files = parser.read(file_name)
    if file_name not in read_files:
        print("Config file %s not exists, using default settings..." % file_name)
        return Config(source_directory="../data", output_file="../data.Q")
    return Config(parser.get(section="input", option="path"), parser.get(section="output", option="path"))


if __name__ == "__main__":
    pass
