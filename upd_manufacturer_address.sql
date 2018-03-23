<<<<<<< HEAD
UPDATE loading.manufacturer_address SET mfr_id=(select id from public.manufacturer where mfr_abbreviation = mfr_abbr)
=======
UPDATE loading.manufacturer_address set address_hash = md5(ROW(company_name,last_name,first_name,address_line_one,address_line_two,city,state,postal,country )::TEXT)
WHERE 1=1;

UPDATE loading.manufacturer_address a set mfr_id = m.id 
from public.manufacturer m
WHERE a.mfr_abbr = m.mfr_abbr;
>>>>>>> 2bf7a72d38b355222031dbbc9e93e7587d0ab957
