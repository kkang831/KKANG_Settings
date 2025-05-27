# Define save directory
from datetime import datetime
now = datetime.now()
now = now.strftime('%Y%m%d%H%M%S')
save_dir = f'results/{__file__[:-3]}_{now}'

# Copy current file
import os, shutil
shutil.copy(__file__, os.path.join(save_dir, os.path.basename(__file__)))

# Save arguments
import json
with open(os.path.join(save_dir, 'commandline_args.txt'), 'w') as f:
    json.dump(args.__dict__, f, indent=2)

# Read arguments
# with open('commandline_args.txt', 'r') as f:
#     args.__dict__ = json.load(f)