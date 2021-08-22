import pandas as pd
data = pd.read_csv('roaddistance.csv')
col = data.columns[1:]

print(":- dynamic heuristic/3")
list_of_cities = list(col)
for i in range(len(data)):
	list_of_cities.append(data.loc[i, 'Name'])

list_of_cities = list(set(list_of_cities))


from geopy.geocoders import Nominatim
from geopy.distance import great_circle
geolocator = Nominatim(user_agent="user_agent")
for i in list_of_cities:
	for j in list_of_cities:
		if i != j:
			location1 = geolocator.geocode(i)
			location2 = geolocator.geocode(j)
			dis1 = great_circle((location1.latitude, location1.longitude),(location2.latitude, location2.longitude)).kilometers
			dis2 = great_circle((location2.latitude, location2.longitude),(location1.latitude, location1.longitude)).kilometers
			print("heuristic(\""+i+"\",\""+j+"\","+str(dis1)+").")
