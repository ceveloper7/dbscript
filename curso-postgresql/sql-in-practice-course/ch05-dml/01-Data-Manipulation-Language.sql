// Data Manipulation Lanaguage
// INSERT
INSERT INTO artist(id, name, bio) VALUES('LUNE', 'Lunas Echoes', 'An ambient duo known for ethereal soundscapes.');

// Insert multiple rows
INSERT INTO theater(id, name, capacity)
VALUES
    ('AURA', 'Aura Plaza', 750),
    ('VIBE', 'Vibe Lounge', 650),
    ('ECHO', 'Echo Hall', 900),
    ('ZENI', 'Zenith Arena', 850),
    ('PULS', 'Pulse Center', 950);

// Serial column insertion
INSERT INTO member(name, birthday, phone, email)
VALUES
        ('Alex Johnson',
         '1985-06-15',
         '555-1234',
         'alex.johnson@example.com');
         
// Null values insertion. Table member has two field accept null value (birthday,phone)
INSERT  INTO member (name, email)
VALUES
    ('Morgan Taylor', 'morgan.taylor@example.com');
    
// Bulk insert operation with explicity null value
INSERT  INTO member (name, birthday, phone, email)
VALUES
    (
        'Samantha Brown',
        '1987-03-30',
        '555-8765',
        'samantha.brown@example.com'
    ),
    (
        'Chris Smith',
        NULL,
        '555-4321',
        'chris.smith@example.com'
    ),
    (
        'Taylor Wilson',
        '1992-08-17',
        NULL,
        'taylor.wilson@example.com'
    ),
    (
        'Jordan Davis',
        NULL,
        NULL,
        'jordan.davis@example.com'
    ),
    (
        'Riley Adams',
        '1984-12-05',
        '555-6789',
        'riley.adams@example.com'
    );  

// Data Insertion on fields with default values
// La tabla event posee el campo is_cancelled con un valor false por defecto
INSERT  INTO event (name, gig_ts, theater_id, artist_id)
VALUES
    (
        'Lunar Echoes Single Debut',
        '2025-02-15 21:30:00',
        'AURA',
        'LUNE');  

// Insertanto filas desde otra tabla
// Por cada registro en la tabla event, insertamos un registro en la tabla event_ticket
INSERT INTO event_ticket(event_id, category, price, capacity)
SELECT id, 'A', 100, 30
FROM event;

// UPDDATE
 UPDATE event_ticket SET currency = 'EUR' where event_id = 3;
 
 // actualizamos price y capacity todos los event_ticket cuya moneda sea usd y sean de categoria A
UPDATE event_ticket SET price = 120, capacity = 25 WHERE event_id <> 3 AND category = 'A';

// Actualizando con calculos
UPDATE event_ticket SET price = price * 1.1 WHERE category = 'B' OR category = 'C';

UPDATE event_ticket SET price = 1000 / capacity WHERE event_id = 5;

// ACtualizando con SUbConsultas
UPDATE event_ticket
SET
        price = (
                -- se ejecuta la sentencia SELECT primero
                SELECT MIN(price)
                FROM event_ticket
                WHERE category = 'C' AND currency = 'USD'
        )
WHERE event_id = 4 AND category = 'C';

// Actualizando con Condiciones
UPDATE  event_ticket
SET
    price = 
    CASE 
        WHEN category = 'A' THEN price + 20
        WHEN category = 'B' THEN price + 10
        WHEN category = 'C' THEN price + 5
    END
WHERE
    currency = 'USD';  

// CASE condition mas Compleja
UPDATE event_ticket
SET
        capacity = 
        CASE
                WHEN category = 'A' AND currency = 'EUR' THEN 50
                WHEN category = 'B' THEN 42
        -- La parte ELSE corresponde a todas las filas que no son afectadas por la condicion CASE y asi indicamos queno queremos modificarlas
        -- si no especificamos la parte ELSE las filas que no corresponden a ninguna condicion recibiran el valor NULL
        ELSE capacity
        END
WHERE
        event_id <> 1;


// Delete Sample -- nos permite hacer un rollback por medio de los archivos logs
DELETE FROM ticket_sale_item WHERE category = 'C';

// DELETE WITH NO WHERE CONDITION -- 
DELETE FROM ticket_sale_item;
 
// DELETE WITH TRUNCATE -- hace una eliminacion rapida y no hace revisiones
TRUNCATE ticket_sale_item

// OTHER CASES
-- Eliminamos registros member con valores en el campo phone vacio
DELETE FROM member WHERE phone = '';

-- ELiminamos registros member con valores en el campo phone null
DELETE FROM member WHERE phone IS NULL;

-- Eliminamos registros member de ambos grupos empty y null
DELETE FROM member WHERE phone = '' OR phone IS NULL;  


        

