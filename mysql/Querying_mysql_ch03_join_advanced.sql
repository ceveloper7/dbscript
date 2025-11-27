// Chapter 3 - Using advanced JOIN tables
// La eleccion entre LEFT y Right JOIN depende del orden en el que se coloquen las tablas en el SQL.
// 1. Combinacion LEFT JOIN para retornar los datos de una tabla pero no de la otra.
// Mostramos todos los registro de make (left side) y solo los registros coincidentes en model (right side)

// mostramos MakeName y ModelName pero no duplicados
SELECT DISTINCT MK.MakeName, MD.ModelName 
-- Queremos ver todos los registro de make
FROM make MK 
-- LEFT JOIN O LEFT OUTER JOIN queremos ver solo los registros que coincidan en make y model
LEFT JOIN model MD 
-- usamos USING or ON para indicar el campo que vincula ambas tablas
USING(MakeID); 

// Same Query with a simple JOIN
SELECT DISTINCT MK.MakeName, MD.ModelName FROM make MK JOIN model MD ON MK.MakeID=MD.MakeID;

// 2. Combinacion RIGHT JOIN para retornar todos los registros de una tabla pero de la otra
SELECT DISTINCT MK.MakeName, MD.ModelName
// mostramos solo los registros que comparten valores con la tabla make
FROM model MD
// mnostramos todos los registros de la tabla derecha
RIGHT JOIN make MK
USING(MakeID);

// 3. Union de tablas intermedias
// supongamos que desea consultar las ventas realizadas en cada país. 
// Al examinar las tablas de la base de datos PrestigeCars, 
// ha descubierto que las cifras de ventas se encuentran en la tabla «Ventas» y los nombres de los países en la tabla «Países». 
// Sin embargo, estas dos tablas no tienen campos en común, por lo que no se pueden unir. 
// No obstante, ambas tablas están conectadas a la tabla «Clientes»
// Se pueden unir las tablas Ventas y Pais, si se agrega la tabla Customer como tabla intermedia.
SELECT CO.CountryName, SA.TotalSalePrice
-- left
FROM sales SA
JOIN customer CS USING(CustomerID)
-- right
JOIN country CO ON CS.Country = CO.CountryISO2;

// 4. Usando multiples campos en JOINS
SELECT CS.CustomerName, MI.SpendCapacity
FROM customer CS
JOIN marketinginformation MI
ON CS.CustomerName = MI.CUST
AND CS.Country = MI.Country
ORDER BY CS.CustomerName;

// 5. Union una tabla consigo misma
SELECT ST1.StaffName, ST1.Department, ST2.StaffName AS ManagerName
FROM staff ST1
JOIN staff ST2
ON ST1.ManagerID = ST2..StaffID
ORDER BY ST1.Department, ST1.staffName

// 6. Uniendo tablas sobre un rango de valores
SELECT MK.MakeName, MD.ModelName, SD.SalePrice, CAT.CategoryDescription
-- necesitamos la tabla stock como enlace para unir las tablas Model y salesdetails
FROM stock ST
JOIN model MD USING(ModelID)
JOIN make MK USING(MakeID)
JOIN salesdetails SD ON ST.StockCode = SD.StockID
JOIN salescategory CAT ON SD.SalePrice 
BETWEEN CAT.LowerThreshold AND CAT.UpperThreshold
ORDER BY MK.MakeName, MD.ModelName;
