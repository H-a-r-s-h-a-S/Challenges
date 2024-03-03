# https://www.linkedin.com/posts/lipsa-biswas_pyspark-eda-activity-7151070921523347456-YiRk?utm_source=share&utm_medium=member_ios

# Identifying missing values and treating/imputing missing values is an important step in exploratory data analysis. Let's try it in PySpark dataframe API.
# Task - In a PySpark dataframe,
	# a) Identify columns that contain no null values.
	# b) Identify columns where every value is null.
	# c) Identify columns with at least one null value

emp_data = [
  (1,'Neha' , 30 , None, 'IT'),
  (2,'Mark' , None , None, 'HR'),
  (3,'David' , 25 , None, 'HR'),
  (4,'Carol' , 30 , None, None)
]

