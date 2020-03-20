fid = open("format.txt", "w+")
for i in range(5):
	fid.write("%d,")
for i in range(600):
	if i != 599:
		fid.write("%f,")
	else:
		fid.write("%f\\n")
fid.close()