DROP TABLE IF exists thefts;
CREATE TABLE thefts (
  ID INT PRIMARY KEY,
  Theft_Year INT,
  Reported_Date DATETIME,
  Reported_Time DATETIME,
  Weekday VARCHAR(100),
  Occurrence_Date DATETIME,
  Occurrence_Time DATETIME,
  Location VARCHAR(255),
  B_Status VARCHAR(100),
  B_Value VARCHAR(100),
  B_Make VARCHAR(100),
  B_Model VARCHAR(100),
  B_Frame VARCHAR(100),
  B_Type VARCHAR(100),
  B_Colour VARCHAR(100),
  B_Speed VARCHAR(100),
  Neighborhood VARCHAR(100),
  X_Cord DECIMAL(12,4),
  Y_Cord DECIMAL(12,4)
);

 LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Bike_Thefts.csv'
 INTO TABLE thefts 
 FIELDS TERMINATED BY ','
 OPTIONALLY ENCLOSED BY '"'
 IGNORE 1 LINES
 (@dummy, @dummy, @dummy, ID, Theft_Year, @Reported_DateRAW, @Reported_TimeRAW, Weekday, @Occurrence_DateRAW, @Occurrence_TimeRAW, @dummy, Location, @dummy, B_Status, B_Value, B_Make, B_Model, B_Type, B_Frame, B_Colour, B_Speed, Neighborhood, @dummy, @dummy, @dummy, @dummy, X_Cord, Y_Cord)  
 
 SET 
 Reported_Date = STR_TO_DATE(SUBSTRING_INDEX(@Reported_DateRAW, ' ', 1), '%Y/%m/%d %H:%i:%s'),
 Reported_Time = STR_TO_DATE(SUBSTRING_INDEX(@Reported_TimeRAW, ' ', 1), '%Y/%m/%d %H:%i:%s'),
 Occurrence_Date = STR_TO_DATE(SUBSTRING_INDEX(@Occurrence_DateRAW, ' ', 1), '%Y/%m/%d %H:%i:%s'),
 Occurrence_Time = STR_TO_DATE(SUBSTRING_INDEX(@Occurrence_TimeRAW, ' ', 1), '%Y/%m/%d %H:%i:%s')