path="/media/ileon/9A94269294267145/Codificacao/ProjetoPCV-PDI/Calculos/B/"
fid1 = open(path+"MarketPlace_1920x1080_60fps_10bit_420_8x8_Skip60_O.csv", "r")
fid2 = open(path+"MarketPlace_1920x1080_60fps_10bit_420_8x8_Skip20_O.csv", "r")
fid3 = open(path+"MarketPlace_1920x1080_60fps_10bit_420_8x8_Skip20_O_new.csv", "w+")
#count = sum(1 for line in fid2)
lines = 0
fid3.write(fid1.readline())
lines+=1
fid2.readline()
for i in range(10):
	for j in range(32400):
		fid3.write(fid1.readline())
		lines+=1
	for j in range(64800):
		fid3.write(fid2.readline())
		lines+=1

fid1.close()
fid2.close()
fid3.close()
print(lines)

'''for i in range(8040):
	fid3.write(fid1.readline())
	lines+=1

for i in range(32160):
	fid1.readline()

for i in range(241200):
	fid3.write(fid2.readline())
	lines+=1

for i in range(8040):
	fid3.write(fid1.readline())
	lines+=1

for i in range(225120):
	fid3.write(fid2.readline())
	lines+=1

print(lines)'''

'''for i in range(32400):
	fid3.write(fid1.readline())
	lines+=1

for i in range(615600):
	fid3.write(fid2.readline())
	lines+=1

print(lines)'''

'''
lines = 0
for line in fid2:
	if lines > 0:
		fid3.write(line)
	lines+=1
fid2.close()
fid3.close()
fid3 = open(path+"Tango2_3840x2160_60fps_10bit_420_16x16_Skip15_O_new.csv", "r")
count = sum(1 for line in fid3)
print(count)
fid3.close()'''
'''fid2 = open(path+"Tango2_3840x2160_60fps_10bit_420_32x32_Skip5_O.csv", "r")
count = sum(1 for line in fid2)
print(count)
fid2.close()'''