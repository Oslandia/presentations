SELECT ST_Intersects(
    ST_Intersection(
      'LINESTRING(0 0,2 1)'::geometry, 
      'LINESTRING(1 0,0 1)'::geometry), 
    'LINESTRING(0 0,2 1)'::geometry);
 