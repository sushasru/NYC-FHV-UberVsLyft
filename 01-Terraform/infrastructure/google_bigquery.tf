resource "google_bigquery_dataset" "nyc_fhvhv_BQuery"{
    dataset_id =  "nyc-fhvhv_tripdetails_zones"
    friendly_name =  "TripDetailsAndZones"
    description = "This is the Bigquery dataset with trip details and nyc taxi zones combined"
    location = var.google_region
}

resource "google_bigquery_table" "TripDetailsAndZones" {
    dataset_id =  google_bigquery_dataset.nyc_fhvhv_BQuery.dataset_id
    table_id =  "FinalDataSet"
}