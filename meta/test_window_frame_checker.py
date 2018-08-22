#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/20
import os
import unittest

from meta.directory import Directory
from meta.file import File
from meta.window_frame_checker import WindowFrameChecker


class TestWindowFrameChecker(unittest.TestCase):
    def setUp(self):
        # source(directory)
        #     |
        #     +--- window(directory)
        #             |
        #             +--- GunsUp(directory)
        #                     |
        #                     +--- isWar.frm(file)
        self.source_path = os.path.join("window", "GunsUp", "isWar.frm")
        op_file = File(
            name="isWar.frm",
            content_lines=[
                "isTopWar",
                "isLeftBottomReturn",
                "isRightBottomGear",
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
        compiler = WindowFrameChecker()
        result = compiler.compile(self.source_path, self.source_directory)
        expected = \
            "Function window_GunsUp_isWar(left, top, right, bottom)\n"\
            "    If Not (window_GunsUp_isTopWar(left, top, right, bottom)) Then\n"\
            "        window_GunsUp_isWar = False\n"\
            "    ElseIf Not (window_GunsUp_isLeftBottomReturn(left, top, right, bottom)) Then\n"\
            "        window_GunsUp_isWar = False\n"\
            "    ElseIf Not (window_GunsUp_isRightBottomGear(left, top, right, bottom)) Then\n"\
            "        window_GunsUp_isWar = False\n"\
            "    Else\n"\
            "        window_GunsUp_isWar = True\n"\
            "    End If\n"\
            "End Function\n"
        self.assertEqual(expected, result)


if __name__ == "__main__":
    unittest.main()
