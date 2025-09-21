# Ottawa Bike Thefts 2017-2022
## Questions and Answers

An SQL analysis about each bike theft within the City of Ottawa from 2017 to 2022. 

#### What is the total number of thefts?
```sql
SELECT
  count(*) AS total_thefts
FROM
  thefts
```

total_thefts|
-------------|
8709|

#### What is the earliest and latest date of recorded thefts?
```sql
SELECT
  min(reported_date) AS earliest_date,
  max(reported_date) AS latest_date
FROM
  thefts
```

earliest_date|latest_date|
-------------|-----------|
2017-01-09|2022-12-24|

#### What is the number of reported thefts per year?
```sql
SELECT
  theft_year AS theft_year,
  count(*) AS theft_count
FROM
  thefts
GROUP BY
  theft_year
ORDER BY
  theft_year DESC
```
theft_year|theft_count|
----|------|
2022|1818|
2021|1260|
2020|1303|
2019|1409|
2018|1547|
2017|1372|

#### What month had the most amount of thefts?
```sql
SELECT
  MONTHNAME(Occurrence_Date) AS theft_month,
  count(*) AS theft_count
FROM
  thefts
GROUP BY
  MONTHNAME(Occurrence_Date)
ORDER BY
  theft_count DESC
```
theft_month|theft_count|
-----------|-----------|
July|1515|
June|1368|
August|1336|
September|1190|
May|1028|
October|811|
April|523|
November|368|
March|205|
December|165|
January|116|
Febuary|84|

#### What days had the most amount of thefts?
```sql
SELECT
  theft_day,
  theft_count,
  DENSE_RANK() over (ORDER BY theft_count DESC) AS date_rank
FROM
  (SELECT 
  DATE_FORMAT(Occurrence_Date, '%M %e %Y') AS theft_day, 
  count(*) AS theft_count 
  FROM 
  thefts 
  GROUP BY 
  Occurrence_Date) AS sub
ORDER BY
  theft_count DESC
  LIMIT 10
```
theft_day|theft_count|date_rank|
---------|-----------|---------|
August 24 2022|25|1|
June 24 2019|24|2|
June 12 2019|24|2|
June 19 2018|24|2|
August 16 2022|23|3|
July 10 2018|23|3|
July 1 2018|23|3|
May 19 2022|21|4|
June 15 2018|21|4|
July 31 2022|20|5|

#### What is the average time between reported thefts and actual thefts (hours)?
```sql
SELECT
  AVG(DAY(Reported_Date) - DAY(Occurrence_Date)) * 24 AS avg_hours_btw
FROM
  thefts
```
avg_hours_btw|
-------------|
8.1626|

#### What are the top 10 neighboorhoods with the most thefts?
```sql
SELECT
  Neighborhood as neightborhood,
  theft_count,
  DENSE_RANK() over (ORDER BY theft_count DESC) AS neighborhood_rank
FROM
  (SELECT 
  Neighborhood, 
  count(*) AS theft_count 
  FROM 
  thefts 
  GROUP BY 
  Neighborhood) AS sub
ORDER BY
  theft_count DESC
  LIMIT 10
```
neighborhood|theft_count|neighborhood_rank|
------------|-----------|---------|
Centretown|1761|1|
Sandy Hill|1034|2|
Glebe - Dows Lake|559|3|
Byward Market|400|4|
Hintonburg|310|5|
West Centertown|287|6|
Overbrook - McArthur|247|7|
Westboro|207|8|
Laurentian|192|9|
Island Park|192|9|

#### Where do bikes most often get stolen?
```sql
SELECT
  Location as location,
  theft_count,
  DENSE_RANK() over (ORDER BY theft_count DESC) AS location_rank
FROM
  (SELECT 
  Location, 
  count(*) AS theft_count 
  FROM 
  thefts 
  GROUP BY 
  Location) AS sub
ORDER BY
  theft_count DESC
  LIMIT 10
```
location|theft_count|location_rank|
--------|-----------|---------|
Single Home/House|1912|1|
Commercial/Corporate Places|1752|2|
Streets,Roads,Hightways|938|3|
Parking Lots|917|4|
Dwelling Unit(Town Homes)|540|5|
Universities/Colleges|453|6|
Open Areas|446|7|
Private Property Structures|446|7|
Non Commercial/Government Building|243|8|
Schools during school hours|209|9|

#### What types of bikes are most stolen and their value?
```sql
SELECT
  B_Type AS bike_type,
  count(*) AS theft_count,
  ROUND(AVG(B_Value), 0) as avg_bike_value
FROM
  thefts
WHERE
  B_type != 'N/A'
GROUP BY
  bike_type
ORDER BY
  theft_count DESC
```
bike_type|theft_count|avg_bike_value|
---------|-----------|--------------|
Mountain|2798|668|
Hybrid|2543|687|
Regular|1120|598|
Racer|665|1288|
Touring|332|853|
BMX|134|444|
Tricycle|19|805|
Tandem|7|857|

#### How many bikes were recovered VS remain stolen?
```sql
SELECT
  B_Status AS bike_status,
  count(*) AS theft_count
FROM
  thefts
WHERE
  B_Status != 'N/A'
GROUP BY
  bike_status
ORDER BY
  theft_count DESC
```
bike_status|theft_count|
-----------|-----------|
Stolen|8014|
Recovered|325|
Found|61|
Seized|27|
Lost|7|
Conterfeit|4|


