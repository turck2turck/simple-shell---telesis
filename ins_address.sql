INSERT INTO public.address (address_hash,application_user_id,manufacturer_id,type,company_name,first_name,last_name,address_1,address_2,city,state,postal,country, created_at,created_by)
SELECT address_hash,1,mfr_id,'Corporate',company_name,first_name,last_name,address_line_one,address_line_two,city,state,postal,country,current_timestamp,1
FROM loading.manufacturer_address 
ON CONFLICT (address_hash) DO UPDATE
SET company_name=EXCLUDED.company_name,first_name=EXCLUDED.first_name,last_name=EXCLUDED.last_name,address_1=EXCLUDED.address_1,address_2=EXCLUDED.address_2,updated_at=current_timestamp,updated_by=1;
