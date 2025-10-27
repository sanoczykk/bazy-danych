CREATE EXTENSION postgis;

--4
CREATE TABLE buildings (id SERIAL PRIMARY KEY, geom GEOMETRY(POLYGON, 0), name VARCHAR);
CREATE TABLE roads (id SERIAL PRIMARY KEY, geom GEOMETRY(LINESTRING, 0), name VARCHAR);
CREATE TABLE poi (id SERIAL PRIMARY KEY, geom GEOMETRY(POINT, 0), name VARCHAR);

--5
INSERT INTO buildings (name, geom) VALUES
('BuildingA', ST_GeomFromText('POLYGON((8 1.5, 10.5 1.5, 10.5 4, 8 4, 8 1.5))', 0)),
('BuildingB', ST_GeomFromText('POLYGON((4 5, 6 5, 6 7, 4 7, 4 5))', 0)),
('BuildingC', ST_GeomFromText('POLYGON((3 6, 5 6, 5 8, 3 8, 3 6))', 0)),
('BuildingD', ST_GeomFromText('POLYGON((9 8, 10 8, 10 9, 9 9, 9 8))', 0)),
('BuildingF', ST_GeomFromText('POLYGON((1 1, 2 1, 2 2, 1 2, 1 1))', 0));


INSERT INTO roads (name, geom) VALUES
('RoadX', ST_GeomFromText('LINESTRING(7.5 0, 7.5 10.5)', 0)),
('RoadY', ST_GeomFromText('LINESTRING(0 4.5, 12 4.5)', 0));


INSERT INTO poi (name, geom) VALUES
('G', ST_GeomFromText('POINT(1 3.5)', 0)),
('H', ST_GeomFromText('POINT(5.5 1.5)', 0)),
('I', ST_GeomFromText('POINT(9.5 6)', 0)),
('J', ST_GeomFromText('POINT(6.5 6)', 0)),
('K', ST_GeomFromText('POINT(6 9.5)', 0));

--6

--A
SELECT SUM(ST_Length(geom)) AS total_road_len
FROM roads;

--B
SELECT 
    ST_AsText(geom) AS wkt,
    ST_Area(geom) AS pole,
    ST_Perimeter(geom) AS perimeter
FROM buildings 
WHERE name = 'BuildingA';

--C
SELECT 
    name,
    ST_Area(geom) AS pole
FROM buildings 
ORDER BY name;

--D
SELECT 
    name,
    ST_Perimeter(geom) AS perimeter
FROM buildings 
ORDER BY ST_Area(geom) DESC 
LIMIT 2;

--E
SELECT 
    ST_Distance(b.geom, p.geom) AS krotki
FROM buildings b, poi p
WHERE b.name = 'BuildingC' AND p.name = 'K';

--F
SELECT 
    ST_Area(ST_Difference(
        b1.geom, 
        ST_Buffer(b2.geom, 0.5)
    )) AS pole
FROM buildings b1, buildings b2
WHERE b1.name = 'BuildingC' AND b2.name = 'BuildingB';

--G
SELECT b.name
FROM buildings b, roads r
WHERE r.name = 'RoadX'
AND ST_Y(ST_Centroid(b.geom)) > ST_Y(ST_LineInterpolatePoint(r.geom, 0.5));

--H
WITH poly AS (
    SELECT ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))') AS geom
)
SELECT 
    ST_Area(ST_SymDifference(b.geom, p.geom)) AS pole
FROM buildings b, poly p
WHERE b.name = 'BuildingC';


