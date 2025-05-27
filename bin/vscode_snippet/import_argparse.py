import argparse

def parse_args():
    parser = argparse.ArgumentParser(description='')
    parser.add_argument('-r',
                        '--replace',
                        default=False,
                        action='store_true',
                        help='replace input')
    return parser.parse_args()

args = parse_args()