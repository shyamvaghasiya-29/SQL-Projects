create database uber;

use uber;

select * from drivers;
select * from rides;
select * from passangers;

#1. What are & how many unique pickup locations are there in the dataset?

select distinct(pickup_location) from rides;

select count(pickup_location) from rides;

select distinct(pickup_location), count(pickup_location) from rides
group by pickup_location;


#2. What is the total number of rides in the dataset?

select * from rides;

select count(ride_id) as total_rides from rides;


#3. Calculate the average ride duration.

select avg(ride_duration) from rides;
select round(avg(ride_duration)) as avg_ride_duration from rides;


#4. list the top 5 drivers based on their total earnings.

select * from drivers
order by earnings desc limit 5;


#5. Calculate the total number of rides for each payment method.

select payment_method, count(ride_id) as no_of_rides from rides
group by payment_method; 


#6. Retrieve rides with a fare amount greater than 20.

select * from rides where fare_amount > 20;


#7. Identify the most common pickup location.

select pickup_location, count(ride_id) from rides
group by pickup_location
order by count(ride_id) desc limit 1;


#8. Calculate the average fare amount.

select round(avg(fare_amount)) from rides;


#9. List the top 10 drivers with the highest average ratings.

select driver_name, avg(rating) from drivers
group by driver_name 
order by avg(rating) desc limit 10;


#10. Calculate the total earnings for all drivers.

select sum(earnings) as total_earnings from drivers;


#11. How many rides were paid using the "Cash" payment method?

select count(ride_id) from rides where payment_method = "cash";


#12. Calculate the number of rides & average ride distance for rides originating from the 'Dhanbad' pickup location.

select count(ride_id) as no_of_ride, round(avg(ride_distance)) as avg_ride_duration, pickup_location from rides
where pickup_location = "dhanbad";


#13. Retrieve rides with a ride duration less than 10 minutes.

select * from rides
where ride_duration < 10;


#14. List the passengers who have taken the most number of rides.

select passenger_id, count(ride_id) from rides 
group by passenger_id
order by count(ride_id) desc
limit 1;


#15. Calculate the total number of rides for each driver in descending order.

select drivers.driver_id, drivers.driver_name, count(rides.ride_id) as no_of_rides
from drivers
inner join rides on drivers.driver_id = rides.driver_id
group by drivers.driver_id,drivers.driver_name 
order by count(rides.ride_id)  desc;


#16. Identify the payment methods used by passengers who took rides from the 'Gandhinagar' pickup location.

select passenger_id, payment_method, pickup_location from rides where pickup_location = "gandhinagar";


#17. Calculate the average fare amount for rides with a ride distance greater than 10.

select avg(fare_amount) from rides 
where ride_distance > 10;


#18. List the drivers in descending order according to their total number of rides.

select * from drivers
order by total_rides desc;


#19. Calculate the percentage distribution of rides for each pickup location.

select pickup_location, count(*) as total_rides, round(count(*) * 100.0 / (select count(*) from rides),2)
as percentage_distribution
from rides
group by pickup_location
order by percentage_distribution desc;


#20. Retrieve rides where both pickup and dropoff locations are the same.

select * from rides
where pickup_location = dropoff_location;


#21. List the passengers who have taken rides from at least 300 different pickup locations.

select passenger_id, count(pickup_location) from rides
group by passenger_id
having count(pickup_location) >= 300;


#22. Calculate the average fare amount for rides taken on weekdays.

 select round(avg(fare_amount), 2) as avg_weekday_fare
from rides
where dayofweek(ride_timestamp) between 2 and 6;



#23. Identify the drivers who have taken rides with distances greater than 19.

select drivers.driver_id,
       drivers.driver_name, 
       rides.ride_distance from rides
rides inner join drivers
on rides.driver_id = drivers.driver_id
where rides.ride_distance > 19;


#24. Calculate the total earnings for drivers who have completed more than 100 rides.

select driver_id, driver_name, sum(earnings) as total_earnings
from drivers where total_rides >100
group by driver_id,driver_name;


#25. Retrieve rides where the fare amount is less than the average fare amount.

select avg(fare_amount) from rides;

select * from rides
where fare_amount < (select avg(fare_amount) from rides);


#26. Calculate the average rating of drivers who have driven rides with both 'Credit Card' and 'Cash' payment methods.

select avg(rating) from drivers
where drivers.driver_id in (select driver_id from rides
where payment_method in ("cash", "credit card") 
group by driver_id
having count(distinct payment_method) = 2);


#27. List the top 3 passengers with the highest total spending.

select * from passangers
order by total_spent desc limit 3;


#28. Calculate the average fare amount for rides taken during different months of the year.

select month(ride_timestamp) Months ,
       monthname(ride_timestamp) Month_Name,
       round(avg(fare_amount),2) AVG_Fareamount 
from rides
group by month(ride_timestamp), monthname(ride_timestamp)
order by month(ride_timestamp);


#29. Identify the most common pair of pickup and dropoff locations.

select pickup_location, dropoff_location, count(ride_id) as total_trips from rides
group by pickup_location, dropoff_location 
order by total_trips desc;


