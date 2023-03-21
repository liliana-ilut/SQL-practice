--Question 1
--For each doctor, display their id, full name, and the first and last admission date they attended.
SELECT 
	doctor_id,
    concat(first_name, ' ', last_name) as full_name,
    min(admission_date) as first_admission_date,
    max(admission_date) as last_admission_date
from doctors
join admissions
	on doctors.doctor_id = admissions.attending_doctor_id
group by doctor_id
;

--Question 2
--Display the total amount of patients for each province. Order by descending.

SELECT 
	province_name,
    count(patient_id) AS patient_count
from province_names
join patients
	on province_names.province_id = patients.province_id
group by province_name
order by patient_count desc
;

--Question 3
--For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.

SELECT 
	concat(p.first_name, ' ', p.last_name) as patient_name,
    a.diagnosis,
    concat(d.first_name, ' ', d.last_name)  as doctor_name
from patients As p
join admissions As a ON p.patient_id = a.patient_id
join doctors as d on a.attending_doctor_id = d.doctor_id
;

--Question 4
--Display the number of duplicate patients based on their first_name and last_name.

SELECT 
	first_name,
    last_name,
    count(*) as num_duplicate_pat
from patients
group by first_name, last_name
having count(*) > 1
;

--Question 5
-- Display patient's full name,
-- height in the units feet rounded to 1 decimal,
-- weight in the unit pounds rounded to 0 decimals,
-- birth_date,
-- gender non abbreviated.

-- Convert CM to feet by dividing by 30.48.
-- Convert KG to pounds by multiplying by 2.205.

SELECT 
	concat(first_name, ' ', last_name) as full_name,
    round((height / 30.48), 1) as height_feet,
    round(weight * 2.205) as weight_pounds,
    birth_date,
    CASE
 		when gender = 'M' then 'MALE'
    	WHEN gender = 'F' then 'FEMALE'
 	END as gender
from patients
;