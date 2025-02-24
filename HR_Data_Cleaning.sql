CREATE DATABASE project;

USE project;
SELECT * FROM HR; 
DESCRIBE HR;
SET sql_safe_updates = 0;


ALTER TABLE HR
CHANGE COLUMN ï»¿id employee_id VARCHAR(20) NULL;


SELECT birthdate FROM HR;
UPDATE HR
SET birthdate = CASE
	WHEN birthdate LIKE'%/%' 
    THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d') 
    WHEN birthdate LIKE'%-%'
    THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;
ALTER TABLE HR
MODIFY COLUMN birthdate DATE;

UPDATE HR
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' 
    THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%'
    THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;
ALTER TABLE HR
MODIFY COLUMN hire_date DATE;

-- exact dumb but not exact output
-- UPDATE HR
-- SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
-- WHERE termdate IS NOT NULL AND termdate != '';

-- modified input to get the exact output
-- UPDATE HR
-- SET termdate = CASE
-- 	WHEN termdate IS NULL OR termdate = '' THEN '0000-00-00'
--     ELSE DATE(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')
-- END;

SELECT termdate FROM HR;
UPDATE HR
SET termdate = IF(termdate IS NOT NULL AND termdate !='',
 date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')),'0000-00-00')
WHERE true;

SELECT termdate FROM HR;
SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE HR
MODIFY COLUMN termdate DATE;




-- CASE
-- 	WHEN termdate IS NULL OR termdate = '' THEN  '0000-00-00'
--     ELSE DATE(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
-- END;

UPDATE HR
SET termdate = CASE
	WHEN termdate IS NULL OR termdate = ''THEN null
    ELSE DATE(termdate)
END;

ROLLBACK;


SELECT termdate FROM HR;
-- ALTER TABLE termdate DROP COLUMN termdate;

DESCRIBE HR;


-- ALTER TABLE hr ADD COLUMN age INT;
-- DROP TABLE HR;
ALTER TABLE HR ADD COLUMN age INT;
UPDATE HR
SET age = timestampdiff(YEAR, birthdate, CURDATE());
SELECT birthdate, age FROM HR;

SELECT
	MIN(age) AS youngest,
    MAX(age) AS oldest
FROM HR;

SELECT age,
	COUNT(*) AS count
FROM HR
GROUP BY age
ORDER BY count DESC
LIMIT 3;
SELECT age,
	COUNT(*) AS count
FROM HR
GROUP BY age
ORDER BY count ASC
LIMIT 3;

SELECT count(*) FROM HR WHERE age < 18;

	