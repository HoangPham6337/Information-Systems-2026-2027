USE sakila;
-- List names of all the languages in the database (sorted alphabetically)
SELECT name
FROM language
ORDER BY name;

-- List full names of actors with "GER" in their last name, 
-- ordered by their first name
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM actor
WHERE last_name LIKE '%GER%'
ORDER BY first_name;

-- Find all the addresses where postal code starts with "57",
-- and return addresses sorted
SELECT
    address,
    postal_code
FROM address
WHERE postal_code LIKE '57%'
ORDER BY address;

-- How many films involve a "DWARF" in their titles
SELECT COUNT(*) AS number_of_film_title_involve_dwarf FROM film
WHERE title LIKE '%DWARF%';

-- Find full names of actors who played in a film involving 'WAR' in title
-- and longer than 2.5 hours, along with the title, run length
-- and release year of the movie, sorted by the actors last names.
SELECT
    f.title,
    f.length,
    f.release_year,
    GROUP_CONCAT(
        CONCAT(a.first_name, ' ', a.last_name)
        ORDER BY a.last_name SEPARATOR ', '
    ) AS actors_list
FROM actor AS a
INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
INNER JOIN film AS f ON fa.film_id = f.film_id
WHERE
    fa.film_id IN (
        SELECT fs.film_id
        FROM film AS fs
        WHERE fs.title LIKE '%WAR%' AND fs.length > 150
    )
GROUP BY f.title, f.length, f.release_year
ORDER BY f.title;

-- Find all the film categories in which there are between 55 and
-- 65 films. Return the names of these categories and the number
-- of films per category, sorted by the number of films descending.
SELECT
    c.name,
    COUNT(fc.film_id) AS total_film
FROM category AS c
INNER JOIN film_category AS fc ON c.category_id = fc.category_id
GROUP BY c.category_id
HAVING total_film >= 55 AND total_film <= 65
ORDER BY total_film DESC;

-- In how many film categories is the average difference between
-- the film replacement cost and the rental rate larger than 17?
WITH rent_rate AS (
    SELECT
        fc.category_id,
        AVG(f.rental_rate) AS avg_rental_rate
    FROM film AS f
    INNER JOIN film_category AS fc ON f.film_id = fc.film_id
    GROUP BY fc.category_id
)

SELECT
    rep_cost.category_id,
    rep_cost.avg_replacement_cost - rent_rate.avg_rental_rate AS avg_diff
FROM (
    SELECT
        fc.category_id,
        AVG(f.replacement_cost) AS avg_replacement_cost
    FROM film AS f
    INNER JOIN film_category AS fc ON f.film_id = fc.film_id
    GROUP BY fc.category_id
) AS rep_cost
INNER JOIN rent_rate ON rep_cost.category_id = rent_rate.category_id
HAVING avg_diff > 17;


CREATE OR REPLACE VIEW avg_rental_rate_by_category AS
SELECT
    fc.category_id,
    AVG(f.rental_rate) AS avg_rental_rate
FROM film AS f
INNER JOIN film_category AS fc ON f.film_id = fc.film_id
GROUP BY fc.category_id;

CREATE OR REPLACE VIEW avg_replacement_cost_by_category AS
SELECT
    fc.category_id,
    AVG(f.replacement_cost) AS avg_replacement_cost
FROM film AS f
INNER JOIN film_category AS fc ON f.film_id = fc.film_id
GROUP BY fc.category_id;

SELECT
    avg_cost.category_id,
    avg_cost.avg_replacement_cost - avg_rent.avg_rental_rate AS avg_diff
FROM avg_rental_rate_by_category AS avg_rent
INNER JOIN
    avg_replacement_cost_by_category AS avg_cost
    ON avg_rent.category_id = avg_cost.category_id
HAVING avg_diff > 17;

-- Find the address district(s) name(s) such that the minimal
-- postal code in the district(s) is maximal over all the districts.
-- Make sure your query ignores empty postal codes and district names.
SELECT district FROM address
WHERE TRIM(district) <> '' AND TRIM(postal_code) <> ''
GROUP BY district
HAVING
    MIN(postal_code) = (
        SELECT MAX(min_postal_code.min_code) AS max_min_postal_code
        FROM (
            SELECT MIN(postal_code) AS min_code
            FROM address
            WHERE TRIM(district) <> '' AND TRIM(postal_code) <> ''
            GROUP BY district
        ) AS min_postal_code
    );

-- Find the names (first and last) of all the actors and customers
-- whose first name is the same as the first name of the actor
-- with ID 101 (exclude the actor with ID 101).
SELECT *
FROM (
    (SELECT
        actor_id AS combined_id,
        first_name,
        last_name
    FROM actor)
    UNION
    (SELECT
        customer_id AS combined_id,
        first_name,
        last_name
    FROM customer)
) AS name_table
WHERE name_table.last_name = (
    SELECT a.last_name FROM actor AS a
    WHERE a.actor_id = 101
) AND name_table.combined_id <> 101;
