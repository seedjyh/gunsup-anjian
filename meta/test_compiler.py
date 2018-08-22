#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/22
import unittest

from meta.compiler import Compiler


class TestCompiler(unittest.TestCase):
    def test_get_function_name(self):
        self.assertEqual("abc_def_ghi", Compiler().get_function_name("abc\\def\\ghi"))

    def test_get_function_prefix(self):
        self.assertEqual("abc_def_", Compiler().get_function_prefix("abc\\def\\ghi"))

if __name__ == "__main__":
    unittest.main()
