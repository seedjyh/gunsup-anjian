#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/21

from unittest import TestCase

from meta.window_operation import WindowOperation


class TestWindowOperation(TestCase):
    def test_dump(self):
        path = ["window", "GunsUp"]
        name = "processInformation"
        lines = [
            "Call moveAroundMouse()",
            "MoveTo 1600, 400",
            "Delay 300",
            "KeyPress \"Space\", 1",
            "Call general.resetSpeedSpirit()",
        ]
        obj = WindowOperation(path, name, lines)
        expected = \
            "Function window_GunsUp_processInformation(left, top, right, bottom)\n"\
            "    Call window_GunsUp_moveAroundMouse(left, top, right, bottom)\n"\
            "    MoveTo left+1600, top+400\n"\
            "    Delay 300\n"\
            "    KeyPress \"Space\", 1\n"\
            "    Call general_resetSpeedSpirit()\n"\
            "End Function\n"
        result = obj.dump()
        self.assertEqual(expected, result)

if __name__ == "__main__":
    pass
