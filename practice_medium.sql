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