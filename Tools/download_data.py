import gdown
import zipfile
import os

url = 'https://drive.google.com/file/d/1trKMUam4N2hzmMYSEbCf67QLQcDRYrTy/view?usp=sharing'
output = 'data.zip'
gdown.download(url, output, quiet=True, fuzzy=True)

# root_path = os.path.abspath(os.path.join(os.getcwd(), os.path.pardir))
data_path = os.path.join(os.getcwd(), 'data')
if not os.path.exists(data_path):
    os.mkdir(data_path)

with zipfile.ZipFile("./data.zip", "r") as zip_ref:
    zip_ref.extractall(data_path)
os.remove("./data.zip")