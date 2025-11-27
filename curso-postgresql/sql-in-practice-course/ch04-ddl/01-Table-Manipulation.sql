
/** Conexion POSGRESQL */
// sudo psql -h localhost -p 5432 -U barcvilla -d playground


/* Creating table with Primary Key Constraint */
//si establecemos a phone como UNIQUE dos filas con phone NULL se permitiran pero dos filas con phone empty no se permitiran
// combiancion de columnas UNIQUE
// country_code y phone deben contener valores distintos
CREATE TABLE employee(
        id INT PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        country_code VARCHAR(3),
        phone VARCHAR(20),
        address VARCHAR(100),
        address1 VARCHAR(100) DEFAULT 'Not known as of ' ||  TO_CHAR(CURRENT_DATE, 'YYYY-MM-DD'),
        UNIQUE(country_code, phone),
        CHECK(country_code <> phone),
        CHECK(LENGTH(address) >= 10)
);

/* Creating table with Two PK */
/* Solo dos valores permitidos para la columna currency */
CREATE TABLE employee_bonus(
        employee_id INT,
        bonus_year INT,
        bonus_amount NUMERIC(12,2) NOT NULL,
        currency VARCHAR(3) NOT NULL,
        PRIMARY KEY(employee_id, bonus_year),
        FOREIGN KEY(employee_id) REFERENCES employee(id),
        CHECK(currency='USD' OR currency='EUR')
);

/*CReating table with Constraint PK and FK*/
CREATE TABLE employee_bonus(
        employee_id INT,
        bonus_year INT,
        bonus_amount NUMERIC(12,2) NOT NULL,
        currency VARCHAR(3) NOT NULL,
        PRIMARY KEY(employee_id, bonus_year),
        FOREIGN KEY(employee_id) REFERENCES employee(id)
);

/* Para cada fila en employee_bonus tenemos multiples filas en employee_bonus_payment. Declaramos una Composite Foreign Key */
CREATE TABLE employee_bonus_payment(
        employee_id INT,
        bonus_year INT,
        installment INT,
        payment_amount NUMERIC(12,2) NOT NULL,
        currency VARCHAR(3) NOT NULL,
        is_paid BOOLEAN NOT NULL,
        payment_date DATE NOT NULL,
        PRIMARY KEY(employee_id, bonus_year, installment), -- composite key
        FOREIGN KEY(employee_id) REFERENCES employee(id),
        FOREIGN KEY(employee_id, bonus_year) REFERENCES employee_bonus(employee_id, bonus_year)
);

/* Consulta NULL or Empty values */
// get employee where phone is null     
SELECT * FROM employee where phone IS NULL;

// get employees where phone is empty
SELECT * FROM employee WHERE phone = '';

/* renombrar el nombre de una tabla */
ALTER TABLE employees RENAME TO employee;

/* Columns modifications  */
// ADD new column
ALTER TABLE employee ADD COLUMN birthday DATE NOT NULL;

// Renombrar el nombre de una columna
ALTER TABLE employee RENAME COLUMN birthday TO birth_date;

// Eliminar columna de una tabla
ALTER TABLE employee DROP COLUMN birth_date;

/* Modifican tipo de dato de columnas */
// Incrementando el tamano de un campo varchar
ALTER TABLE employee ALTER COLUMN address SET DATA TYPE VARCHAR(110);

/* cambiar un tipo de datos de columna varchar a int */
// 1. primero creamos una columna con el tipo de dato objetivo es decir int
ALTER TABLE employee ADD COLUMN new_child_count INT;

//2. copiamos los valores de la columna vieja employee.count_child a la nueva employee_new_child_count
UPDATE employee SET new_child_count = CAST(child_count AS INT);

//3. eliminamos la vieja columna employee.child_count
ALTER TABLE employee DROP COLUMN child_count;

//4. REenombrar la nueva columna
ALTER TABLE employee RENAME COLUMN new_child_count TO child_count;

/* Una forma mas directa de cambiar el tipo de dato de una columa a otro tipo de dato */
ALTER TABLE employee ALTER COLUMN child_count TYPE INT USING child_count::INT;

/* Modificacion de Restricciones */
// Podemos cambiar las restricciones de una tabla. Cambiando el valor por defecto de una campo o especificando que una campo no acepta NULL
ALTER TABLE employee ALTER COLUMN child_count SET DEFAULT 0;
ALTER TABLE employee ALTER COLUMN child_count SET NOT NULL;

// Podemos tambien eliminar restricciones
ALTER TABLE employee ALTER COLUMN child_count DROP DEFAULT;
ALTER TABLE employee ALTER COLUMN child_count DROP NOT NULL;

/** Modify constraint that cover multiple columns **/
// add constraint primery key
ALTER TABLE employee_bonus ADD CONSTRAINT employee_bonus_pkey PRIMARY KEY(employee_id, bonus_year);

// add constraint foreign key
ALTER TABLE employee_bonus ADD CONSTRAINT emplpyee_bonus_fkey1 FOREIGN KEY(employee_id) REFERENCES employee(id);

// Adding a check Constraint
ALTER TABLE employee_bonus ADD CONSTRAINT employee_bonus_chk1 CHECK(currency = 'USD' OR currency = 'EUR');

// deleting a CONSTRAINT
ALTER TABLE employee_bonus DROP CONSTRAINT employee_bonus_chk1;

/** Table Deletion **/
DROP TABLE IF EXISTS employee_bonus CASCADE;

/** Deletion rows but not Table structure **/
TRUNCATE TABLE employee_bonus;
