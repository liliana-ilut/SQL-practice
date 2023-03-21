--Question1
--Show all of the patients grouped into weight groups.
-- Show the total amount of patients in each weight group.
-- Order the list by the weight group decending.

-- For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.

SELECT 
	count(*) as patient_in_group,
    floor(weight /10) * 10  as weight_group
from patients
group by weight_group
order by weight_group desc
;

--alternate solutions:
SELECT
  --TRUNCATE(weight, -1) AS weight_group,
  count(*)
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

SELECT
  count(patient_id),
  weight - weight % 10 AS weight_group
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC

--Question 2
-- Show patient_id, weight, height, isObese from the patients table.
-- Display isObese as a boolean 0 or 1.
-- Obese is defined as weight(kg)/(height(m)2) >= 30.
-- weight is in units kg.
-- height is in units cm.

SELECT 
	patient_id,
    weight,
    height,
    (Case 
    	when weight/power(height/100.0,2) >= 30 then 1
    	ELSE 0
    end) as isObese
from patients
;

--alternate solution:
SELECT
  patient_id,
  weight,
  height,
  weight / power(CAST(height AS float) / 100, 2) >= 30 AS obese
FROM patients

--Question 3
-- Show patient_id, first_name, last_name, and attending doctor's specialty.
-- Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
-- Check patients, admissions, and doctors tables for required information.

SELECT 
	p.patient_id,
    p.first_name,
    p.last_name,
    d.specialty
from patients As p 
Join admissions as a on p.patient_id = a.patient_id
JOIN doctors as d on a.attending_doctor_id = d.doctor_id
where
	a.diagnosis = 'Epilepsy'
    and d.first_name = 'Lisa'
;

--Question 4
-- All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
-- The password must be the following, in order:
-- 1. patient_id
-- 2. the numerical length of patient's last_name
-- 3. year of patient's birth_date

SELECT 
	p.patient_id,
    CONCAT(p.patient_id, LEN(p.last_name),year(p.birth_date)) AS temp_password
from patients As p 
Join admissions as a on p.patient_id = a.patient_id
where
	admission_date is not null
group by p.patient_id
;

--alterante solutions:
select
  distinct p.patient_id,
  p.patient_id || floor(len(last_name)) || floor(year(birth_date)) as temp_password
from patients p
  join admissions a on p.patient_id = a.patient_id

select
  pa.patient_id,
  ad.patient_id || floor(len(pa.last_name)) || floor(year(pa.birth_date)) as temp_password
from patients pa
  join admissions ad on pa.patient_id = ad.patient_id
group by pa.patient_id;

--Question 5
-- Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
-- Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.

SELECT 
	(case
    	when patient_id % 2 = 0 then 'Yes'
    else 'No'
    End) AS has_insurance,
    SUM(
      case
    	when patient_id % 2 = 0 then 10
      else 50
      end) as cost_after_insurance
from admissions
group by has_insurance
;

--alternate solutions:
select 'No' as has_insurance, count(*) * 50 as cost
from admissions where patient_id % 2 = 1 group by has_insurance
union
select 'Yes' as has_insurance, count(*) * 10 as cost
from admissions where patient_id % 2 = 0 group by has_insurance;

SELECT
  has_insurance,
  CASE
    WHEN has_insurance = 'Yes' THEN COUNT(has_insurance) * 10
    ELSE count(has_insurance) * 50
  END AS cost_after_insurance
FROM (
    SELECT
      CASE
        WHEN patient_id % 2 = 0 THEN 'Yes'
        ELSE 'No'
      END AS has_insurance
    FROM admissions
  )
GROUP BY has_insurance;

select has_insurance,sum(admission_cost) as admission_total
from
(
   select patient_id,
   case when patient_id % 2 = 0 then 'Yes' else 'No' end as has_insurance,
   case when patient_id % 2 = 0 then 10 else 50 end as admission_cost
   from admissions
)
group by has_insurance

--Question 6
--Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name

SELECT 
	province_name
from province_names
join patients
	on province_names.province_id = patients.province_id
 group by province_name
 having 
 	count(Case when gender = 'M' then 1 end) 
    > 
    count(case when gender = 'F' then 1 end)
;

--alternate solutions:
SELECT province_name
FROM (
    SELECT
      province_name,
      SUM(gender = 'M') AS n_male,
      SUM(gender = 'F') AS n_female
    FROM patients pa
      JOIN province_names pr ON pa.province_id = pr.province_id
    GROUP BY province_name
  )
WHERE n_male > n_female;

SELECT pr.province_name
FROM patients AS pa
  JOIN province_names AS pr ON pa.province_id = pr.province_id
GROUP BY pr.province_name
HAVING
  SUM(gender = 'M') > SUM(gender = 'F');

SELECT province_name
FROM patients p
  JOIN province_names r ON p.province_id = r.province_id
GROUP BY province_name
HAVING
  SUM(CASE WHEN gender = 'M' THEN 1 ELSE -1 END) > 0;

 SELECT pr.province_name
FROM patients AS pa
  JOIN province_names AS pr ON pa.province_id = pr.province_id
GROUP BY pr.province_name
HAVING
  COUNT( CASE WHEN gender = 'M' THEN 1 END) > COUNT(*) * 0.5; 


--Question 7
-- We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
-- - First_name contains an 'r' after the first two letters.
-- - Identifies their gender as 'F'
-- - Born in February, May, or December
-- - Their weight would be between 60kg and 80kg
-- - Their patient_id is an odd number
-- - They are from the city 'Kingston'

SELECT *
from patients
where
	first_name like '__r%'
    and gender = 'F'
    and month(birth_date) in (02, 05, 12)
    and weight between 60 and 80
    and patient_id % 2 != 0
    and city = 'Kingston'
;

--Question 8
--Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.

SELECT CONCAT(
    ROUND(
      (
        SELECT COUNT(*)
        FROM patients
        WHERE gender = 'M'
      ) / CAST(COUNT(*) as float),
      4
    ) * 100,
    '%'
  ) as percent_of_male_patients
FROM patients;

--alternate solutions
SELECT
  round(100 * avg(gender = 'M'), 2) || '%' AS percent_of_male_patients
FROM
  patients;

 SELECT 
   CONCAT(ROUND(SUM(gender='M') / CAST(COUNT(*) AS float), 4) * 100, '%')
FROM patients; 