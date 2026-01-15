// Chapter 4 - FIltering Data
// Lista de marca y modelo tenido en stock
SELECT DISTINCT MK.MakeName, MD.ModelName 
FROM stock ST 
JOIN model MD USING(ModelID) 
JOIN make MK USING(MakeID) 
ORDER BY MK.MakeName, MD.ModelName;

// 4.3 Filtrando datos usando tablas intermedias
// Listado de los modelos de autos vendidos
SELECT MD.ModelName, SA.SaleDate, SA.InvoiceNumber
FROM model AS MD
JOIN stock AS ST USING(ModelID)
JOIN salesdetails AS SD ON ST.StockCode = SD.StockID
JOIN sales AS SA USING(SalesID)
ORDER BY MD.ModelName;


// 4.4 - Filtrando texto
SELECT DISTINCT MD.ModelName, ST.Color  
FROM stock ST JOIN  model MD USING(ModelID) 
WHERE ST.Color = 'Red' ORDER BY MD.ModelName;

// 4.5 Aplicar multiples filtros de texto
SELECT DISTINCT MD.ModelName, ST.Color 
FROM stock ST JOIN model MD USING(ModelID) 
WHERE ST.Color in ('Red', 'Green', 'Blue') ORDER BY MD.ModelName;

// 4.6 Exclusion de un elemento de texto (<> o tambien !=). De todas las marcas vendidas excluimos Ferrari.
SELECT     DISTINCT MK.MakeName
          FROM make AS MK
JOIN       model AS MD USING(MakeID)
JOIN       stock AS ST USING(ModelID)
JOIN       salesdetails SD ON ST.StockCode = SD.StockID
WHERE      MK.MakeName <> 'Ferrari'
ORDER BY   MK.MakeName;

// 4.7 Uso de filtro de exclusion multiples. Lista de todas las marcas vendidas excepto Porsche, Aston Martin, Bentley
SELECT     DISTINCT MK.MakeName
FROM       make AS MK
JOIN       model AS MD USING(MakeID)
JOIN       stock AS ST USING(ModelID)
JOIN       salesdetails SD ON ST.StockCode = SD.StockID
WHERE      MK.MakeName NOT IN ('Porsche', 'Aston Martin', 'Bentley')
ORDER BY   MK.MakeName;

// 4.8 Filtrado de numeros por encima de un umbral definido
SELECT ModelName, Cost
FROM model
JOIN stock USING(ModelID)
WHERE Cost > 50000;

// 4.9 Filtrado de numeros por debajo de un umbral definido
SELECT     ModelName, Cost
FROM       model
JOIN       stock USING(ModelID)
WHERE      PartsCost < 1000
ORDER BY   ModelName;
