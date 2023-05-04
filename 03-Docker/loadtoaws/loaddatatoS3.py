import pandas as pd
import boto3

s3 = boto3.client('s3')

bucket = 'nyc-fhvhv-tripdata'
source_url = 'https://d37ci6vzurychx.cloudfront.net/trip-data/fhvhv_tripdata_2022-07.parquet'
fileName = source_url.split('/')[-1]
print("fileName: ",fileName)
parq_data = pd.read_parquet(source_url)
s3.put_object(Bucket=bucket, Key=fileName, Body=parq_data)
print("{} uploaded to {}".format(fileName,bucket))