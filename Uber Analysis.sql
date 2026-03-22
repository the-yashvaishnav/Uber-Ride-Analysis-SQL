use ft_a;
show databases;
show tables;

select * from drivers;
select * from passangers;
select * from rides;

-- Basic Level:

-- 1. What are & how many unique pickup locations are there in the dataset?

   select  distinct(pickup_location) from rides;

   select count(distinct pickup_location) from rides;

-- 2.What is the total number of rides in the dataset?

  select count(*) from rides;


-- 3.Calculate the average ride duration.
  
  select avg(ride_duration) from rides;
  
  
-- 4.List the top 5 drivers based on their total earnings.
  
  select driver_id , sum(earnings) from drivers
  group by driver_id
  order by sum(earnings) desc limit 5;
  
  
-- 5 Calculate the total number of rides for each payment method.
  
  select payment_method,count(ride_id) from rides
  group by payment_method;
  
  
-- 6.Retrieve rides with a fare amount greater than 20.
  
  select * from rides
  where fare_amount>20;
  
  
-- 7.Identify the most common pickup location.

  SELECT pickup_location, COUNT(*) AS ride_count 
  FROM rides 
  GROUP BY pickup_location 
  ORDER BY ride_count DESC LIMIT 1;
  
  
-- 8.Calculate the average fare amount.
  
  select avg(fare_amount) from rides;
  
  
-- 9.List the top 10 drivers with the highest average ratings.
  
  select driver_id, avg(rating) from drivers
  group by driver_id 
  order by avg(rating) desc limit 10;
  
  
-- 10.Calculate the total earnings for all drivers.
  
  select sum(earnings) from drivers;
  
  
-- 11.How many rides were paid using the "Cash" payment method?
  
  select count(*) from rides
  where payment_method="cash";
  
--    or which
  
  select  * from rides
  where payment_method="cash";
  
  
-- 12.Calculate the number of rides & average ride distance for rides originating 
-- from the 'Dhanbad' pickup location.
  
  select pickup_location , count(*) ,avg(ride_distance) from rides
  where pickup_location="dhanbad";
  
  
-- 13.Retrieve rides with a ride duration less than 10 minutes.
  
  select * from rides
  where ride_duration<10;
  
  
-- 14.List the passengers who have taken the most number of rides.
  
  select passenger_id, count(ride_id) from rides
  group by passenger_id
  order by count(ride_id) desc limit 1;
  
  
-- 15.Calculate the total number of rides for each driver in descending order.
  
  select driver_id, count(total_rides) from drivers
  group by driver_id 
  order by count(total_rides) desc limit 1;
  
  
  
-- 16.Identify the payment methods used by passengers who took rides 
-- from the 'Gandhinagar' pickup location. 
  
  select distinct(payment_method) from rides
  where pickup_location="gandhinagar";
  
-- 17.Calculate the average fare amount for rides with a ride distance greater than 10.
  
  select avg(fare_amount) from rides
  where ride_distance>10;
  
  
-- 18.List the drivers in descending order according to their total number of rides.
  
  select driver_id,total_rides from drivers 
  order by total_rides desc;
  
  
-- 19: Calculate the percentage distribution of rides for each pickup location.
SELECT pickup_location, COUNT(*) AS ride_count, ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM rides), 2) AS percentage 
FROM rides
GROUP BY pickup_location
order by percentage desc;

select pickup_location, count(pickup_location) from rides group by pickup_location;
select pickup_location, count(*) as ride_count from rides group by pickup_location ;



-- 20. Retrieve rides where both pickup and dropoff locations are the same.
   
 select * from rides
 where pickup_location = dropoff_location;
 
 
 
 
 
--  Intermediate Level:     

                 

-- 1. List the passengers who have taken rides from at least 300 different pickup locations.
 
 select passenger_id , count(distinct pickup_location) from rides 
 group by passenger_id
 having count(distinct pickup_location) >=300;
 
 
-- 2.Calculate the average fare amount for rides taken on weekdays.
 
 select avg(fare_amount) from rides 
 WHERE DAYOFWEEK(STR_TO_DATE(ride_timestamp, '%m/%d/%Y %H:%i'))>5;


-- 3.Identify the drivers who have taken rides with distances greater than 19

 select distinct driver_id ,ride_distance from rides 
 where ride_distance>19;


-- 4.Calculate the total earnings for drivers who have completed more than 100 rides.
 
select * from drivers;

SELECT driver_id, SUM(earnings) AS total_earnings
FROM drivers
WHERE driver_id IN (SELECT driver_id FROM rides GROUP BY driver_id HAVING COUNT(*) > 100)
GROUP BY driver_id;

--                     or 

select rides.ride_id ,drivers.driver_id, count(drivers.driver_id), sum(drivers.earnings) as total_earning
from drivers inner join rides 
on drivers.driver_id = rides.driver_id
group by drivers.driver_id
having count(drivers.driver_id)>100;
  


-- 5.Retrieve rides where the fare amount is less than the average fare amount.

select * from rides;
where fare_amount<(select avg(fare_amount) from rides);


SELECT AVG(fare_amount) FROM rides;

 
-- 6.Calculate the average rating of drivers who have driven rides 
-- with both 'Credit Card' and 'Cash' payment methods.

select drivers.driver_id, avg(rating) from 
drivers inner join rides 
on drivers.driver_id=rides.driver_id
where rides.payment_method in ("credit card","cash")
group by drivers.driver_id
having count(distinct rides.payment_method)=2;


 

#Q7: List the top 3 passengers with the highest total spending.
select p.passenger_id ,p.passenger_name,sum(r.fare_amount) as total_spending
from passangers p join  rides r on p.passenger_id = r.passenger_id
group by p.passenger_id , p.passenger_name
order by total_spending desc limit 3;


