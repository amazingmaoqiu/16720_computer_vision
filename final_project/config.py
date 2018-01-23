import os


DATA_PATH = '../data'

PASCAL_PATH = os.path.join(DATA_PATH,'pascal_voc')

CACHE_PATH = os.path.join(PASCAL_PATH, 'cache')

#BATCH_SIZE = 15

IMAGE_SIZE = 448

CELL_SIZE = 7

FLIPPED = True




classes = ['aeroplane', 'bicycle', 'bird', 'boat', 'bottle', 'bus',
           'car', 'cat', 'chair', 'cow', 'diningtable', 'dog', 'horse',
           'motorbike', 'person', 'pottedplant', 'sheep', 'sofa',
           'train', 'tvmonitor']

GPU = ''

LEARNING_RATE = 0.0001

DECAY_STEPS = 30000

DECAY_RATE = 0.1

STAIRCASE = True

BATCH_SIZE = 45

MAX_ITER = 15000

SUMMARY_ITER = 10

SAVE_ITER = 1000

"""classes = ['person','bicycle','car','motorbike','aeroplane','bus','train','truck','boat'
			,'traffic light','fire hydrant','stop sign','parking meter','bench','bird','cat','dog'
			,'horse','sheep','cow','elephant','bear','zebra','giraffe','backpack','umbrella','handbag'
			,'tie','suitcase','frisbee','skis','snowboard','sports ball','kite','baseball bat','baseball glove'
			,'skateboard','surfboard','tennis racket','bottle','wine glass','cup','fork','knife','spoon','bowl'
			,'banana','apple','sandwich','orange','broccoli','carrot','hot dog','pizza','donut','cake','chair'
			,'sofa','pottedplant','bed','diningtable','toilet','tvmonitor','laptop','mouse','remote','keyboard'
			,'cell phone','microwave','oven','toaster','sink','refrigerator','book','clock','vase','scissors'
			,'teddy bear','hair drier','toothbrush']"""
