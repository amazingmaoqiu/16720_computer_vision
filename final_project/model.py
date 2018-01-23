import numpy as np 
import tensorflow as tf 
import config as cfg 
from keras.models import Model, Sequential
from keras.preprocessing import image
from keras.layers.core import Dense, Activation, Flatten, Reshape
from keras.layers import Conv2D, MaxPooling2D, LeakyReLU, BatchNormalization, Input, Lambda, concatenate, Reshape
from keras.optimizers import Adam
import math
import cv2
import glob
import keras
import sys
from utils import load_weights, Box, yolo_net_out_to_car_boxes, draw_box
from keras import backend as K



class YOLO2(object):
	def __init__(self, is_training):
		self.classes = cfg.classes
		self.num_class = len(self.classes)
	 	self.img_size = cfg.img_size
	 	self.cell_size = cfg.cell_size
		return self.generate_net()

	@staticmethod
	def generate_tiny_net():
		# keras.backend.set_image_dim_ordering('th')
		model = Sequential()
		# block1
		model.add(Conv2D(16,(3, 3), strides = (1, 1), use_bias = False, input_shape= (416, 416, 3), padding = 'same'))
		model.add(BatchNormalization())
		model.add(LeakyReLU(alpha = 0.1))
		model.add(MaxPooling2D(pool_size = (2, 2)))
		# block2
		model.add(Conv2D(32, (3, 3), use_bias = False, padding = 'same'))
		model.add(BatchNormalization())
		model.add(LeakyReLU(alpha = 0.1))
		model.add(MaxPooling2D(pool_size = (2, 2), padding = 'valid'))
		# block3
		model.add(Conv2D(64,(3,3), use_bias = False, padding = 'same'))
		model.add(BatchNormalization())
		model.add(LeakyReLU(alpha = 0.1))
		model.add(MaxPooling2D(pool_size = (2, 2), padding = 'valid'))
		# block4
		model.add(Conv2D(128, (3, 3), use_bias = False, padding = 'same'))
		model.add(BatchNormalization())
		model.add(LeakyReLU(alpha = 0.1))
		model.add(MaxPooling2D(pool_size = (2, 2), padding = 'valid'))
		# block5
		model.add(Conv2D(256, (3, 3), use_bias = False, padding = 'same'))
		model.add(BatchNormalization())
		model.add(LeakyReLU(alpha = 0.1))
		model.add(MaxPooling2D(pool_size = (2, 2), padding = 'valid'))
		# block6
		model.add(Conv2D(512, (3, 3), use_bias = False, strides = 1, padding = 'same'))
		model.add(BatchNormalization())
		model.add(LeakyReLU(alpha = 0.1))
		model.add(MaxPooling2D(pool_size = (2, 2), strides = 1, padding = 'same'))
		
		model.add(Conv2D(1024, (3, 3), use_bias = False, padding = 'same'))
		model.add(BatchNormalization())
		model.add(LeakyReLU(alpha = 0.1))

		model.add(Conv2D(512, (3, 3), use_bias = False, padding = 'same'))
		model.add(BatchNormalization())
		model.add(LeakyReLU(alpha = 0.1))

		model.add(Conv2D(425, (1, 1), padding = 'same'))
		model.summary()
		model.load_weights('data/yolo-tiny.h5', by_name = True)
		return model


	@staticmethod
	def generate_net():
		main_input = Input(shape = (608, 608, 3), dtype = 'float32', name = 'main_input')
		conv1 = Conv2D(32, (3,3),  use_bias = False, strides = 1, padding = 'same', input_shape = (1,608,608,3))(main_input)
		bn1   = BatchNormalization()(conv1)
		lk_relu_1 = LeakyReLU(alpha = 0.1)(bn1)
		maxpool_1 = MaxPooling2D(pool_size = (2, 2), padding = 'valid')(lk_relu_1)

		conv2 = Conv2D(64, (3,3),  use_bias = False, strides = 1, padding = 'same')(maxpool_1)
		bn2   = BatchNormalization()(conv2)
		lk_relu_2 = LeakyReLU(alpha = 0.1)(bn2)
		maxpool_2 = MaxPooling2D(pool_size = (2, 2), padding = 'valid')(lk_relu_2)

		conv3 = Conv2D(128, (3,3),  use_bias = False, strides = 1, padding = 'same')(maxpool_2)
		bn3   = BatchNormalization()(conv3)
		lk_relu_3 = LeakyReLU(alpha = 0.1)(bn3)

		conv4 = Conv2D(64, (1,1),  use_bias = False, strides = 1, padding = 'same')(lk_relu_3)
		bn4 = BatchNormalization()(conv4)
		lk_relu_4 = LeakyReLU(alpha = 0.1)(bn4)

		conv5 = Conv2D(128, (3,3),  use_bias = False, strides = 1, padding = 'same')(lk_relu_4)
		bn5 = BatchNormalization()(conv5)
		lk_relu_5 = LeakyReLU(alpha = 0.1)(bn5)
		maxpool_5 = MaxPooling2D(pool_size = (2, 2), padding = 'valid')(lk_relu_5)

		conv6 = Conv2D(256, (3,3),  use_bias = False, strides = 1, padding = 'same')(maxpool_5)
		bn6 = BatchNormalization()(conv6)
		lk_relu_6 = LeakyReLU(alpha = 0.1)(bn6)

		conv7 = Conv2D(128, (1, 1),  use_bias = False, strides = 1, padding = 'same')(lk_relu_6)
		bn7   = BatchNormalization()(conv7)
		lk_relu_7 = LeakyReLU(alpha = 0.1)(bn7)

		conv8 = Conv2D(256, (3,3),  use_bias = False, strides = 1, padding = 'same')(lk_relu_7)
		bn8   = BatchNormalization()(conv8)
		lk_relu_8 = LeakyReLU(alpha = 0.1)(bn8)
		maxpool_8 = MaxPooling2D(pool_size = (2, 2), padding = 'valid')(lk_relu_8)

		conv9 = Conv2D(512, (3,3),  use_bias = False, strides = 1, padding = 'same')(maxpool_8)
		bn9   = BatchNormalization()(conv9)
		lk_relu_9 = LeakyReLU(alpha = 0.1)(bn9)

		conv10 = Conv2D(256, (1,1),  use_bias = False, strides = 1, padding = 'same')(lk_relu_9)
		bn10 = BatchNormalization()(conv10)
		lk_relu_10 = LeakyReLU(alpha = 0.1)(bn10)

		conv11 = Conv2D(512, (3,3),  use_bias = False, strides = 1, padding = 'same')(lk_relu_10)
		bn11   = BatchNormalization()(conv11)
		lk_relu_11 = LeakyReLU(alpha = 0.1)(bn11)

		conv12 = Conv2D(256, (1,1),  use_bias = False, strides = 1, padding = 'same')(lk_relu_11)
		bn12 = BatchNormalization()(conv12)
		lk_relu_12 = LeakyReLU(alpha = 0.1)(bn12)

		conv13 = Conv2D(512, (3,3),  use_bias = False, strides = 1, padding = 'same')(lk_relu_12)
		bn13   = BatchNormalization()(conv13)
		lk_relu_13 = LeakyReLU(alpha = 0.1)(bn13)
		maxpool_13 = MaxPooling2D(pool_size = (2, 2), padding = 'valid')(lk_relu_13)

		conv14 = Conv2D(1024, (3,3),  use_bias = False, strides = 1, padding = 'same')(maxpool_13)
		bn14   = BatchNormalization()(conv14)
		lk_relu_14 = LeakyReLU(alpha = 0.1)(bn14)

		conv15 = Conv2D(512, (1,1),  use_bias = False, strides = 1, padding = 'same')(lk_relu_14)
		bn15   = BatchNormalization()(conv15)
		lk_relu_15 = LeakyReLU(alpha = 0.1)(bn15)

		conv16 = Conv2D(1024, (3,3),  use_bias = False, strides = 1, padding = 'same')(lk_relu_15)
		bn16   = BatchNormalization()(conv16)
		lk_relu_16 = LeakyReLU(alpha = 0.1)(bn16)

		conv17 = Conv2D(512, (1,1),  use_bias = False, strides = 1, padding = 'same')(lk_relu_16)
		bn17   = BatchNormalization()(conv17)
		lk_relu_17 = LeakyReLU(alpha = 0.1)(bn17)

		conv18 = Conv2D(1024, (3,3),  use_bias = False, strides = 1, padding = 'same')(lk_relu_17)
		bn18   = BatchNormalization()(conv18)
		lk_relu_18 = LeakyReLU(alpha = 0.1)(bn18)

		conv19 = Conv2D(1024, (3,3),  use_bias = False, strides = 1, padding = 'same')(lk_relu_18)
		bn19   = BatchNormalization()(conv19)
		lk_relu_19 = LeakyReLU(alpha = 0.1)(bn19)

		conv20 = Conv2D(1024, (3,3),  use_bias = False, strides = 1, padding = 'same')(lk_relu_19)
		bn20   = BatchNormalization()(conv20)
		lk_relu_20 = LeakyReLU(alpha = 0.1)(bn20)

		conv21 = Conv2D(64, (1,1),  use_bias = False, strides = 1, padding = 'same')(lk_relu_13)
		bn21   = BatchNormalization()(conv21)
		lk_relu_21 = LeakyReLU(alpha = 0.1)(bn21)

		space_to_depth = Reshape((19, 19, 256))(lk_relu_21)
		concatenate_1 = concatenate([space_to_depth, lk_relu_20])

		conv22 = Conv2D(1024, (3,3), use_bias = False, strides = 1, padding = 'same')(concatenate_1)
		bn22   = BatchNormalization()(conv22)
		lk_relu_22 = LeakyReLU(alpha = 0.1)(bn22)

		conv23 = Conv2D(425, (1,1), strides = 1, padding = 'same')(lk_relu_22)


		model = Model(inputs = main_input, outputs = conv23)
		# model.summary()
		model.load_weights('data/yolov2.h5', by_name = True)
		return model


