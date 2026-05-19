use  hospital_managment_system;

#1. Write a query in SQL to obtain the name of the physician in alphabetical order. 
 
 select * from physician
 order by name asc;

#2. Write a query in SQL to obtain the fullname of the patients whose gender is male.

select concat(name," ",surname) as Full_name, gender from patient
where gender = "Male";

#3. Write a query in SQL to find the name of the nurse who are the head of their department and are registered.

select name from nurse
where position = "Head Nurse" and registered = "Yes";

#4. Write a query in SQL to find the name of the nurse who are Team Leader or not registered.

select name from nurse
where position = 'Team Leader' and registered='No';

#5. Write a query to obtain the avg cost of all the medical procedures.

select avg(cost) as average_cost  from procedures;

#6 Write a query to obtain name and cost of the procedure whose cost is greater than 2000.

select name,cost from procedures
where cost > 2000;

#7. Write a query to update the name of the patient to Robert Fernandez having patientid as 5.

select * from patient
where patient_id = 5;

update patient
set name = 'Robert',surname = 'Fernandez'
where patient_id = 5;

#8. Write a query to drop phone column from patient table.

select * from patient;

alter table patient
drop column phone;

#9. Second maximum cost of medical procedure

#one method
select * from procedures
order by cost desc
limit 1 offset 1;
#second method
with rnk as  (select *,dense_rank() over(order by cost desc) as cost_order
from procedures)
select * from rnk where cost_order = 2;

#Like Operator

#10. Write a query in SQL to obtain the name of the patients starting with letter A.

select * from patient where name  like 'a%';
select * from patient;

#11. Write a query in SQL to obtain the name of the patients whose third letter is M.

select * from patient where name like '__m%' ;

#12. Write a query in SQL to obtain the name of the patients whose name start with letter J and ends with Z.

select * from patient where name like 'j%z';
with J_Z as (
select *,concat(name,surname) as full_name from patient )
select * from J_Z where  full_name like 'j%z';

#13. Write a query to obtain patient details having patient_id 11 to 20.

select * from patient where patient_id between 11 and 20;

select * from patient where patient_id >=11 and patient_id <=20;
#JOINS

#14.  Write a query in SQL to obtain the name of the physicians who are the head of each department
select * from physician where position like 'h%';


#15. Write a query in SQL to obtain the name of the patients with their physicians by whom they got their preliminary treatement

select * from patient;
select * from physician;
with primary_cehck as(
select concat(pa.name,' ',pa.surname) as patienet_name,
p.name as physician_name
from patient pa
left join physician p
on pa.primary_check = p.employeeid)
select * , row_number() over() as id from primary_cehck
;
#16. Write a query in SQL to obtain the name of the physician with the department who are done with affiliation.

select * from physician;
select * from department;
select * from affiliated_with;

select p.name as physician_name,
d.dept_name as department_name
from physician p
inner join affiliated_with a
on p.employeeid = a.physicianid
inner join department d
on a.departmentid = d.department_id
where primaryaffiliation ='t';

#17. Write a query to obtain physician name,position and department they are affiliated with.
with pda as(
select p.name as physician_name,
p.position as position,
d.dept_name as department
from physician p
inner join affiliated_with aw
on p.employeeid = aw.physicianid
inner join department d
on aw.departmentid = d.department_id)
select * ,row_number()over() as number from pda;

#18. Write a query in SQL to obtain the patient name from which physician they get primary_checkup and also mention the patient diagnosis with prescription.

select concat(p.name,' ',p.surname) as patient_name,
pd.diagnosis as diagnosis,
pd.prescription as prescription
from patient p
inner join patient_diagnosis pd
on p.patient_id = pd.patient_id;

#SUBQUERY

#19. Write a query in SQL to obtain the maximum cost of the medical procedure.
select * from procedures where cost =(select max(cost) from procedures);

#20. Write a query in SQL to obtain the details of patient who has diagnosed with chronic pain.

select * from patient 
where
patient_id in (select patient_id  from patient_diagnosis where diagnosis = 'chronic pain' );

#using join for above question
select concat(p.name,' ',p.surname) as patient_name,
p.address,
p.gender,
p.primary_check,
pd.diagnosis
from patient p
inner join patient_diagnosis pd
on p.patient_id = pd.patient_id
where pd.diagnosis = 'chronic pain';

#21. Write a query in SQL to obtain the procedure name and cost whose cost is greater than the avg cost of all the procedure.

select * from procedures;

select * from procedures 
where cost >(select avg(cost) as average_cost from procedures);

#22. Write a query in SQL to obtain the procedure name and cost whose cost is less than the avg cost of all the procedure.

select * from procedures 
where cost <(select avg(cost) as average_cost from procedures);

#23. Write a query in SQL to obtain the physician name who are either head chief or senior in their respective department.

select * from physician where position like 'head%' or position like 'senior%';

#24.  Write a query in SQL to obtain the employeeid, physician name and position whose primary affiliation has not been done. 

select * from physician where employeeid in(
select physicianid from affiliated_with where primaryaffiliation = 'f');