#! /usr/bin/env python
import os, sys, glob
import numpy as np
import argparse
import cv2
import PIL
from PIL import Image


def parse_args():
	parser = argparse.ArgumentParser(description='')
	parser.add_argument('--root', type=str, required=True, help='root directory')
	parser.add_argument('--template', type=str, required=True, help='template')
	parser.add_argument('--config', type=str, default='./config_default.yaml', help='config file')
	parser.add_argument('--save_path', type=str, default=None, help='save path')



	parser.add_argument('-r',
						'--replace',
						default=False,
						action='store_true',
						help='replace input')
	return parser.parse_args()

args = parse_args()
	

def main():
	args = parse_args()
	
	import yaml
	with open(args.config) as f:
		config  = yaml.safe_load(f)

	root = args.root
	if not os.path.exists(root):
		raise FileNotFoundError(f"The directory '{root}' does not exist. Program terminated.")
	


	column_list = glob.glob(column_template)
	
	




	path_template = os.path.join(root, args.template)
	image_paths = glob.glob(path_template)

	image_list = []
	for image_path in image_paths:
		image_list.append(cv2.imread(image_path))
	images = np.concatenate(image_list, axis=1)

	images = images[:,:,::-1]
	images = Image.fromarray(images)
	



	# Save results
	save_path = args.save_path
	if save_path is None:
		i = 0
		while not os.path.exists(f'temp_figure_{i}.png'):
			i += 1
	cv2.imwrite(save_path, images)

if __name__ == '__main__':
	main()