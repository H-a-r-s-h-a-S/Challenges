# https://www.linkedin.com/posts/dhirajgupta141_pwc-pyspark-pwc-activity-7150682672674025472-E2Fy?utm_source=share&utm_medium=member_ios

# Retrieve information about consecutive login streaks for employee who have logged in for at least two consecutive days.

# For each employee provide the emp_id , 
# the number of consecutive days logged in ,the start_date of the streak and end_date of the streak.

_data = [
	(101,'02-01-2024','N'),
	(101,'03-01-2024','Y'),
	(101,'04-01-2024','N'),
	(101,'07-01-2024','Y'),
	(102,'01-01-2024','N'),
	(102,'02-01-2024','Y'),
	(102,'03-01-2024','Y'),
	(102,'04-01-2024','N'),
	(102,'05-01-2024','Y'),
	(102,'06-01-2024','Y'),
	(102,'07-01-2024','Y'),
	(103,'01-01-2024','N'),
	(103,'04-01-2024','N'),
	(103,'05-01-2024','Y'),
	(103,'06-01-2024','Y'),
	(103,'07-01-2024','N')
]

_schema = ["emp_id" , "log_date" , "flag"]

df = spark.createDataFrame(data = _data , schema = _schema)

df.show()
