// Chapter 4 - FIltering Data
// Lista de marca y modelo tenido en stock
SELECT DISTINCT MK.MakeName, MD.ModelName 
FROM stock ST 
JOIN model MD USING(ModelID) 
JOIN make MK USING(MakeID) 
ORDER BY MK.MakeName, MD.ModelName;

// Listado de los modelos de autos vendidos
SELECT MD.ModelName, SA.SaleDate, SA.InvoiceNumber
FROM model AS MD
JOIN stock AS ST USING(ModelID)
JOIN salesdetails AS SD ON ST.StockCode = SD.StockID
JOIN sales AS SA USING(SalesID)
ORDER BY MD.ModelName;


s
