from keras.models import load_model
from keras.preprocessing.image import load_img
import numpy as np
import matplotlib.pyplot as plt

class ImageRecognition:

    def __init__(self):

        # pretrained models
        self.model10 = load_model('models/cifar10.h5')
        self.model100 = load_model('models/cifar100.h5')
        # self.model10 = load_model('cifar10.h5')
        # self.model100 = load_model('cifar100.h5')

        # labels
        self.labels10 = '''airplane automobile bird cat deer dog frog horse ship truck'''.split()

        self.labels100 = ['apple', 'aquarium_fish', 'baby', 'bear', 'beaver', 'bed', 'bee', 'beetle', 'bicycle', 'bottle', 'bowl', 'boy', 'bridge', 'bus', 'butterfly', 'camel', 'can', 'castle', 'caterpillar', 'cattle', 'chair', 'chimpanzee', 'clock', 'cloud', 'cockroach', 'couch', 'crab', 'crocodile', 'cup', 'dinosaur', 'dolphin', 'elephant', 'flatfish', 'forest', 'fox', 'girl', 'hamster', 'house', 'kangaroo', 'keyboard', 'lamp', 'lawn_mower', 'leopard', 'lion', 'lizard', 'lobster', 'man', 'maple_tree', 'motorcycle', 'mountain', 'mouse', 'mushroom', 'oak_tree', 'orange', 'orchid', 'otter', 'palm_tree', 'pear', 'pickup_truck', 'pine_tree', 'plain', 'plate', 'poppy', 'porcupine', 'possum', 'rabbit', 'raccoon', 'ray', 'road', 'rocket', 'rose', 'sea', 'seal', 'shark', 'shrew', 'skunk', 'skyscraper', 'snail', 'snake', 'spider', 'squirrel', 'streetcar', 'sunflower', 'sweet_pepper', 'table', 'tank', 'telephone', 'television', 'tiger', 'tractor', 'train', 'trout', 'tulip', 'turtle', 'wardrobe', 'whale', 'willow_tree', 'wolf', 'woman', 'worm']

    # parse image
    def parseImg(self, img):

        image = load_img(img, target_size=(32, 32))

        img = np.array(image)
        img = img / 255.0
        img = img.reshape(1,32,32,3)

        return img

    # predict image
    def predictImg(self, img, model, labels):

        results = model.predict(img)
        single_result = results[0]

        # get probability percentage
        most_likely_class_index = int(np.argmax(single_result))
        class_likelihood = single_result[most_likely_class_index] * 100

        # show predicted label
        predicted_label = labels[model.predict(img).argmax()]

        return class_likelihood, predicted_label

    # select label based on probability
    def recognizeImg(self, likelihood10, likelihood100, label10, label100):
        
        if(likelihood10 < 60 and likelihood100 < 60):
            return "unknown"
        elif(likelihood100 >= likelihood10):
            return label100
        else:
            return label10

    def getImageLabel(self, imgPath):

        img = self.parseImg(imgPath)

        ### predict from cifar10 and cifar100
        class_likelihood_10, predicted_label_10 = self.predictImg(img, self.model10, self.labels10)
        class_likelihood_100, predicted_label_100 = self.predictImg(img, self.model100, self.labels100)

        return self.recognizeImg(class_likelihood_10, class_likelihood_100, predicted_label_10, predicted_label_100)


if __name__ == "__main__":

    ir = ImageRecognition()
    imgPath = 'images/deer.jpg'

    print(ir.getImageLabel(imgPath))

