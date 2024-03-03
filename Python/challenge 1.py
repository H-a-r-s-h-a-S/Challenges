# https://www.linkedin.com/posts/kaushal-joshi-9499b1283_clickthroughrate-ugcPost-7151559111568949248-X3mQ/?utm_source=share&utm_medium=member_ios

# Ads Performance Analysis with PySpark - 
# Analyze the performance of different ads based on their Click-Through Rate (CTR) using PySpark. 
# The CTR is calculated as the ratio of Clicked actions to the total number of Clicked and Viewed actions for each ad.

schema = StructType(
    [
        StructField('ad_id', IntegerType(), True),
        StructField('user_id', IntegerType(), True),
        StructField('action', StringType(), True)

    ]
)

data = [
    (1, 1, 'Clicked'),
    (2, 2, 'Clicked'),
    (3, 3, 'Viewed'),
    (5, 5, 'Ignored'),
    (1, 7, 'Ignored'),
    (2, 7, 'Viewed'),
    (3, 5, 'Clicked'),
    (1, 4, 'Viewed'),
    (2, 11, 'Viewed'),
    (1, 2, 'Clicked'),
]

df = spark.createDataFrame(data, schema = schema)

