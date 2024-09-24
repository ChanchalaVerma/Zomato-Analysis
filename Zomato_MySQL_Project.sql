SELECT * FROM zomato_maintable;
-- Q1. Name of the countries and number of resturants affiliated with Zomato
SELECT zomato_maintable.CountryCode AS Country_Code, country_table.Countryname AS Countryname, COUNT(RestaurantID) AS Number_of_Restaurants
		FROM zomato_maintable INNER JOIN country_table
        WHERE country_table.CountryCode =zomato_maintable.CountryCode
        GROUP BY Country_Code, Countryname
        ORDER BY Country_Code, Countryname;

-- Q2. Calendar Table ---------------------------
SELECT YEAR (Datekey_Opening) AS Year,
		MONTH(Datekey_Opening) AS Month,
        MONTHNAME(Datekey_Opening) AS MonthName,
        CONCAT (YEAR(Datekey_Opening), " - ",MONTHNAME(Datekey_Opening)) AS YYYY_MM,
        WEEKDAY (Datekey_Opening) AS Weekday,
        DAYNAME (Datekey_Opening) AS Day,
CASE WHEN MONTH(Datekey_Opening) IN (1, 2, 3) THEN "Q-1"
	WHEN MONTH(Datekey_Opening) IN (4, 5, 6) THEN "Q-2"
	WHEN MONTH(Datekey_Opening) IN (7, 8, 9) THEN "Q-3"
	ELSE "Q-4" END AS Quater,
CASE WHEN MONTH(Datekey_Opening) = 1 THEN "FM-10"
	WHEN MONTH(Datekey_Opening) = 2 THEN "FM-11"
    WHEN MONTH(Datekey_Opening) = 3 THEN "FM-12"
    WHEN MONTH(Datekey_Opening) = 4 THEN "FM-1"
    WHEN MONTH(Datekey_Opening) = 5 THEN "FM-2"
    WHEN MONTH(Datekey_Opening) = 6 THEN "FM-3"
    WHEN MONTH(Datekey_Opening) = 7 THEN "FM-4"
    WHEN MONTH(Datekey_Opening) = 8 THEN "FM-5"
    WHEN MONTH(Datekey_Opening) = 9 THEN "FM-6"
    WHEN MONTH(Datekey_Opening) = 10 THEN "FM-7"
    WHEN MONTH(Datekey_Opening) = 11 THEN "FM-8"
    WHEN MONTH(Datekey_Opening) = 12 THEN "FM-9"
    END AS Financial_month,
CASE WHEN MONTH(Datekey_Opening) IN (4, 5, 6) THEN "FQ-1"
	WHEN MONTH(Datekey_Opening) IN (7, 8, 9) THEN "FQ-2"
	WHEN MONTH(Datekey_Opening) IN (10, 11, 12) THEN "FQ-3"
	WHEN MONTH(Datekey_Opening) IN (1, 2, 3) THEN "FQ-4" 
    END AS Finacial_Quater
    FROM zomato_maintable;
# ---------------------------------------------------------------------------------------------
-- Q3. Numbers of Restaurants based on Country and City .
SELECT country_table.Countryname AS Country, 
		zomato_maintable.City AS City, 
        COUNT(RestaurantID) AS Number_of_Restaurants
	FROM zomato_maintable INNER JOIN country_table
    ON zomato_maintable.CountryCode = country_table.CountryCode
    GROUP BY Country, City;
# ---------------------------------------------------------------------------------------------
-- Q4. Numbers of Restaurants opening based on Year , Quarter , Month.
SELECT YEAR(Datekey_Opening) AS Year,
		QUARTER(Datekey_Opening) AS Quarter,
        MONTHNAME(Datekey_Opening) AS Month,
        COUNT(RestaurantID) AS Number_of_Restaurants
	FROM zomato_maintable
    GROUP BY Year, Quarter, Month
    ORDER BY Year, Quarter, Month;
# ----------------------------------------------------------------------------------------
-- Q5. Count of Restaurants based on Average Ratings.
SELECT CASE WHEN RATING <=1 THEN "0 TO 1"
			WHEN RATING <=2 THEN "1 TO 2"
            WHEN RATING <=3 THEN "2 TO 3"
            WHEN RATING <=4 THEN "3 TO 4"
            WHEN RATING > 4 THEN "4 TO 5"
            END AS Ratings,
            COUNT(RestaurantID) AS Number_of_Restaurants
		FROM zomato_maintable
        GROUP BY Ratings
        ORDER BY Ratings;
# ------------------------------------------------------------------------------------------------------------------------
-- Q6. Create buckets based on Average Price of reasonable size and find out how many restaurants falls in each buckets.
SELECT CASE WHEN  Average_Cost_for_Two <= 500 THEN "0 - 500"
	WHEN  Average_Cost_for_Two <= 1000 THEN "501 - 1000"
	WHEN  Average_Cost_for_Two <= 2000 THEN "1001 - 2000"
    WHEN  Average_Cost_for_Two <= 3000 THEN "2001 - 3000"
    WHEN  Average_Cost_for_Two <= 4000 THEN "3001 - 4000"
    WHEN  Average_Cost_for_Two <= 10000 THEN "4001 - 10000"
    ELSE "10001+" END Cost_Range,
COUNT(RestaurantID) AS Number_of_Restaurants
 FROM zomato_maintable
 GROUP BY Cost_Range 
 ORDER BY Cost_Range;
# ----------------------------------------------------------------------------------------------------------------------
-- Q7.Percentage of Restaurants based on "Has_Table_booking".

SELECT Has_Table_booking, ROUND(COUNT(Has_Table_booking)/100,2) As Percent_of_Restaurants
	FROM zomato_maintable
    GROUP BY Has_Table_booking;
# -------------------------------------------------------------------------------------------------------------------------
-- Q8.Percentage of Restaurants based on "Has_Online_delivery".

SELECT Has_Online_delivery, ROUND(COUNT(Has_Online_delivery)/100,2) As Percent_of_Restaurants
	FROM zomato_maintable
    GROUP BY Has_Online_delivery;
    
# -------------------------------------------------
-- Details of the top 10 restaurants on the basis of rating 
SELECT zomato_maintable.`Resturant Name` , country_table.Countryname AS Country, MAX(Rating) AS Rating, zomato_maintable.City ,zomato_maintable.locality
FROM zomato_maintable INNER JOIN country_table
WHERE country_table.CountryCode = zomato_maintable.CountryCode
GROUP BY `Resturant Name`, Country, City, locality
ORDER BY Rating DESC
LIMIT 10;
