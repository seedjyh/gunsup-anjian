#!/usr/bin/env python
# -*- coding: utf-8 -*-

from config import *
import generator

if __name__ == "__main__":
    print("GunsUp Anjian")
    config = read_config("../gunsup.cfg")
    print(config.source_directory)
    print(config.output_file)
    gen = generator.Generator(config.source_directory, config.output_file)
    gen.generate()
