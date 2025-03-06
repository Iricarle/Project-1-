SELECT TOP (1000) [Name]
      ,[Family]
      ,[Where_Found]
      ,[Harmful_to_Humans]
  FROM [Project room].[dbo].[bacteria_list_200]


  --PRIMARY EXPLORATORY ANALYSIS

	--QUESTIONS
	----------

--1. Grouping by:
--a. the location count to the distribution of the natural_habitat. what is the top 10 of 
--     the most found natural habitat?

--b. by family, what is the most common family found in the dataset? show the top 10. 
--     and in total how many families do we have?

--2, what is the ration in term of difference between tha harmful and the non-hamrful 
--     to humans?

--3. what is the distribution of harmful bacteria across the 10 most common families 
--     
--4. and if possible to answer this question: the least common families are they mostly 
--	 harmful or non-harmful to human? so that we don't neglect them being like, they are 
--the least common so no need to worry about them

--5. where the top 10 of harmful bacteria are found and top 10 of the non-harmful bacteria 
--     are found?

 

select *
from BACTERIA

QUESTION 1 
==========


--1. Grouping by:
--a. the location count to the distribution of the natural_habitat. what is the top 10 of 
--     the most found natural habitat?

--b. by family, what is the most common family found in the dataset? show the top 10. 
--     and in total how many families do we have?


------------A. 

SELECT TOP 10 Natural_habitat, count (Natural_habitat) as count_of_the_natural
FROM BACTERIA
group by Natural_habitat
order by count_of_the_natural desc



------------------B

--b. by family, what is the most common family found in the dataset? show the top 10. 
--     and in total how many families do we have?

SELECT TOP 10 Family, COUNT (FAMILY) AS COUNT_OF_FAMILY
FROM BACTERIA
GROUP BY Family
ORDER BY COUNT_OF_FAMILY DESC

--QUESTION 2 
------------

--2, what is the ration in term of difference between tha harmful and 
--the non-hamrful to humans?

SELECT *
FROM BACTERIA

SELECT COUNT ( Harmful_to_Humans) harmful
FROM BACTERIA
WHERE Harmful_to_Humans = 'yes'

SELECT COUNT ( Harmful_to_Humans) non_harmful
FROM BACTERIA
WHERE Harmful_to_Humans = 'no'


--QUESTION 3 
--===========

--3. what is the distribution of harmful bacteria across the 10 most common families
--and if possible to answer this question: the least common families are they mostly 
--harmful or non-harmful to human?


--COUNT OF THE FAMILIES
--=====================
 --a. count of families sorted by the most found
 ------------------------------------------------
select Family, count (family) count_family
from BACTERIA
group by Family
order by count_family desc


--b. top 10 out of all those families
-------------------------------------
select TOP 10 Family,  count (family) count_family
from BACTERIA
group by Family
order by count_family desc


--IMPORTANT NOTE
--==================
-- IT WOULD BEST, AFTER ANALYSING THE RESULT OF THESE 2 (ABOVE) QUEUIRES, TO GO WITH TOP 15 SO 
-- THAT ALL THE BACTERIA WITH AT LEAST A PREVALENCE SUPERIOR TO 5 ARE REPRESENTED. 

--FOR THE SAKE OF THE ANALYSIS, BACTERIA WITH A PREVALENCE ABOVE OR EQUAL TO 5 ARE GOING TO BE 
--CONSIDERED COMMOM OR IN THE TOP 15, THE PREVALENCE BELOW OR EQUAL TO 4 IS GOING TO BE 
--LABELED NON- COMMON. 

--c. top 15 out of all those families
-------------------------------------
select TOP 15 Family,  count (family) count_family
from BACTERIA
group by Family
order by count_family desc


----From the top 15 most found bacteria IN COUNT, what is the distribution of
--harmful to humans bacteria
--or
  --among the 15 family what is the prevalence of the harmful to human bacteria and 
--non harmful to human bacteria

--harmful
----------

select TOP 15 Family,  count (family) count_family
from BACTERIA
WHERE Harmful_to_Humans = 'YES'
group by Family
order by count_family desc

----this is not right
SELECT TOP 15 Family, COUNT (Harmful_to_Humans)
FROM BACTERIA
WHERE Harmful_to_Humans = 'YES'
GROUP BY Family


--non- harmful
---------------

select TOP 15 Family,  count (family) count_family
from BACTERIA
WHERE Harmful_to_Humans = 'NO'
group by Family
order by count_family desc

--this is not right
SELECT TOP 15 Family, COUNT (Harmful_to_Humans)
FROM BACTERIA
WHERE Harmful_to_Humans = 'no'
GROUP BY Family

--QUESTION 4
--==========

--and if possible to answer this question: the least common families are they mostly 
--harmful or non-harmful to human? so that we don't neglect them being like, 
--they are the least common so no need to worry about them


--as we have established in the important note: the least common are going to be the 
--one with a prevalence tht is below 4

STEPS 
--======
-- a. count the families and sorting them in the ascending order and limit to where the count is 
-- equal or below 4 

 select Family, count (family) count_family
 from BACTERIA
 group by Family
 having count (family) < =  4
 order by count_family 


--b. find the revalence of harmful bacteria in those we selected.
----------------------------------------------------------------------

 select Family, count (family) count_family
 from BACTERIA
 where Harmful_to_Humans = 'Yes'
 group by Family
 having count (family) < =  4
 order by count_family
 

  --c. find the revalence of non-harmful bacteria in those we selected.
----------------------------------------------------------------------
 select Family, count (family) count_family
 from BACTERIA
 where Harmful_to_Humans = 'No'
 group by Family
 having count (family) < =  4
 order by count_family

 --QUESTION 5
--==========
 --5. where the top 15 of harmful bacteria are found and top 10 of the non-harmful bacteria 
--     are found?

--STEPS
--=====

--a. first we find out where the top 15 families live
-------------------------------------------------------
select TOP 15 Family, Natural_habitat ,count (family) count_family
from BACTERIA
group by Family, Natural_habitat
order by count_family desc

--harmful
---------

select TOP 15 Family, Natural_habitat ,count (family) count_family
from BACTERIA
WHERE Harmful_to_Humans = 'YES'
group by Family, Natural_habitat
order by count_family desc

--non- harmful
-----------------
select TOP 15 Family, Natural_habitat ,count (family) count_family
from BACTERIA
WHERE Harmful_to_Humans = 'no'
group by Family, Natural_habitat
order by count_family desc

  
  
 -- CONCLUSION ON OUR FINDINGS.
 --=============================
 
 After the exploratory analysis, I found out that: 
 







