// 5.3 Data Manipulation Lanaguage Automation (Store Procedure & Triggers)
// 5.3.1 Procedimientos Almacenados sin Parametros
CREATE OR REPLACE PROCEDURE create_mock_ticket_data()
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE  FROM ticket_sale_item CASCADE;
    DELETE FROM ticket_sale_head CASCADE;
    ALTER SEQUENCE  ticket_sale_head_id_seq RESTART WITH 1;

    INSERT  INTO ticket_sale_head (member_id, sale_ts)
    SELECT  id, CURRENT_TIMESTAMP  AS sales_ts
    FROM member
    ORDER BY NAME LIMIT 3;

    WITH 
        ranked_events AS (
            SELECT id AS event_id, 
            ROW_NUMBER () OVER (ORDER BY id) AS rn
            FROM event ),
        expanded_sales AS (
            SELECT id AS sale_id,
            ROW_NUMBER() OVER (ORDER BY id) * 2 - 1 AS rn1, 
            ROW_NUMBER() OVER (ORDER BY id) * 2 AS rn2 
            FROM ticket_sale_head)
    INSERT INTO ticket_sale_item (sale_id, item_no, event_id, category, quantity)
        SELECT es.sale_id, 1, re1.event_id, 'B', 1
        FROM expanded_sales es JOIN ranked_events re1 ON es.rn1 = re1.rn
        UNION  ALL
        SELECT es.sale_id, 2, re2.event_id, 'C', 3
        FROM expanded_sales es JOIN ranked_events re2 ON es.rn2 = re2.rn;
END;
$$;
CALL create_mock_ticket_data();


// 5.3.2 Procedimientos almacenados con Parametros
CREATE OR REPLACE PROCEDURE add_theater(
	theater_id VARCHAR(10),
	theater_name VARCHAR(50),
	theater_capacity INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO theater(id, name, capacity) VALUES(theater_id, theater_name, theater_capacity);
END;
$$;

CALL  add_theater('LUNA', 'Luna Vista', 500);

// Manejo de errores con Store Procedure
CREATE OR REPLACE PROCEDURE add_theater(
	theater_id VARCHAR(10),
	theater_name VARCHAR(50),
	theater_capacity INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO theater(id, name, capacity) VALUES(theater_id, theater_name, theater_capacity);
-- en caso de registro duplicado, lanzamos un mensaje de error
EXCEPTION
	WHEN unique_violation
	THEN RAISE NOTICE 'The theater already exists';
END;
$$;

// Store Procedure with Custom Exceptions
CREATE OR REPLACE PROCEDURE add_theater(
	theater_id VARCHAR(10),
	theater_name VARCHAR(50),
	theater_capacity INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
	IF length(theater_name) < 5 THEN
		RAISE 'Theater name is too short';
	END IF;
	
	INSERT INTO theater(id, name, capacity) VALUES(theater_id, theater_name, theater_capacity);
-- en caso de registro duplicado, lanzamos un mensaje de error
EXCEPTION
	WHEN unique_violation
	THEN RAISE NOTICE 'The theater already exists';
END;
$$;

// Drop Store Procedure
DROP PROCEDURE IF EXISTS add_theater;

// Trigger
CREATE OR REPLACE FUNCTION  check_category_c_return ()
RETURNS TRIGGER
AS $$
BEGIN
	IF NEW.category = 'C' AND NEW.is_returned = TRUE THEN
		RAISE EXCEPTION 'Can not return a ticket with Category C';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

// Plan for the trigger check_category_c_return
CREATE OR REPLACE TRIGGER  ticket_return_category_c
BEFORE  UPDATE ON ticket_sale_item 
FOR EACH ROW
EXECUTE FUNCTION  check_category_c_return ();
