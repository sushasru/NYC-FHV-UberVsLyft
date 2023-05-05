import requests
import os
import gcsfs
import pyarrow.parquet as pq
from google.cloud import storage
from prefect import flow, task
from prefect_gcp.cloud_storage import GcsBucket
from prefect_gcp import GcpCredentials
import pandas as pd


@task(name='download parquet from nyctaxi', log_prints=True)
def download_parquetfiles(bucket_url):
    r = requests.get(bucket_url,allow_redirects=True)
    fileName = bucket_url.split('/')[-1]
    print(fileName)
    if 'parquet' in fileName:
        filepath = "../files/files_parquet/"
    else:
        filepath = "../files/files_csv/"
    if not os.path.exists(filepath):
        os.makedirs(filepath)

    fullfilepath = os.path.join(filepath,fileName)
    open(fullfilepath,'wb').write(r.content)

@task(name='load csv to GCS', log_prints=True)
def upload_csv_to_gcs():
    print("\nUpload csv files to GCS")
    gcp_cred = GcpCredentials.load('nyc-fhvhv-gcs-new',validate=False)
    for filename in os.listdir('../files/files_csv/'):
        fullcsvpath = os.path.join('../files/files_csv/',filename)
        print("FullCSVPath: "+fullcsvpath)
        gcs_block = GcsBucket.load("nyc-fhvhv-gcs-block")#validate=False,GcpCredentials=gcp_cred)
        targetfolder=os.path.join('files_csv/',filename)
        gcs_block.upload_from_path(from_path = f"{fullcsvpath}",to_path=f"{targetfolder}")

@task(name='load parquet to GCS', log_prints=True)
def upload_parquet_to_gcs():
    print("\nUpload parquet files to GCS")
    gcp_cred = GcpCredentials.load('nyc-fhvhv-gcs-new',validate=False)
    for filename in os.listdir('../files/files_parquet/'):
        fullparquetpath = os.path.join('../files/files_parquet/',filename)
        print("FullparquetPath: "+fullparquetpath)
        gcs_block = GcsBucket.load("nyc-fhvhv-gcs-block")#validate=False,GcpCredentials=gcp_cred)
        targetfolder=os.path.join('files_parquet/',filename)
        gcs_block.upload_from_path(from_path = f"{fullparquetpath}",to_path=f"{targetfolder}")


@flow(name="extract data from gcs")
def extract_data_from_gcs():
    gcp_credentials_block = GcpCredentials.load("nyc-fhvhv-gcs-new")
    gcs_bucket = GcsBucket.load("nyc-fhvhv-gcs-block")
    gf = gcsfs.GCSFileSystem()

    for blob in gcs_bucket.list_blobs('files_parquet'):
       
        gcs_parquet_path = 'gs://'+str(blob).split(',')[0].split(':')[1].strip()+'/'+str(blob).split(',')[1].strip()
        tablename= 'nyc-fhvhv.nyc_fhvhv_tripdetails_zones_raw.'+str(blob).split(',')[1].split('/')[1].strip().replace('.parquet','')
        gcs_bucket.get_directory(from_path=gcs_parquet_path)
        print("\gcs_parquet_path:"+gcs_parquet_path+"\ntable_name:"+tablename+"\n")

        ar_ds = pd.read_parquet(gcs_parquet_path, filesystem= gf)
        load_data_to_bq(ar_ds,tablename,gcp_credentials_block)
        
    gcs_csv = 'gs://nyc-fhvhv_tripdata_csv/files_csv/taxi+_zone_lookup.csv'.strip()
    tablename= 'nyc-fhvhv.nyc_fhvhv_tripdetails_zones_raw.taxi_zone_lookup'

    ar_ds = pd.read_csv(gcs_csv)#, filesystem= gf)
    load_data_to_bq(ar_ds,tablename,gcp_credentials_block)


@task
def load_data_to_bq(dframe,tablename,gcp_credentials_block):
        dframe.to_gbq(
        destination_table=tablename,
        project_id="nyc-fhvhv",
        credentials= gcp_credentials_block.get_credentials_from_service_account(),
        chunksize=500_000,
        if_exists="append"
        )

@flow(name="Parquet to GCS and BQ")
def main():
    print("Downloading Files")
    nycdata_url=f"https://d37ci6vzurychx.cloudfront.net/trip-data/fhvhv_tripdata_2019-07.parquet"
    download_parquetfiles(nycdata_url)
    nycdata_url=f"https://d37ci6vzurychx.cloudfront.net/trip-data/fhvhv_tripdata_2020-07.parquet"
    download_parquetfiles(nycdata_url)
    nycdata_url=f"https://d37ci6vzurychx.cloudfront.net/trip-data/fhvhv_tripdata_2021-07.parquet"
    download_parquetfiles(nycdata_url)
    nycdata_url=f"https://d37ci6vzurychx.cloudfront.net/trip-data/fhvhv_tripdata_2022-07.parquet"
    download_parquetfiles(nycdata_url)
    nycdata_url=f"https://d37ci6vzurychx.cloudfront.net/misc/taxi+_zone_lookup.csv"
    download_parquetfiles(nycdata_url)
    upload_csv_to_gcs()
    upload_parquet_to_gcs()
    extract_data_from_gcs()


if __name__ == '__main__':
    main()
