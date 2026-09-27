
drop table  if exists Hospital_data;
create table Hospital_data(
               Hospital_Name varchar(100),
			   Location_name varchar(50),	
			   Department varchar(50),	
			   Doctors_Count int,
			   Patients_Count int,	
			   Admission_Date date,
			   Discharge_Date date,
			   Medical_Expenses decimal(10,2)
);
select*from Hospital_data;

--1-total number of patients
select sum(patients_count)as total_patients
from hospital_data;

--2-average number of doctors per hospital
select hospital_name, avg(doctors_count)
from hospital_data
group by hospital_name;

--3-top 3 departments with the heighest number of patients
select department, sum(patients_count) as total_patient
from hospital_data
group by department
order by total_patient desc limit 3;

--4-hospital with the maximum medical expenses
select hospital_name,medical_expenses as heighest_medical_expenses
from hospital_data
order by medical_expenses desc limit 1;

--5-daily average medical expenses
select admission_date,avg(medical_expenses)as average_daily_expenses
from hospital_data
group by admission_date
order by admission_date;

--6-longest hospital stay
select hospital_name,admission_date,discharge_date,
       (discharge_date-admission_date) as longest_stay
from hospital_data
order by longest_stay desc limit 1;

--7-total patients treated per city
select location_name,sum(patients_count)as total_patients
from hospital_data
group by location_name
order by total_patients desc;

--8-Average length of stay per department
select department, avg(discharge_date-admission_date)as average_stay_day
from hospital_data
group by "department"
order by average_stay_day desc;

--9-identitfy the department with the lowest number of patients
select department,sum(patients_count)as number_of_patients
from hospital_data
group by department
order by number_of_patients asc limit 1 ;

--10-group the data by month and calculatr the total medical expense for each month
SELECT
    TO_CHAR(admission_date, 'Month') AS month,
    SUM(medical_expenses) AS total_medical_expenses
FROM hospital_data
GROUP BY EXTRACT(MONTH FROM admission_date), TO_CHAR(admission_date, 'Month')
ORDER BY EXTRACT(MONTH FROM admission_date);