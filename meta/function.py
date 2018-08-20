#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/20
from meta.file import File


class Function(File):
    @staticmethod
    def get_function_prefix(path=None):
        """
        If path path[0] = "A", path[1] = "B", name = "X", this function returns "A_B_".
        :return: Prefix in the name of function of this object specified in final dumped result.
        """
        if path == None:
            path = []
        result = ""
        for n in path:
            result += n + "_"
        return result

if __name__ == "__main__":
    pass
