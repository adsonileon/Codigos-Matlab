def postFormat():
	fid = open("format.txt", "w+")
	for i in range(5):
		fid.write("%d,")
	for i in range(1233):
		if i != 1232:
			fid.write("%f,")
		else:
			fid.write("%f\\n")
	fid.close()

def postFormat2():
	fid = open("format2.txt", "w+")
	fid.write("%s,")
	for i in range(8):
		fid.write("%d,")
	for i in range(411):
		fid.write("%f,")
	fid.write("%s\\n")
	fid.close()

def postFormat3():
	fid = open("format3.txt","w+")
	fid.write("%s,")
	for i in range(8):
		fid.write("%d,")
	for i in range(141):
		fid.write("%f,")
	fid.write("%s\\n")
	fid.close()

def addGrad(quan, grad, op, f):
	columnsName = ""
	for g in grad:
		columnsName += g + op + f
		for q in quan:
			columnsName += g + q + op + f
	return columnsName

def addRazoes(raz, op, f):
	columnsName = ""
	for r in raz:
		columnsName += r + op + f
	return columnsName

def addRazoesQ(quan, raz, op, f):
	columnsName = ""
	for q in quan:
		for r in raz:
			columnsName += r + q + op + f
	return columnsName

def postColumnsName():
	grad1 = ["Gv", "Gh", "Mag1", "Dir1", "Gur", "Gul", "Mag2", "Dir2"]
	grad2 = ["Gur", "Gul", "Mag1", "Dir1"]
	#raz1 = ["Gv/Gh", "Gh/Gv", "Gv-Gh", "Gh-Gv", "Gv/Gh-Gh/Gv", "Gh/Gv-Gv/Gh"]
	#raz2 = ["Gur/Gul", "Gul/Gur", "Gur-Gul", "Gul-Gur", "Gur/Gul-Gul/Gur", "Gul/Gur-Gur/Gul"]
	raz1 = ["Gv/Gh", "Gh/Gv"]
	raz2 = ["Gur/Gul", "Gul/Gur"]
	oper = [" S", " R", " P"] #Sobel, Roberts, Prewitts
	desv = ["Dv", "Dh", "Dur", "Dul"]
	#raz3 = ["Dv/Dh", "Dh/Dv", "Dv-Dh", "Dh-Dv", "Dv/Dh-Dh/Dv", "Dh/Dv-Dv/Dh"]
	#raz4 = ["Dur/Dul", "Dul/Dur", "Dur-Dul", "Dul-Dur", "Dur/Dul-Dul/Dur", "Dul/Dur-Dur/Dul"]
	raz3 = ["Dv/Dh", "Dh/Dv"]
	raz4 = ["Dur/Dul", "Dul/Dur"]
	vari = ["Vv", "Vh", "Vur", "Vul"]
	#raz5 = ["Vv/Vh", "Vh/Vv", "Vv-Vh", "Vh-Vv", "Vv/Vh-Vh/Vv", "Vh/Vv-Vv/Vh"]
	#raz6 = ["Vur/Vul", "Vul/Vur", "Vur-Vul", "Vul-Vur", "Vur/Vul-Vul/Vur", "Vul/Vur-Vur/Vul"]
	raz5 = ["Vv/Vh", "Vh/Vv"]
	raz6 = ["Vur/Vul", "Vul/Vur"]
	#quan = [" Q25", " Q50", " Q75", " Q100"]
	quan = []
	filt = [","," FM,", " C,"] #Filter Mean, Contraste
	#filt = [","]
	columnsName = "sequence,width,height,qp,poc,xTL,yTL,xBR,yBR,"
	for f in filt:
		for op in oper:
			if op != " R":
				columnsName += addGrad(quan, grad1, op, f)
				columnsName += addRazoes(raz1, op, f)
				'''columnsName += addRazoesQ(quan, raz1[:2], op, f)
				columnsName += addRazoesQ(quan, raz1[2:4], op, f)
				columnsName += addRazoesQ(quan, raz1[4:], op, f)'''
				columnsName += addRazoes(raz2, op, f)
				'''columnsName += addRazoesQ(quan, raz2[:2], op, f)
				columnsName += addRazoesQ(quan, raz2[2:4], op, f)
				columnsName += addRazoesQ(quan, raz2[4:], op, f)'''
			else:
				columnsName += addGrad(quan, grad2, op, f)
				columnsName += addRazoes(raz2, op, f)
				'''columnsName += addRazoesQ(quan, raz2[:2], op, f)
				columnsName += addRazoesQ(quan, raz2[2:4], op, f)
				columnsName += addRazoesQ(quan, raz2[4:], op, f)'''
		columnsName += "Media"+f
		columnsName += addGrad(quan, desv, "", f)
		columnsName += addRazoes(raz3, "", f)
		'''columnsName += addRazoesQ(quan, raz3[:2], "", f)
		columnsName += addRazoesQ(quan, raz3[2:4], "", f)
		columnsName += addRazoesQ(quan, raz3[4:], "", f)'''
		columnsName += addRazoes(raz4, "", f)
		'''columnsName += addRazoesQ(quan, raz4[:2], "", f)
		columnsName += addRazoesQ(quan, raz4[2:4], "", f)
		columnsName += addRazoesQ(quan, raz4[4:], "", f)'''
		columnsName += addGrad(quan, vari, "", f)
		columnsName += addRazoes(raz5, "", f)
		'''columnsName += addRazoesQ(quan, raz5[:2], "", f)
		columnsName += addRazoesQ(quan, raz5[2:4], "", f)
		columnsName += addRazoesQ(quan, raz5[4:], "", f)'''
		columnsName += addRazoes(raz6, "", f)
		'''columnsName += addRazoesQ(quan, raz6[:2], "", f)
		columnsName += addRazoesQ(quan, raz6[2:4], "", f)
		columnsName += addRazoesQ(quan, raz6[4:], "", f)'''
	columnsName += "class"
	print(columnsName)

postColumnsName()
#postFormat2()
#postFormat3()