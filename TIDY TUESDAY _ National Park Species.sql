--INTRODUCTION AND DISCLAIMER FROM R STUDIO 

SELECT *
FROM most_visited_nps_species_data

QUESTIONS
============
 QUESTION 1
--==============
--1. a general question for the whole table: how many row and columns do we have? 

-- For the first part let's combine the Parkcode column and the ParkName.

--1. how many park do we have?           

QUESTION 2
--===========
----CATEGORYNAME  
--===============
--1. how many of the category name do we have?

----GROUP TOGETHER CATEGORYNAME, ORDER AND FAMILY
----==============================================
--1. find the count in each of the fields and group the by the one that has the lowest count. 



QUESTION 3
--===========
----TaxonRecordStatus
--===================
--1. how many type of status do we have. 


QUESTION 4
--===========
--ParkAccepted
--=============
--This field tells if a species is accepted or not in a park. 
--so we can ask:
--1. how many species are accepted i all the parks
--2. which park accepts the least species and which one accepts the most species (
--the top 1 in accepting species)
--3. which species have a high level of acceptency and those who have a high level of denial ( or 
--those who have the lowest level of acceptancy.)
--4. In term of percentage: which category of animal that has the highest acceptency rate and the one
--with the least.
--5. on average , how many animals are accepted, how many are denied?

 QUESTION 5
--===========
--Record status
--=================
--whether or not nps approved the species.

--This field goes hand in hand with the ParkAccepted field.
--we can confirm if they match or not. and this for visualisation. 

 QUESTION 6
--===========
--Occurence
--==========
-- The current status of existence or presence of each species in each park.
-- Applicable only to scientific names with Park Accepted Status of "Accepted".
-- Possible values reflect a combination of confidence, and availability and currency 
-- of verifiable evidence.


  QUESTION 7
--===========
--Nativeness	
--===========
--whether or not the species is native. 
--how many natives or not?
--1. if we combine with the approval field, is there a correlation between being native or non-native 
--with that fact of being accepted in a park? 
--2. if we look into non-native, do they have a high rate of acceptancy or is it low? 
--3. I am assuming the natives have no problem with acceptancy, it should be high, is it true? 

QUESTION 8
--===========

--Abundance	
--=============
--This field tells how abundant is the species in the park

--1. what are the qualifiers used to describe the abundance? 
--2. and what is the most and the least of each qualifier? 

--the last 3 columns can be can be analysed after understanding the dataset better. 


--at this stage we can say with confindence the fields we judge of relenvence: 

SELECT 1,2,3,4,5,6,10,12,15
FROM most_visited_nps_species_data


---- EXPLORATORY ANALYSIS
----=====================

--1. CLEANING THE DATASET 
--------------------------
--THE CLEANING IS PROCEED IN R. IN SQL IT WOULD TAKE WAY TOO LONG.


 ANSWERS
---============

 ANSWER 1 
 --==========
--1. a general question for the whole table: how many row and columns do we have? 

-- For the first part let's combine the Parkcode column and the ParkName.

--2. how many park do we have?


--1. a general question for the whole table: how many row and columns do we have? 

--THE NUMBER OF ROWS WE HAVE 
--SELECT count (*) as number_of_rows
--FROM most_visited_nps_species_data 

--RESULT: 61119. 


----THE NUMBER OF COLUMNS WE HAVE. 

--SELECT count(*) as No_of_Column 
--FROM information_schema.columns 
--WHERE table_name ='most_visited_nps_species_data'

----2. how many park do we have?

--SELECT COUNT (*)
--FROM (
--		SELECT DISTINCT (ParkName)
--		FROM most_visited_nps_species_data
--		GROUP BY ParkName
--		) AS T

----RESULT: 15

--SELECT ParkName, COUNT (ParkName) AS COUNT
--FROM most_visited_nps_species_data
--GROUP BY ParkName

  ANSWER 2
--===========
----CATEGORYNAME  
--===============
--1. how many of the category name do we have?

----GROUP TOGETHER CATEGORYNAME, ORDER AND FAMILY
----==============================================
--1. find the count in each of the fields and group the by the one 
--that has the lowest count.
----do a visualisation about this aggregation.

--SELECT *
--FROM most_visited_nps_species_data

--SELECT COUNT (*)
--FROM (
--	SELECT DISTINCT  (CategoryName)
--	FROM most_visited_nps_species_data) AS T

--RESULT: WE HAVE 16 Categories


