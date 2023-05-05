# NYC-FHV-UberVsLyft
Comparison of Uber and Lyft data for the month of July for the years 2019 - 2022

<h2>Problem Description - Uber vs Lyft - Trend and Impact of COVID</h2>
Use High Volume For-Hire Vehicle trip records for the month of July from 2019 to 2022 to visualize how COVID affected Uber and Lyft ridership. 

The project is to help ride sharing companies assess capacity and monitor the rider shipt trends in the post covid era. Intelligence gleaned from the findings will help the respective marketing departments run targetted campaigns. 

<h2>Technology Stack</h2>
<ul>
<li>Terraform - IaC - for creating Google Cloud Storage and BigQuery components</li>
<li>Prefect - For Workflow Orchestration to extract data from NYC trip-record website, load it to GCS and subsequently to BigQuery.</li>
<li>DBT - For transforming raw data including data cleanup and filtering out noise to make it ready for visualization</li>
<li>Google Cloud Storage - For storing parquet files from NYC trip-record website.</li>
<li>BigQuery - For storing data in support of querying and visualization</li>
<li>Google Looker Studio - For data visualization</li>
</ul>

<h2>Dashboard</h2>
<a href="https://lookerstudio.google.com/reporting/1027fd17-6bd4-4c0d-a98a-d318f0de86c7">Click here for the dashboard </a>
