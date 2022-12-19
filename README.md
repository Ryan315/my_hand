# my_hand. 
repo for PA-Tran

# 1. Install required packages by running:
> python3 install -r requirements.txt
# 2. data download by running: 
> python3 ./Tools/download_data.py

The time series data will be downloaded to "./data" folder.

# 3. data visualization
For visualizing the time series data, use the matlab script in "./Visualization" folder.
The main script is 'main_single.m'.

# 4. Sub modules
Some useful pose related modules are connected as submodule in the 'useful_module' folder.
Just use git clone command without '--recurse-submodules' otherwise the main folder will contain too many files.
