#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/20
import os
import unittest


def search_all_test():
    case_path = os.path.join(os.getcwd(), "meta")
    discover = unittest.defaultTestLoader.discover(case_path, pattern="test*.py", top_level_dir=None)
    return discover


if __name__ == "__main__":
    runner = unittest.TextTestRunner()
    runner.run(search_all_test())
