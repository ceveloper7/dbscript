/** View Manipulation **/ 
CREATE VIEW employee_with_many_children AS
SELECT 
        id,
        name,
        child_count
FROM
        employee
WHERE
        child_count >= 3;
        
// call a view
SELECT * FROM employee_with_many_children;

// modificando una vista
ALTER VIEW employee_with_many_children RENAME TO employees_with_many_children;

// cambiando el contenido de una vista
CREATE OR REPLACE VIEW employees_with_many_children AS
SELECT
        id,
        name,
        child_count
FROM
        employee
WHERE
        child_count <= 4;
        
// Eliminacion de una Vista
DROP VIEW employees_with_many_children;