import argparse
from py.class_image_recognition import ImageRecognition

# get arguments
ap = argparse.ArgumentParser()

ap.add_argument("path", help="path to input photo to be labelled")
args = vars(ap.parse_args())

# set class
ir = ImageRecognition()
imgPath = args["path"]

print(ir.getImageLabel(imgPath))