#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import os
curPath = os.path.abspath(os.path.dirname(__file__))
rootPath = os.path.split(curPath)[0]
sys.path.append(rootPath)

from meta.directory import Directory
from meta.source import Source
from generator import config


def generate(source_path: str, output_file: str):
    """
    read all files in directory self.source_path, connect them, output to self.output_file.
    :return: path of written file.
    """
    source = Directory()
    source.load(source_path)
    with open(output_file, mode="w+", encoding="utf-8") as output:
        output.write(Source().compile("", source))


if __name__ == "__main__":
    config = config.read_config("gunsup.cfg")
    print(config.source_directory)
    print(config.output_file)
    generate(config.source_directory, config.output_file)
