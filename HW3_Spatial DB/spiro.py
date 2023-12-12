import math
import numpy as np
t = 0.00
R = 36.0
r = 9.0
a = 30.0
nRevs = 8
center_lon = -118.28533949110432
center_lat = 34.02075753377144

with open("spiro.txt", 'w') as f:
    f.write('[\n')

    for t in np.arange(0.0, math.pi * nRevs, 0.1):
        x = ((R + r) * math.cos((r / R) * t) - a * math.cos((1 + r / R) * t))/10000 + center_lon
        y = ((R + r) * math.sin((r / R) * t) - a * math.sin((1 + r / R) * t))/10000 + center_lat
        res = f'"loc": [{x},{y}]\n'
        f.write('{\n')
        f.write(res)
        f.write('},\n')

    f.write(']')
