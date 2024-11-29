/*Q21. Linkedin data analyst interview question
Assume you're given a table containing job postings form various companies on the
linkedin platform. write a query to retrieve the count of companies that have posted
duplicate job listings.
Duplicate job listings are defined as two job listings within the same company that share
identical titles and descriptions.
job_listings table : job_id, company_id, title, description 
*/

SELECT
	count(*) as count_companies
FROM(
	SELECT
		company_id,
		title,
		description,
		count(job_id) as count_job
	FROM job_listings
	GROUP BY company_id, title, description
	HAVING count(job_id) > 1
	) as x
;