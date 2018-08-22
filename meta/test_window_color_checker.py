#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/20
import os
import unittest

from meta.directory import Directory
from meta.file import File
from meta.window_color_checker import WindowColorChecker


class TestWindowColorChecker(unittest.TestCase):
    def setUp(self):
        # source(directory)
        #     |
        #     +--- window(directory)
        #             |
        #             +--- GunsUp(directory)
        #                     |
        #                     +--- isTopGunsUp.clr(file)
        self.source_path = os.path.join("window", "GunsUp", "isTopGunsUp.clr")
        op_file = File(
            name="isTopGunsUp.clr",
            content_lines=[
                "720 90 4E454B 5",
                "733 93 3C5582 5",
            ]
        )
        gunsup_window = Directory(
            name="GunsUp",
            child_files={op_file.name(): op_file}
        )
        all_window = Directory(
            name="window",
            child_directories={gunsup_window.name(): gunsup_window}
        )
        self.source_directory = Directory(
            name="source",
            child_directories={all_window.name(): all_window}
        )

    def test_compile(self):
        compiler = WindowColorChecker()
        result = compiler.compile(self.source_path, self.source_directory)
        expected = \
            "Function window_GunsUp_isTopGunsUp(left, top, right, bottom)\n"\
            "    If Not (similarColor(GetPixelColor(left+720, top+90), \"4E454B\", 5))  Then\n"\
            "        window_GunsUp_isTopGunsUp = False\n"\
            "    ElseIf Not (similarColor(GetPixelColor(left+733, top+93), \"3C5582\", 5))  Then\n"\
            "        window_GunsUp_isTopGunsUp = False\n"\
            "    Else\n"\
            "        window_GunsUp_isTopGunsUp = True\n"\
            "    End If\n"\
            "End Function\n"
        self.assertEqual(expected, result)


if __name__ == "__main__":
    unittest.main()
