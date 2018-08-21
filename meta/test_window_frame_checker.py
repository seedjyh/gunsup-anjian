#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/20

from unittest import TestCase

from meta.window_frame_checker import WindowFrameChecker


class TestWindowFrameChecker(TestCase):
    def test_dump(self):
        path = ["window", "GunsUp"]
        name = "isWar"
        lines = ["isTopWar", "isLeftBottomReturn", "isRightBottomGear"]
        obj = WindowFrameChecker(path, name, lines)
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
        result = obj.dump()
        self.assertEqual(expected, result)

if __name__ == "__main__":
    pass
