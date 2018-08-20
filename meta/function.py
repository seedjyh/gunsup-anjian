#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: seedjyh@gmail.com
# Create date: 2018/8/20
from meta.file import File


class Function(File):
    def get_function_name(self):
        """
        If path path[0] = "A", path[1] = "B", name = "X", this function returns "A_B_X".
        :return: Name of function of this object specified in final dumped result.
        """
        result = self.name
        for n in self.path[::-1]:
            result = n + "_" + result
        return result

if __name__ == "__main__":
    pass
