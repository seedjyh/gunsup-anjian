#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/16
from meta.directory import Directory
from meta.source import Source


class Generator:
    """
    read all files in directory source_path, connect them, output to output_file.
    """
    @staticmethod
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
    Generator().generate("K:\\GitHubRepositories\\gunsup-anjian\\data", "K:\\GitHubRepositories\\gunsup-anjian\\data.txt")
