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