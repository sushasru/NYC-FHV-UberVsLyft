resource "google_storage_bucket" "nyc_fhvhv_gcs" {
    name = "nyc-fhvhv_tripdata_csv"
    location = var.google_region
    storage_class = "STANDARD"
    uniform_bucket_level_access =  true
}