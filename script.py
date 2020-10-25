import pandas as pd
data = pd.read_csv('roaddistance.csv')
col = data.columns[1:]
print(":- dynamic edges/3.")
for i in range(len(data)):
	for j in col:
		try:
			print("edges(\""+str(data.loc[i,"dd"])+"\",\""+j+"\","+ str(int(data.loc[i, j])) + ").")
			print("edges(\""+j+"\",\""+str(data.loc[i,"dd"])+"\","+ str(int(data.loc[i, j])) + ").")
		except:
			g=0