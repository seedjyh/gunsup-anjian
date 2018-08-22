#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/22
import os
import unittest

from meta.directory import Directory
from meta.file import File
from meta.raw_code import RawCode


class TestRawCode(unittest.TestCase):
    def setUp(self):
        # source(directory)
        #     |
        #     +--- general(directory)
        #             |
        #             +--- utils.Q(file)
        self.source_path = os.path.join("general", "utils.Q")
        code = File(
            name="utils.Q",
            content_lines=[
                "First line",
                "Second line",
                "Third line",
            ]
        )
        general_directory = Directory(
            name="general",
            child_directories={code.name(): code}
        )
        self.source_directory = Directory(
            name="source",
            child_directories={general_directory.name(): general_directory}
        )

    def test_compile(self):
        obj = RawCode()
        result = obj.compile(self.source_path, self.source_directory)
        expected = \
            "First line\n"\
            "Second line\n"\
            "Third line\n"
        self.assertEqual(expected, result)


if __name__ == "__main__":
    unittest.main()
