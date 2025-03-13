select* from maindata 
ALTER TABLE Maindata ADD COLUMN Date_Field DATE;

UPDATE maindata
SET Date_field = STR_TO_DATE(CONCAT(years, '-', months, '-', days), '%Y-%m-%d');
select Date_field from maindata 

#Q1.A. Year

SELECT Year(Date_Field) FROM Maindata;

# Q1.B. Month No
 SELECT Month(Date_Field) as Month_No FROM Maindata;
 #Qc Month name 
  select months, monthname(date_field) as month_name from maindata;
  
 # Q1.D Quarter
 SELECT MONTHNAME(Date_Field) as Month_Name, QUARTER(Date_Field) as Quarter FROM Maindata; 
 
 #Q1e year-month 
  select date_format(date_field, '%y-%b') as yearmonth from maindata;
   -- Q1f week day no 
   SELECT DAYOFWEEK(Date_Field) as Weekday_No FROM Maindata;
   
   #Q1g weekdayName
   select dayname(date_field) as weekday_name from maindata;
   
  #Q1h Financial quarter
SELECT MONTH(Date_Field),
  CASE
    WHEN MONTH(Date_Field) BETWEEN 4 AND 6 THEN 'fQ1'
    WHEN MONTH(Date_Field) BETWEEN 7 AND 9 THEN 'fQ2'
    WHEN MONTH(Date_Field) BETWEEN 10 AND 12 THEN 'fQ3'
    ELSE 'fQ4'
  END AS FinancialQuarter
FROM Maindata;

#Q1j financialmonth
select monthname(date_field),
CASE
    WHEN MONTH(Date_Field) >= 4 THEN MONTH(Date_Field) - 3
    ELSE MONTH(Date_Field) + 9
  END AS FinancialMonth 
  from maindata;
  
 ## Q2. Find the load Factor percentage on a yearly , Quarterly , Monthly basis ( Transported passengers / Available seats)

SELECT YEAR(Date_Field) AS Year, QUARTER(Date_Field) AS Quarter, MONTH(Date_Field) AS Month,
  SUM(Transported_Passengers) AS Total_Transported_pass,
  SUM(Available_Seats) AS Total_Available_seats,
(SUM(Transported_Passengers) / SUM(Available_Seats)) * 100 AS Load_Factor_Percentage
FROM Maindata GROUP BY Year, Quarter, Month ORDER BY Year, Quarter, Month; 

## Q3. The load Factor percentage on a Carrier Name basis ( Transported passengers / Available seats)

SELECT Carrier_Name,
  SUM(Transported_Passengers) AS Total_Transported_passengers,
  SUM(Available_Seats) AS Total_Available_seats,
  (SUM(Transported_Passengers) / SUM(Available_Seats)) * 100 AS Load_Factor_Percentage
FROM Maindata GROUP BY Carrier_Name;

#Q4 top 10ncarrier name as per passenger preference 
select carrier_Name, count(transported_passengers) from maindata
group by carrier_name 
order by count(Transported_Passengers) desc limit 10 ;

#Q5  Display top Routes ( from-to City) based on Number of Flights.

select fromtocity as top_route,
SUM(Departures_Scheduled + Departures_Performed) AS No_Of_Flights
    FROM Maindata
    GROUP BY top_Route 
    ORDER BY No_Of_Flights DESC LIMIT 5;
    
#Q6 loadfactor on weekday and weekend

ALTER TABLE maindata
ADD COLUMN day_type VARCHAR(10);

UPDATE maindata
SET day_type = CASE 
    WHEN WEEKDAY(date_field) BETWEEN 0 AND 4 THEN 'Weekday'
    ELSE 'Weekend' 
END;
SELECT
    day_type,
    COUNT(*) AS total_records,
    (COUNT(*) / (SELECT COUNT(*) FROM maindata)) * 100 AS load_factor_percentage
FROM
    maindata
GROUP BY
    day_type;
    
#Q7 Identify number of flights based on Distance groups
select * from `distance groups`;
SELECT count(Departures_Performed), `Distance Interval` FROM maindata JOIN `distance groups` ON 
		(maindata.`%Distance Group ID`=`distance groups` .`ï»¿%Distance Group ID`)
        group by `Distance Interval` ;
	 

