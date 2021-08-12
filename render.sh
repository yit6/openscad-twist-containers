#!/bin/sh
openscad -DPART='"inside"' -o inside.stl twist.scad
openscad -DPART='"outside"' -o outside.stl twist.scad
