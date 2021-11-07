create schema TravelOnTheGo;

use TravelOnTheGo;

create table PASSENGER (passenger_id int primary key, passenger_name varchar(50), category varchar(50), gender char, boarding_city
varchar(50), destination_city varchar(50), distance int, bus_type varchar(50));
alter table PASSENGER rename to passenger;
create table price (bus_type varchar(50), distance int, price int);

insert into passenger values (1, 'Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper');
insert into passenger values (2, 'Amol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting');
insert into passenger values (3, 'Pallavi', 'AC', 'F', 'Panji', 'Bengaluru', 600, 'Sleeper');
insert into passenger values (4, 'Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper');
insert into passenger values (5, 'Udit', 'Non-AC', 'M', 'Trivandrum', 'Panji', 1000, 'Sleeper');
insert into passenger values (6, 'Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting');
insert into passenger values (7, 'Hemant', 'Non-AC', 'M', 'Panji', 'Mumbai', 700, 'Sleeper');
insert into passenger values (8, 'Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting');
insert into passenger values (9, 'Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');

insert into price values ('Sleeper', 350, 770);
insert into price values ('Sleeper', 500, 1100);
insert into price values ('Sleeper', 600, 1320);
insert into price values ('Sleeper', 700, 1540);
insert into price values ('Sleeper', 1000, 2200);
insert into price values ('Sleeper', 1200, 2640);
insert into price values ('Sleeper', 350, 434);
insert into price values ('Sitting', 500, 620);
insert into price values ('Sitting', 600, 744);
insert into price values ('Sitting', 700, 868);
insert into price values ('Sitting', 1000, 1240);
insert into price values ('Sitting', 1200, 1488);
insert into price values ('Sitting', 1500, 1860);

-- 3) How many females and how many male passengers travelled for a minimum distance of 600 KM ?
select gender, count(gender) as number_of_passengers 
from passenger 
where distance >= 600 group by gender;

-- 4) Find the minimum ticket price for Sleeper Bus ?
select min(price) as minimum_ticket_price_sleeperbus 
from price 
where bus_type = 'Sleeper';

-- 5) Select passenger names whose names start with character 'S' ?
select passenger_name as name_start_with_s 
from passenger 
where passenger_name like 's%';

-- 6) Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price 
-- in the output ?
select pa.passenger_name, pa.boarding_city, pa.destination_city, pa.bus_type, pr.price 
from passenger pa left join price pr on pa.distance = pr.distance and pa.bus_type = pr.bus_type 
order by pa.passenger_name;           /*for khusboo no price is given in price table*/

-- 7) What is the passenger name and his/her ticket price who travelled in Sitting bus for a distance of 1000 KM ?
select P.passenger_name, P.price as Ticket_price from 
(select pa.passenger_name, pa.bus_type, pr.price, pa.distance from passenger pa left join price pr on pa.distance = pr.distance 
and pa.bus_type = pr.bus_type) as P 
where P.bus_type = 'Sitting' and P.distance = 1000;      /*no one has travelled 1000km by sitting type bus as per given data*/

-- 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
select pa.passenger_name, pr.bus_type, pr.price as price_for_bengaluru_to_panji 
from passenger pa inner join price pr on pa.distance = pr.distance 
where pa.passenger_name = 'pallavi' ;

-- 9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
select distinct distance 
from passenger 
order by distance desc;

-- 10) Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by 
-- all passengers without using user variables.
select passenger_name, (distance/(select sum(distance) from passenger))*100 as percentage_of_dis_travelled 
from passenger;

-- 11) Display the distance, price in three categories in table Price as follows -->
--           a) Expensive if the cost is more than 1000
--           b) Average Cost if the cost is less than 1000 and greater than 500
--           c) Cheap otherwise
select distance, price, case 
when price >1000 then "Expensive"
when price between 500 and 1000 then "Average_cost"
else "Cheap"
end as Price_Category
from price;