cell_size = 19
num_class = 80
box_per_cell = 5
TestClasses = cfg.classes
anchor = np.array([[0.57273, 0.677385],
					[1.87446, 2.06253],
					[3.33843, 5.47434],
					[7.88282, 3.52778],
					[9.77052, 9.16828]])
score_threshold = 0.35
iou_threshold   = 0.4
color_menu = {1:(0,255,0),
				2:(255,0,0),
				3:(0,0,255),
				4:(125,125,0),
				5:(125,0,125)}
def sigmoid(incoming):
	return 1.0/(1.0 + np.exp(-1.0 * incoming))


def softmax(incoming):
	tmp = np.transpose(incoming, (3,0,1,2))
	result = np.exp(tmp)/np.sum(np.exp(tmp), axis = 0)
	result = np.transpose(result, (1,2,3,0))
	return(result)


def yolo_boxes_to_corners(box_xy, box_wh):
	box_mins = box_xy - (box_wh / 2.0)
	box_maxes = box_xy + (box_wh / 2.0)
	result = np.array([box_mins[...,1:2],
						box_mins[...,0:1],
						box_maxes[...,1:2],
						box_maxes[...,0:1]])
	result = result.squeeze()
	return result

def yolo_filter_boxes(boxes, box_confidence, box_class_probs, threshold = 0.6):
	box_scores = box_confidence * box_class_probs
	box_classes = np.argmax(box_scores, axis = -1)
	box_class_scores = np.max(box_scores, axis = -1)
	prediction_mask = box_class_scores > threshold

	boxes = boxes * prediction_mask
	scores = box_class_scores * prediction_mask
	classes = box_classes * prediction_mask
	return boxes, scores, classes


