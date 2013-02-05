CREATE TABLE buildings (
	gid SERIAL PRIMARY KEY
	, geom geometry(MultiPolygon, 26986)
);

alter table buildings 
	alter column geom 
		type geometry(MultiPolygon, 2154) 
		using st_setsrid(geom, 2154);
