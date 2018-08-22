#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/22
import os
import unittest

from meta.directory import Directory
from meta.file import File
from meta.window_rule import WindowRule


class TestWindowRule(unittest.TestCase):
    def setUp(self):
        # source(directory)
        #     |
        #     +--- window(directory)
        #             |
        #             +--- GunsUp(directory)
        #                     |
        #                     +--- rule(file)
        rule = File(
            name="rule",
            content_lines=[
                "isInformation=>processInformation",
                "isCenter=>processCenter",
            ]
        )
        gunsup_window = Directory(
            name = "GunsUp",
            child_files={rule.name(): rule}
        )
        all_window = Directory(
            name = "window",
            child_directories={gunsup_window.name(): gunsup_window}
        )
        self.source_directory = Directory(
            name = "source",
            child_directories={all_window.name(): all_window}
        )
        self.source_path = os.path.join("window", "GunsUp", "rule")

    def test_compile(self):
        compiler = WindowRule()
        result = compiler.compile(self.source_path, self.source_directory)
        expected = \
            "Function window_GunsUp_rule(left, top, right, bottom)\n"\
            "    If window_GunsUp_isInformation(left, top, right, bottom) Then\n"\
            "        Call window_GunsUp_processInformation(left, top, right, bottom)\n"\
            "    ElseIf window_GunsUp_isCenter(left, top, right, bottom) Then\n"\
            "        Call window_GunsUp_processCenter(left, top, right, bottom)\n"\
            "    End If\n"\
            "End Function\n"
        self.assertEqual(expected, result)


if __name__ == "__main__":
    unittest.main()
