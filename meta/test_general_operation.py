#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/20
from unittest import TestCase

from meta.general_operation import GeneralOperation

if __name__ == "__main__":
    pass


class TestGeneralOperation(TestCase):
    def test_dump(self):
        path = ["General", "Static"]
        name = "MyOp"
        lines = ["First line", "Second line", "Third line"]
        expected = \
            "Function General_Static_MyOp()\n"\
            "    First line\n"\
            "    Second line\n"\
            "    Third line\n"\
            "End Function\n"
        obj = GeneralOperation(path, name, lines)
        result = obj.dump()
        self.assertEqual(expected, result)
