#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/20


from unittest import TestCase

from meta.window_color_checker import WindowColorChecker


class TestWindowColorChecker(TestCase):
    def test_dump(self):
        path = ["window", "GunsUp"]
        name = "isTopGunsUp"
        lines = ["720 90 4E454B 5","733 93 3C5582 5"]
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
        obj = WindowColorChecker(path, name, lines)
        result = obj.dump()
        self.assertEqual(expected, result)

if __name__ == "__main__":
    pass
