#!/usr/bin/env python

import os, sys, argparse, glob
import numpy as np
import cv2
import PIL
from PIL import Image

def parse_args():
    parser = argparse.ArgumentParser(description='')
    parser.add_argument('-r',
                        '--replace',
                        default=False,
                        action='store_true',
                        help='replace input')
    return parser.parse_args()


def main():
    args = parse_args()

    target_files = sys.stdin.read().splitlines()
    print("target files: %d EA" % len(target_files), file=sys.stderr)

    for target_file in target_files:
        # ``` write img processing
        

        # ``` img save
        path_output = None
        if args.replace:
            path_output = target_file
        else:
            parts = target_file.split('.')
            head = ''.join(parts[:-1])
            ext = parts[-1]
            # path_output = head + '_noise%.1f' % (args.var) + "." + ext

        # im.save(path_output, quality=100, subsampling=0)
        print(path_output)


if __name__ == '__main__':
    main()