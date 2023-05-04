import numpy as np
import pandas as pd
import pyarrow as pa
import boto3
import os
#from dotenv import load_dotenv
import awswrangler as wr
#load_dotenv();

s3 = boto3.client('s3')

bucket = 'nyc-fhvhv-tripdata'
source_url = 'https://d37ci6vzurychx.cloudfront.net/trip-data/fhvhv_tripdata_2022-07.parquet'
fileName = source_url.split('/')[-1]
print("fileName: ",fileName)
parq_data = pd.read_parquet(source_url)
print("parq read complete")
df =pd.DataFrame.read_parquet(source_url, orient='index')
print("dataframe creaetd")
wr.s3.to_parquet(dataframe=df,path="s3://nyc-fhvhv-tripdata/")

#s3.put_object(Bucket=bucket, Key=fileName, Body=parq_data)
print("{} uploaded to {}".format(fileName,bucket))