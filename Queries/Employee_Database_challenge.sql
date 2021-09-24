
		-- DELIVERABLE 1
SELECT em.emp_no,
	em.first_name,
	em.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
	INTO retirement_by_title
FROM employees as em
INNER JOIN titles as ti
ON em.emp_no = ti.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY em.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_by_title as rt
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.emp_no) DESC;

		-- DELIVERABLE 2 Mentorship eligibility chart
SELECT DISTINCT ON (em.emp_no) em.emp_no,
	em.first_name,
	em.last_name,
	em.birth_date,
	de.from_date,
	de.to_date,
	ti.title	
INTO mentorship_elig
	FROM employees as em
	INNER JOIN dept_emp as de
		ON em.emp_no = de.emp_no
	INNER JOIN titles as ti
		ON em.emp_no = ti.emp_no
	WHERE ((birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (de.to_date = '9999-01-01'))
ORDER BY em.emp_no;


		--DELIVERABLE 3  (2) EXTRA QUERIES AND CHARTS

SELECT COUNT(me.emp_no), me.title
FROM mentorship_elig as me
GROUP BY me.title
ORDER BY COUNT(me.emp_no) DESC;

SELECT AVG(s.salary),
	ut.title,
	COUNT(ut.emp_no)
FROM salaries as s
INNER JOIN unique_titles as ut
ON s.emp_no = ut.emp_no
GROUP BY ut.title
ORDER BY COUNT(ut.emp_no) DESC;