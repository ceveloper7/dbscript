show tables;
desc stock;
desc model;
desc customer;


// uniendo dos tablas: Lista de autos adquiridos y el importe pagado
SELECT ModelName, Cost FROM model JOIN stock USING(ModelID) ORDER BY ModelName;
// Equivalente
SELECT ModelName, Cost FROM model JOIN stock ON model.ModelID = stock.ModelID ORDER BY ModelName;

// unir dos tablas con diferentes nombres de campos vinculos por medio de JOIN ON
SELECT CountryName FROM customer JOIN country ON customer.Country = country.CountryISO2;

// 3. Eliminacion de duplicados (DISTINCT)
SELECT DISTINCT CountryName FROM customer JOIN country ON customer.Country = country.CountryISO2;

// 4. Unir varias tablas: obtenemos el precio de Marca y Modelo de autos
SELECT make.MakeName AS Brand, model.ModelName as Model, stock.Cost as Cost
FROM stock 
JOIN model USING(ModelID)
JOIN make USING(MakeID)
ORDER BY make.MakeName, model.ModelName;
// o tambien
SELECT make.MakeName AS Brand, model.ModelName as Model, stock.Cost as Cost
FROM make
INNER JOIN model USING(MakeID)
INNER JOIN stock USING(ModelID)
ORDER BY make.MakeName, model.ModelName;

//5. Uso de alias
SELECT S.InvoiceNumber, D.LineItemNumber, D.SalePrice, D.LineItemDiscount 
FROM sales as S 
JOIN salesdetails as D USING(SalesID) 
ORDER BY S.InvoiceNumber, D.LineItemNumber;

//6. Uniendo multiples tablas
SELECT 
        CY.CountryName, 
        MK.MakeName, 
        MD.modelName, 
        ST.Cost, 
        ST.RepairsCost, 
        ST.PartsCost, 
        ST.TransportInCost, 
        ST.Color, 
        SD.SalePrice, 
        SD.LineItemDiscount, 
        SA.InvoiceNumber, 
        SA.SaleDate, 
        CS.CustomerName 
FROM    stock ST 
JOIN    model MD USING(modelID) 
JOIN    make MK USING(MakeID) 
JOIN    salesdetails SD ON ST.StockCode = SD.StockID 
JOIN    sales SA USING(SalesID) 
JOIN    customer CS USING(CustomerID) 
JOIN    country CY ON CS.country = CY.CountryISO2 
ORDER BY CY.CountryName, MK.MakeName, MD.ModelName;

