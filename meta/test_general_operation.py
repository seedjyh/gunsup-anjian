#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/20
import os
import unittest
from unittest import TestCase

from meta.directory import Directory
from meta.file import File
from meta.general_operation import GeneralOperation


class TestGeneralOperation(unittest.TestCase):
    def setUp(self):
        # source(directory)
        #     |
        #     +--- general(directory)
        #             |
        #             +--- closeAll.op(file)
        self.source_path = os.path.join("general", "closeAll.op")
        op_file = File(
            name="closeAll.op",
            content_lines=[
                "First line",
                "Second line",
                "Third line",
            ]
        )
        general_directory = Directory(
            name="general",
            child_directories={op_file.name(): op_file}
        )
        self.source_directory = Directory(
            name="source",
            child_directories={general_directory.name(): general_directory}
        )

    def test_compile(self):
        compiler = GeneralOperation()
        result = compiler.compile(self.source_path, self.source_directory)
        expected = \
            "Function general_closeAll()\n"\
            "    First line\n"\
            "    Second line\n"\
            "    Third line\n"\
            "End Function\n"
        self.assertEqual(expected, result)


if __name__ == "__main__":
    unittest.main()
