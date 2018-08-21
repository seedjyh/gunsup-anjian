#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/21
from unittest import TestCase
from meta.file import File


class TestFile(TestCase):
    def test_dump(self):
        path = []
        name = ""
        lines = [
            "01 abc",
            "02 def",
            "03 ghi"
        ]
        obj = File(path, name, lines)
        result = obj.dump()
        expected = \
            "01 abc\n"\
            "02 def\n"\
            "03 ghi\n"
        self.assertEqual(expected, result)

if __name__ == "__main__":
    pass