#30. Calculate the total earnings for each driver and order them by earnings in descending order.

select driver_name, sum(earnings) from drivers
group by driver_name
order by sum(earnings) desc;


#31. List the passengers who have taken rides on their signup date.

select passangers.passenger_id,
       passangers.passenger_name,
       passangers.signup_date,
       rides.ride_timestamp
from rides rides inner join passangers
on rides.passenger_id = passangers.passenger_id
where date(passangers.signup_date) = date(rides.ride_timestamp); 


#32. Calculate the average earnings for each driver and order them by earnings in descending order.

select driver_name, avg(earnings) from drivers
group by driver_name
order by avg(earnings) desc;


#33. Retrieve rides with distances less than the average ride distance.

select avg(ride_distance) from rides;
select *from rides
where ride_distance < (select avg(ride_distance) from rides);


#34. List the drivers who have completed the least number of rides.

select driver_id, driver_name, total_rides from drivers 
where total_rides = (select min(total_rides) from drivers);


#35. Calculate the average fare amount for rides taken by passengers who have taken at least 20 rides.

select passangers.passenger_id,
       passangers.passenger_name, 
       avg(rides.fare_amount),
       passangers.total_rides from passangers 
passangers inner join rides 
on passangers.passenger_id = rides.passenger_id
where passangers.total_rides >= 20
group by passangers.passenger_id ,passangers.passenger_name, passangers.total_rides ;


#36. Identify the pickup location with the highest average fare amount.

select pickup_location, avg(fare_amount) from rides
group by pickup_location
order by avg(pickup_location) desc limit 1;


#37. Calculate the average rating of drivers who completed at least 100 rides.

select driver_id, driver_name, avg(rating) from drivers 
where total_rides >=100
group by driver_id,driver_name;


#38. List the passengers who have taken rides from at least 5 different pickup locations.

select passangers.passenger_id,
       passangers.passenger_name,
       count( distinct rides.pickup_location) as different_Pickup from rides
rides inner join passangers on rides.passenger_id = passangers.passenger_id 
group by passangers.passenger_id, passangers.passenger_name  
having count(distinct rides.pickup_location) >=5;


#39. Calculate the average fare amount for rides taken by passengers with ratings above 4.

select passangers.passenger_id,
       passangers.passenger_name, 
       passangers.rating,
       round(avg(rides.fare_amount)) as AVG_Fareamount from passangers 
passangers inner join rides on passangers.passenger_id = rides.passenger_id
where passangers.rating > 4
group by passangers.passenger_id, passangers.passenger_name, passangers.rating; 


#40. Retrieve rides with the shortest ride duration in each pickup location.

select pickup_location , min(ride_duration) from rides
group by pickup_location
order by min(ride_duration) asc;  


#41. List the drivers who have driven rides in all pickup locations.

select drivers.driver_id, drivers.driver_name
from drivers
inner join rides on drivers.driver_id = rides.driver_id
group by drivers.driver_id, drivers.driver_name
having count(distinct rides.pickup_location) = (select count(distinct pickup_location)from rides);


#42. Calculate the average fare amount for rides taken by passengers who have spent more than 300 in total.

 select avg(fare_amount), passangers.passenger_name from rides
 rides inner join passangers on rides.passenger_id = passangers.passenger_id
 group by passangers.passenger_id, passangers.passenger_name
 having sum(rides.fare_amount) > 300;

 
#43. List the bottom 5 drivers based on their average earnings.

select driver_id, driver_name, avg(earnings) as avg_earnings from drivers
group by driver_name, driver_id
order by avg_earnings asc limit 5;


#44. Calculate the sum fare amount for rides taken by passengers who have taken rides in different payment methods.

select passenger_id, round(sum(fare_amount),2) as total_fare from rides 
group by passenger_id
having count(distinct payment_method) > 1;


#45. Retrieve rides where the fare amount is significantly above the average fare amount.

select * from rides
where fare_amount > (select avg(fare_amount) from rides);

#46. List the drivers who have completed rides on the same day they joined.

select distinct d.driver_id, d.driver_name, d.join_date, r.ride_timestamp FROM drivers as d
inner join rides  as r
on d.driver_id = r.driver_id
where d.join_date = r.ride_timestamp;

#47. Calculate the average fare amount for rides taken by passengers who have taken rides in different payment methods.

select passenger_id, round(avg(fare_amount), 2) as avg_fare from rides
group by passenger_id
having count(distinct payment_method) > 1;

#48. Identify the pickup location with the highest percentage increase in average fare amount compared to the overall average fare.

select pickup_location, round(((avg(fare_amount) -  (select avg(fare_amount) from rides))
        / (select avg(fare_amount) from rides)) * 100, 2) as percentage_increase
from rides
group by pickup_location
order by percentage_increase desc
limit 1;


#49. Retrieve rides where the dropoff location is the same as the pickup location.

select * from rides
where pickup_location = dropoff_location;


#50. Calculate the average rating of drivers who have driven rides with varying pickup locations.

select round(avg(d.rating), 2) as avg_driver_rating from drivers as d
inner join rides as r
on d.driver_id = r.driver_id
group by d.driver_id
having count(distinct r.pickup_location) > 1;