ANSWER 3
--===========
----TaxonRecordStatus
--===================
--1. how many type of status do we have. 

--SELECT *
--FROM most_visited_nps_species_data

--SELECT TaxonRecordStatus, COUNT (TaxonRecordStatus) AS COUNT
--FROM most_visited_nps_species_data
--GROUP BY TaxonRecordStatus 
--ORDER BY COUNT DESC


ANSWER 4 
--==========

--ParkAccepted
--=============
--This field tells if a species is accepted or not in a park. 
--Accepted being 1 and not accepted being 0 

--SO WE CAN ASK:
--1. how many species are accepted iN all the parks
--2. which park accepts the least species and which one accepts the most species (
--the top 1 in accepting species)
--3. which species have a high level of acceptency and those who have a high level of denial ( or 
--those who have the lowest level of acceptancy.)
--4. In term of percentage: which category of animal that has the highest acceptency rate and the one
--with the least.
--5. on average , how many species are accepted, how many are denied?


--SELECT * 
--FROM most_visited_nps_species_data


----1. how many species are accepted in all the parks

SELECT COUNT ( ParkAccepted) ACCEPTED
FROM most_visited_nps_species_data
WHERE ParkAccepted =1
GROUP BY ParkAccepted

SELECT COUNT ( ParkAccepted) NOT ACCEPTED 
FROM most_visited_nps_species_data
WHERE ParkAccepted =0
GROUP BY ParkAccepted

--N,B: This needs to be worked on better. I wna the result to be shown side by side as 2 columns
--not 2 rows. with name accepted and not accepted

----2. which park accepts the least species and which one accepts the most species (
----the top 1 in accepting species)

SELECT TOP 1 ParkName, COUNT (ParkAccepted) COUNT_OF_ACCEPTANCE
FROM most_visited_nps_species_data
WHERE ParkAccepted =1 
GROUP BY ParkName
ORDER BY COUNT_OF_ACCEPTANCE DESC

SELECT TOP 1 ParkName, COUNT (ParkAccepted) COUNT_OF_NONE_ACCEPTANCE
FROM most_visited_nps_species_data
WHERE ParkAccepted =0 
GROUP BY ParkName
ORDER BY COUNT_OF_NONE_ACCEPTANCE DESC

--N.B: Do this better, show me the result as 2 numbers in 2 columns side by side 
--of the park that accepts the least and the park that accepts the most. 



----3. which species have a high level of acceptency and those who have a high level of denial 
----( or those who have the lowest level of acceptancy.)

SELECT CategoryName, COUNT ( ParkAccepted) COUNT_OF_ACCEPTANCE
FROM most_visited_nps_species_data
WHERE ParkAccepted = 1
GROUP BY CategoryName
ORDER BY COUNT_OF_ACCEPTANCE DESC

SELECT CategoryName, COUNT ( ParkAccepted) COUNT_OF_ACCEPTANCE
FROM most_visited_nps_species_data
WHERE ParkAccepted = 0
GROUP BY CategoryName
ORDER BY COUNT_OF_ACCEPTANCE DESC

--4. In term of percentage: which category of species that has the highest acceptency rate 
--and the one with the least.

SELECT CategoryName, 
	COUNT ( ParkAccepted) COUNT_OF_ACCEPTANCE, 
	COUNT ( ParkAccepted) *100 /
	(select count(*) from most_visited_nps_species_data) as COUNT_PERCENTAGE
FROM most_visited_nps_species_data
WHERE ParkAccepted = 1
GROUP BY CategoryName
ORDER BY COUNT_OF_ACCEPTANCE DESC



----5. on average , how many species are accepted, how many are denied?
  SELECT AVG (COUNT_OF_ACCEPTANCE) AVERAGE_OF_SPECIES_ACCEPTED
FROM (
		SELECT CategoryName, COUNT ( CategoryName) COUNT_OF_ACCEPTANCE
		FROM most_visited_nps_species_data
		WHERE ParkAccepted =1 
		GROUP BY CategoryName) AS T

--SELECT AVG (COUNT_OF_NOT_ACCEPTANCE) AVERAGE_OF_SPECIES_NOT_ACCEPTED
--FROM (
--		SELECT CategoryName, COUNT ( CategoryName) COUNT_OF_NOT_ACCEPTANCE
--		FROM most_visited_nps_species_data
--		WHERE ParkAccepted = 0
--		GROUP BY CategoryName) AS T


