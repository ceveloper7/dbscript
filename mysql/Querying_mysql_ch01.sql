/*12. cambiar nombre de un campo */
SELECT CountryName, CountryISO3 AS "Iso Code" FROM country;

/*13. Ordenar datos */
// ordenar las ventas por precio de venta creciente
SELECT * FROM salesdetails ORDER BY SalePrice;

/* ordenar datos orden alfabetico inverso */    
SELECT CountryISO3 as IsoCode, CountryName FROM country ORDER BY IsoCode DESC;

/* Multiples criterios de ordenamiento */
// ver los autos vendidos y ordenado por pais, marca, modelo
SELECT CountryName, MakeName, ModelName FROM salesbycountry ORDER BY CountryName, MakeName, ModelName;

/*16. Limitar el nro de registros mostrados */
// mostrar los primeros 10 registros 
SELECT * FROM make LIMIT 10;
