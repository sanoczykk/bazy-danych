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

