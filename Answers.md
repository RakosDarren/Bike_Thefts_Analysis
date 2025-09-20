# Ottawa Bike Thefts 2015-2020
## Questions and Answers

An SQL analysis about each bike theft within the City of Ottawa from 2017 to 2020. 

#### What is the total number of thefts?
```sql
SELECT
  count(*) AS total_thefts
FROM
  thefts
```
