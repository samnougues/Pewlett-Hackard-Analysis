SELECT e.emp_no,
    e.first_name,
	e.last_name,
	t.title,
    t.from_date,
    t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31');
SELECT * FROM retirement_titles
ORDER BY emp_no ASC;
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no ASC;
SELECT * FROM unique_titles
SELECT COUNT(title)
FROM unique_titles;
-- Create retiring_titles
SELECT title, COUNT(*) AS count 
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER by count DESC;
-- Make mentorship eligibility table
SELECT DISTINCT ON (emp_no)e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
INNer JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01');