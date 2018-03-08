INSERT INTO public.address (address_hash,dealer_org_id,buyer_org_id,manufacturer_id,application_user_id,type,company_name,first_name,last_name,phone,address_1,address_2,city,state,postal,country,created_at,created_by)
SELECT md5(ROW(company_name,last_name,first_name,address_line_one,address_line_two,city,state,postal,country )::TEXT),NULL,NULL,m.id,u.id,'Corporate','Customer','Service',NULL,a.address-line_one,a.address_line_two,a.city,a.state,a.postal,a.country,current_timestamp,'1'
FROM loading.akeneo
WHERE 1=1
ON CONFLICT(address_hash) DO UPDATE
SET type=EXCLUDED.type,company_name=EXCLUDED.company_name,first_name=EXCLUDED.first_name,last_name=EXCLUDED.last_name,phone=EXCLUDED.phone,address_1=EXCLUDED.address_1,address_2=EXCLUDED.address_2,city=EXCLUDED.city,state=EXCLUDED.state,postal=EXCLUDED.postal,country=EXCLUDED.country,updated_at=current_timestamp,updated_by='1';
