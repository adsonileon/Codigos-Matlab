def postFormat():
	fid = open("format.txt", "w+")
	for i in range(5):
		fid.write("%d,")
	for i in range(963):
		if i != 962:
			fid.write("%f,")
		else:
			fid.write("%f\\n")
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
	grad1 = ["Gv", "Gh", "Mag1", "Dir1", "Gul", "Gur", "Mag2", "Dir2"]
	grad2 = ["Gul", "Gur", "Mag1", "Dir1"]
	raz1 = ["Gh/Gv", "Gv/Gh", "Gh-Gv", "Gv-Gh"]
	raz2 = ["Gul/Gur", "Gur/Gul", "Gul-Gur", "Gur-Gul"]
	oper = [" S", " R", " P"] #Sobel, Roberts, Prewitts
	desv = ["Dv", "Dh", "Dul", "Dur"]
	raz3 = ["Dh/Dv", "Dv/Dh", "Dh-Dv", "Dv-Dh"]
	raz4 = ["Dul/Dur", "Dur/Dul", "Dul-Dur", "Dur-Dul"]
	vari = ["Vv", "Vh", "Vul", "Vur"]
	raz5 = ["Vh/Vv", "Vv/Vh", "Vh-Vv", "Vv-Vh"]
	raz6 = ["Vul/Vur", "Vur/Vul", "Vul-Vur", "Vur-Vul"]
	quan = [" Q25", " Q50", " Q75", " Q100"]
	filt = [","," FM,", " C,"] #Filter Mean, Contraste
	columnsName = "poc,xTL,yTL,xBR,yBR,"
	for f in filt:
		for op in oper:
			if op != " R":
				columnsName += addGrad(quan, grad1, op, f)
				columnsName += addRazoes(raz1, op, f)
				columnsName += addRazoesQ(quan, raz1[:2], op, f)
				columnsName += addRazoesQ(quan, raz1[2:], op, f)
				columnsName += addRazoes(raz2, op, f)
				columnsName += addRazoesQ(quan, raz2[:2], op, f)
				columnsName += addRazoesQ(quan, raz2[2:], op, f)
			else:
				columnsName += addGrad(quan, grad2, op, f)
				columnsName += addRazoes(raz2, op, f)
				columnsName += addRazoesQ(quan, raz2[:2], op, f)
				columnsName += addRazoesQ(quan, raz2[2:], op, f)
		columnsName += "Media"+f
		columnsName += addGrad(quan, desv, "", f)
		columnsName += addRazoes(raz3, "", f)
		columnsName += addRazoesQ(quan, raz3[:2], "", f)
		columnsName += addRazoesQ(quan, raz3[2:], "", f)
		columnsName += addRazoes(raz4, "", f)
		columnsName += addRazoesQ(quan, raz4[:2], "", f)
		columnsName += addRazoesQ(quan, raz4[2:], "", f)
		columnsName += addGrad(quan, vari, "", f)
		columnsName += addRazoes(raz5, "", f)
		columnsName += addRazoesQ(quan, raz5[:2], "", f)
		columnsName += addRazoesQ(quan, raz5[2:], "", f)
		columnsName += addRazoes(raz6, "", f)
		columnsName += addRazoesQ(quan, raz6[:2], "", f)
		columnsName += addRazoesQ(quan, raz6[2:], "", f)
	print(columnsName)

#postColumnsName()
postFormat()