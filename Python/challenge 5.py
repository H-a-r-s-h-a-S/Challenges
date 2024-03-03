# Read the third quarter (25%) of emp_data table.

emp_data = [
	("Alice", 28),
	("Bob", 35),
	("Charlie", 42),
	("David", 25),
	("Eva", 31),
	("Frank", 38),
	("Grace", 45),
	("Henry", 29)
]

emp_schema = "name string , age int"
 
df = spark.createDataFrame(data = emp_data , schema = emp_schema)

df.show()
