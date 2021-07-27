CREATE TABLE movie_theatre(
    theatre_id SERIAL PRIMARY KEY,
    city VARCHAR(150),
    county VARCHAR(150)
);

CREATE TABLE customer(
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    city INTEGER NOT NULL,
    county INTEGER NOT NULL,
    FOREIGN KEY(city) REFERENCES movie_theatre ON DELETE CASCADE,
    FOREIGN KEY(county) REFERENCES movie_theatre ON DELETE CASCADE
);

CREATE TABLE movie(
    movie_id SERIAL PRIMARY KEY,
    movie_name VARCHAR(100)
);

CREATE TABLE ticket(
    ticket_id SERIAL PRIMARY KEY,
    quantity NUMERIC(3),
    total_price NUMERIC(8,2),
    date_purchased TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc', now()),
    customer_id INTEGER NOT NULL,
    movie_id INTEGER NOT NULL,
    movie_name INTEGER NOT NULL,
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY(movie_id) REFERENCES movie(movie_id) ON DELETE CASCADE,
    FOREIGN KEY(movie_name) REFERENCES movie ON DELETE CASCADE
);

CREATE TABLE concession(
    upc SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    product_quantity NUMERIC(3),
    total_product_price NUMERIC(8,2),
    customer_id INTEGER NOT NULL,
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

--INSERTING VALUES
--Movie Theatre
INSERT INTO movie_theatre(
    theatre_id,
    city,
    county
) 

VALUES(
    '0305',
    'Venice',
    'Los Angeles'
),

(
    '0081',
    'Long Beach',
    'Los Angeles'  
),

(
    '0264',
    'Fullerton',
    'Orange'
)
--Customer
INSERT INTO customer(
    customer_id,
    first_name,
    last_name,
    city,
    county
) 

VALUES(
    '000519',
    'Marcus',
    'Peters'
    SELECT city from movie_theatre where city = 'Venice',
    SELECT county from movie_theatre where county = 'Los Angeles'
),

(
    '080274',
    'Jake',
    'Johnson',
    SELECT city from movie_theatre where city = 'Fullerton',
    SELECT county from movie_theatre where county = 'Orange'  
),

(
    '002031',
    'Trey',
    'Burke',
    SELECT city from movie_theatre where city = 'Long Beach',
    SELECT county from movie_theatre where county = 'Los Angeles'
)
--Movie
INSERT INTO movie(
    movie_id,
    movie_name
) 

VALUES(
    '027',
    'Talladega Nights'
),

(
    '444',
    'Fantastic Mr.Fox'
),

(
    '321',
    'Superbad'
)
--Ticket
INSERT INTO ticket(
    ticket_id,
    quantity,
    total_price,
    date_purchased,
    customer_id,
    movie_id,
    movie_name
) 

VALUES(
    '000522',
    3,
    14.99,
    SELECT SESSION CURRENT_TIMESTAMP
    SELECT customer_id from customer where customer_id = '000519',
    SELECT movie_id from movie where movie_id = '027',
    SELECT movie_name from movie where movie_name = 'Talladega Nights'
),

(
    '000276',
    2,
    9.99, 
    SELECT SESSION CURRENT_TIMESTAMP
    SELECT customer_id from customer where customer_id = '080274',
    SELECT movie_id from movie where movie_id = '444',
    SELECT movie_name from movie where movie_name = 'Fantastic Mr.Fox'
),

(
    '002031',
    2,
    9.99, 
    SELECT SESSION CURRENT_TIMESTAMP
    SELECT customer_id from customer where customer_id = '002031',
    SELECT movie_id from movie where movie_id = '321',
    SELECT movie_name from movie where movie_name = 'Superbad'
)

--Concession
-- upc SERIAL PRIMARY KEY,
--     product_name VARCHAR(100),
--     product_quantity NUMERIC(3),
--     total_product_price NUMERIC(8,2),
--     customer_id INTEGER NOT NULL

INSERT INTO concession(
    upc,
    product_name,
    product_quantity,
    total_product_price,
    customer_id,
) 

VALUES(
    '12345AC79',
    'Sour Skittles',
    2,
    6.99,
    SELECT customer_id from customer where customer_id = '000519'
),

(
    '12345Z9F0',
    'Smart Water'
    1,
    3.50,
    SELECT customer_id from customer where customer_id = '080274'
),

(
    '12345R49P',
    'Dibs'
    1,
    2.50,
    SELECT customer_id from customer where customer_id = '002031'
)
--End

--The relationships are as follows: 
--'customer_id' goes from customer to ticket as a one to many relationship b/c onecan have multiple customer ids;
--'city' and 'county' go from movie theatre to customer as a one to many relationship b/c one customer can be in multiple locations;
--'customer_id'goes from customer to concession as a one to many relationship bc many customer_id can frequent the concession stand;
--and finally 'movie_id' and 'movie_name' go from movie to ticket as tickets are not exclusive to just one film/id