-- --8.Calculate the average fare amount for rides taken during different months of the year.




-- 9.Identify the most common pair of pickup and dropoff locations.

select pickup_location,dropoff_location ,count(*) 
from rides
group by pickup_location,dropoff_location;




-- 10.Calculate the total earnings for each driver and 
-- order them by earnings in descending order.

select driver_id , sum(earnings) from drivers
group by driver_id
order by sum(earnings) desc;


select * from passangers;
#11.List the passengers who have taken rides on their signup date.
select passangers.passenger_id,passangers.passenger_name
from passangers
join rides 
on passangers.passenger_id=rides.passenger_id
where date(passangers.signup_date)=date(rides.ride_timestamp);

 



#12.Calculate the average earnings for each driver and 
#order them by earnings in descending order.

select driver_id , avg(earnings) from drivers
group by driver_id
order by avg(earnings) desc;



#13.Retrieve rides with distances less than the average ride distance.

select * from rides;

select ride_id,avg(ride_distance) from rides 
where ride_distance<(select avg(ride_distance) from rides)
group by ride_id;

select avg(ride_distance) from rides;


#14.List the drivers who have completed the least number of rides.
 
select driver_name,count(driver_id) 
from drivers
group by driver_id,driver_name 
order by count(driver_id) asc;

#15.Calculate the average fare amount for rides taken 
#by passengers who have taken at least 20 rides.

select avg(fare_amount) from rides
where passenger_id in (select passenger_id from rides 
group by passenger_id having count(*)>=20);


 #16 Identify the pickup location with the highest average fare amount.

select pickup_location ,avg(fare_amount) from rides
group by pickup_location
order by avg(fare_amount) desc limit 1;



#17.Calculate the average rating of drivers who completed at least 100 rides.
select * from drivers;

select avg(rating) from drivers
where driver_id in (select driver_id from rides
group by driver_id having count(*)>=100);

-- or 

select drivers.driver_name,drivers.driver_id ,avg(rating) from 
drivers inner join rides
on drivers.driver_id = rides.driver_id
group by driver_id,driver_name
having count(*)>=100;


#18.List the passengers who have taken rides from at least 5 different pickup locations.
select * from rides;


SELECT passenger_id, COUNT(DISTINCT pickup_location) AS distinct_locations
FROM rides
GROUP BY passenger_id
HAVING distinct_locations >= 300;

#19.Calculate the average fare amount for rides taken by passengers with ratings above 4.
select passangers.passenger_id,passangers.rating,avg(fare_amount) from 
passangers inner join rides
on passangers.passenger_id=rides.passenger_id
where rating>4
group by passenger_id,passangers.rating;

select * from passangers;


 #20.Retrieve rides with the shortest ride duration in each pickup location.

select * from rides;

select * from rides;
select pickup_location , min(ride_duration) from rides
group by pickup_location
order by min(ride_duration) asc;




#Advanced Level:

#1.List the drivers who have driven rides in all pickup locations.

select driver_id,driver_name from drivers
where driver_id not in (select distinct driver_id
from rides 
where pickup_location not in (select distinct pickup_location from rides));

#2.Calculate the average fare amount for rides taken 
#by passengers who have spent more than 300 in total.

select * from rides;
select * from passangers;


select rides.passenger_id,total_spent,avg(fare_amount)from 
rides join passangers
on passangers.passenger_id = rides.passenger_id
where passangers.total_spent>=300
group by rides.passenger_id,total_spent;


#3.List the bottom 5 drivers based on their average earnings.

select driver_id,driver_name,avg(earnings) as total_earning from drivers
group by driver_id,driver_name
order by total_earning asc limit 5;


select * from drivers;



#4.Calculate the sum fare amount for rides taken by 
#passengers who have taken rides in different payment methods.
select * from rides;

select sum(fare_amount) from rides
where passenger_id in (select passenger_id from rides 
group by passenger_id 
having count(distinct payment_method)>1
);


#5Retrieve rides where the fare amount is significantly above the average fare amount.

select avg(fare_amount) from rides;

select * from rides 
where fare_amount> (select  avg(fare_amount) from rides);



#6.List the drivers who have completed rides on the same day they joined.

select drivers.driver_id,drivers.driver_name from
drivers join rides on 
drivers.driver_id =rides.driver_id
where date(drivers.join_date) = date(rides.ride_timestamp);

select * from drivers;


#7.Calculate the average fare amount for rides taken by passengers 
#who have taken rides in different payment methods.

select * from rides;

select avg(fare_amount) from rides
where passenger_id in (select passenger_id from rides 
group by passenger_id 
having count(distinct payment_method)>1
);


#8.Identify the pickup location with the highest percentage increase 
#in average fare amount compared to the overall average fare.

SELECT pickup_location, AVG(fare_amount) ,
(AVG(fare_amount) - (SELECT AVG(fare_amount) from rides)) * 100.0 / 
(SELECT AVG(fare_amount)
FROM rides_date)
FROM rides_date
GROUP BY pickup_location
ORDER BY percentage_increase desc;
LIMIT 1;



#9.Retrieve rides where the dropoff location is the same as the pickup location.

select * from rides 
where dropoff_location=pickup_location;

select * from rides;

#10.Calculate the average rating of drivers who have driven rides with 
#varying pickup locations.

select avg(rating) 
from ( SELECT AVG(drivers.rating) as rating FROM 
drivers join rides 
on drivers.driver_id=rides.driver_id
group by drivers.driver_id 
having count(distinct rides.pickup_location)> 1
)as sub;









  
  