-- Cyclistic Bike-Share Analysis Queries
-- Author: Carlos Bravo
-------------------------------------------
-- Ride Count By User Type and Day of Week
-------------------------------------------
SELECT
	member_casual,
	DAYNAME(started_at) AS day,
    COUNT(ride_id) AS ride_count
FROM
	cyclistic_year_view
GROUP BY
	member_casual, DAYNAME(started_at)
ORDER BY
	member_casual,
    ride_count DESC

---------------------------------------------
-- Average Ride Duration by User Type
---------------------------------------------
SELECT
    member_casual,
    AVG(ride_length) AS avg_ride_length
FROM
    cyclistic_year_view
GROUP BY
    member_casual;

---------------------------------------------
-- Bike Type Usage Distribution by User Type
---------------------------------------------
SELECT
    member_casual,
    rideable_type,
    COUNT(*) AS ride_count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY member_casual),
        2
    ) AS percentage
FROM
    cyclistic_year_view
GROUP BY
    member_casual,
    rideable_type;

-----------------------------------------------
-- Most Popular Day of the Week by User Type
-----------------------------------------------
WITH daily_rides AS (
    SELECT
        member_casual,
        DAYNAME(started_at) AS day,
        COUNT(*) AS ride_count
    FROM cyclistic_year_view
    GROUP BY member_casual, day
),
ranked_days AS (
    SELECT
        member_casual,
        day,
        ride_count,
        ROW_NUMBER() OVER (
            PARTITION BY member_casual
            ORDER BY ride_count DESC
        ) AS rn
    FROM daily_rides
)
SELECT
    member_casual,
    day,
    ride_count
FROM ranked_days
WHERE rn = 1;

------------------------------------------------
-- Number of Rides by User Type and Day of Week
------------------------------------------------
SELECT
    member_casual,
    DAYNAME(started_at) AS day_of_week,
    COUNT(*) AS ride_count
FROM cyclistic_year_view
GROUP BY member_casual, DAYNAME(started_at)
ORDER BY member_casual, ride_count DESC;

------------------------------------------------
-- Average Ride Duration (Seconds) by User Type
------------------------------------------------
SELECT
    member_casual,
    AVG(ride_length) AS avg_length
FROM
    cyclistic_year_view
GROUP BY
    member_casual;

-------------------------------------------------
-- Number of Rides by User Type and Day of Week
-------------------------------------------------
SELECT
	member_casual,
	DAYNAME(started_at) AS day,
    COUNT(ride_id) AS ride_count
FROM
	cyclistic_year_view
GROUP BY
	member_casual, DAYNAME(started_at)
ORDER BY
	member_casual,
    ride_count DESC

-------------------------------------------------
-- Number of Rides by Hour of Day
-------------------------------------------------
SELECT
    COUNT(*) AS ride_count,
    HOUR(started_at) AS hour
FROM
    cyclistic_year_view
GROUP BY
    hour
ORDER BY
    hour;

------------------------------------------------
-- Number of Rides by User Type and Month
------------------------------------------------
SELECT
    member_casual,
    MONTH(started_at) AS month,
    COUNT(*) AS ride_count
FROM
    cyclistic_year_view
GROUP BY
    member_casual,
    MONTH(started_at)
ORDER BY
    member_casual,
    ride_count DESC;






