fid = open("format.txt", "w+")
for i in range(5):
	fid.write("%d,")
for i in range(141):
	if i != 140:
		fid.write("%f,")
	else:
		fid.write("%f\\n")
fid.close()