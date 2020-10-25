import pandas as pd
data = pd.read_csv('roaddistance.csv')
col = data.columns[1:]
print(":- dynamic edges/3.")
for i in range(len(data)):
	for j in col:
		try:
			print("edges(\""+str(data.loc[i,"Name"])+"\",\""+j+"\","+ str(int(data.loc[i, j])) + ").")
			print("edges(\""+j+"\",\""+str(data.loc[i,"Name"])+"\","+ str(int(data.loc[i, j])) + ").")
		except:
			if j == str(data.loc[i,"Name"]):
				print("edges(\""+str(data.loc[i,"Name"])+"\",\""+j+"\","+ str(0) + ").")