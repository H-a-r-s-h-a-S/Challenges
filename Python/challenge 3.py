# https://www.linkedin.com/posts/dhirajgupta141_pyspark-pyspark-sql-activity-7149603058916794368-a2mj?utm_source=share&utm_medium=member_ios

# Write a solution to swap the seat id of every two consecutive students.
# If the number is odd, the id of the last student is not swapped.

_data = [
	(1,'Abbot'),
	(2,'Doris'),
	(3,'Emerson'),
	(4,'Green'),
	(5,'Jeames')
]

_schema = ['id', 'student']

df = spark.createDataFrame(data = _data, schema=_schema)