def calculate_iou(box1, box2):
	tb = min(box1[3], box2[3]) - max(box1[1], box2[1])
	lr = min(box1[2], box2[2]) - max(box1[0], box2[0])
	intersection = tb * lr
	if tb < 0 or lr < 0:
		intersection = 0
	else:
		intersection = tb * lr
	return float(intersection) / ((box1[2] - box1[0])*(box1[3] - box1[1]) + (box2[2] - box2[0])*(box2[3] - box2[1]) - intersection)

def interpret(outputs, img, img_name):
	conv_dims = outputs.shape[0:2]
	conv_height_index = np.arange(conv_dims[0])
	conv_width_index  = np.arange(conv_dims[1])
	conv_height_index = np.tile(conv_height_index, [conv_dims[1],1])
	conv_height_index = np.expand_dims(conv_height_index.flatten(),0)
	conv_width_index  = np.tile(np.expand_dims(conv_width_index, 0), [conv_dims[0], 1])
	conv_width_index  = np.reshape(np.transpose(conv_width_index),[1,-1])
	conv_index = np.transpose(np.stack([conv_height_index, conv_width_index]))
	conv_index = np.reshape(conv_index, [1, conv_dims[0], conv_dims[1], 1, 2])

	outputs = outputs.reshape([cell_size, cell_size, box_per_cell, num_class + 5])
	box_xy = sigmoid(outputs[:,:,:,:2])
	box_wh = np.exp(outputs[:,:,:,2:4])
	box_confidence = sigmoid(outputs[:,:,:,4:5])
	box_class_probs = softmax(outputs[...,5:])

	box_xy = (box_xy + conv_index) / conv_dims
	box_wh = (box_wh * anchor) / conv_dims


	boxes = yolo_boxes_to_corners(box_xy, box_wh)

	boxes, scores, classes = yolo_filter_boxes(boxes, box_confidence, box_class_probs, threshold = score_threshold)

	height, width, _ = img.shape
	img_dims = np.stack([height, width, height, width])
	img_dims = np.reshape(img_dims, [1,4])
	boxes = np.transpose(boxes, [1,2,3,0])  #boxes.shape => [19x19x5x4], more easy to operate later

	boxes = boxes * img_dims

	box = boxes[scores > 0].astype('int')
	class1 = classes[scores > 0]
	scores = scores[scores > 0]
	order_index = np.array(np.argsort(scores))
	order_index = order_index[::-1]
	scores = scores[order_index]
	box = box[order_index]
	class1 = class1[order_index]
	for i in range(len(scores)):
		for j in range(i+1,len(scores)):
			if calculate_iou(box[i,:], box[j,:]) > iou_threshold and class1[i] == class1[j]:
				scores[j] = 0
	box = box[scores > 0]
	class1 = class1[scores > 0]
	scores = scores[scores > 0]

	color_list = {}
	num_curr_color = 1
	for i in range(box.shape[0]):
		if TestClasses[class1[i]] in color_list:
			color = color_list[TestClasses[class1[i]]]
		else:
			color = color_list[TestClasses[class1[i]]] = color_menu[num_curr_color]
			# color = color_list[TestClasses[class1[i]]]
			num_curr_color += 1
		cv2.rectangle(img, (box[i,1],box[i,0]), (box[i,3],box[i,2]), color, 2)
		cv2.rectangle(img, (box[i,1] - 1,box[i,2]), (box[i,3] + 1,box[i,2] + 20), color, -1)
		cv2.putText(img, str(TestClasses[class1[i]]), (box[i,1] + 7, box[i,2] + 11), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 0), 1, cv2.LINE_AA)
		print(TestClasses[class1[i]])
	cv2.imshow('img',img)
	cv2.imwrite( '../test/result/' + img_name, img)
	cv2.waitKey(0)
	cv2.destroyAllWindows()
	return box_xy, box_wh, box_confidence, box_class_probs





def video_cap(path):
	cap = cv2.VideoCapture(path)
	ret, frame = cap.read()
	frames = {}
	index = 0
	while(ret):
		frames[index] = frame
		ret, frame = cap.read()
		index += 1
	return frames

def main():
	model = YOLO2.generate_net()
	inp = model.input   
	# print(inp)       	                                 # input placeholder
	# outputs = [layer.output for layer in model.layers]          # all layer outputs
	# functor = K.function([inp]+ [K.learning_phase()], outputs ) # evaluation function

 	# Testing
 	load_path = "../test/"
	img_name = sys.argv[1]
	img = cv2.imread( load_path + img_name)
	img_h, img_w, _ = img.shape
	img1 = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
	img1 = cv2.resize(img1, (608, 608)).astype(np.float32)
	img1 = (img1 / 255.0)

	interpret(outputs1[0,:,:,:], img, img_name)
	


if __name__ == "__main__":
	main()
