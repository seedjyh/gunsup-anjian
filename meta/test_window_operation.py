#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/21
import os
import unittest

from meta.directory import Directory
from meta.file import File
from meta.window_operation import WindowOperation


class TestWindowOperation(unittest.TestCase):
    def setUp(self):
        # source(directory)
        #     |
        #     +--- window(directory)
        #             |
        #             +--- GunsUp(directory)
        #                     |
        #                     +--- processInformation.op(file)
        self.source_path = os.path.join("window", "GunsUp", "processInformation.op")
        op_file = File(
            name="processInformation.op",
            content_lines=[
                "Call moveAroundMouse",
                "MoveTo 1600, 400",
                "Delay 300",
                "KeyPress \"Space\", 1",
            ]
        )
        gunsup_window = Directory(
            name = "GunsUp",
            child_files={op_file.name(): op_file}
        )
        all_window = Directory(
            name = "window",
            child_directories={gunsup_window.name(): gunsup_window}
        )
        self.source_directory = Directory(
            name = "source",
            child_directories={all_window.name(): all_window}
        )

    def test_compile(self):
        compiler = WindowOperation()
        result = compiler.compile(self.source_path, self.source_directory)
        expected = \
            "Function window_GunsUp_processInformation(left, top, right, bottom)\n"\
            "    Call window_GunsUp_moveAroundMouse(left, top, right, bottom)\n"\
            "    MoveTo left+1600, top+400\n"\
            "    Delay 300\n"\
            "    KeyPress \"Space\", 1\n"\
            "End Function\n"
        self.assertEqual(expected, result)


if __name__ == "__main__":
    unittest.main()
