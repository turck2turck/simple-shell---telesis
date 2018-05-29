-- Insert into the public.dealer_product_table only.
-- Read from loading.xls_dealer_product_base (load from excel spreadsheet).
-- Run from PGAdmin

select count(*) from loading.xls_dealer_product_base; 
select * from loading.xls_dealer_product_base;

-- Any dups in the input file?
select product_model_number, dealer_org_id, count(*)
from loading.xls_dealer_product_base
group by product_model_number, dealer_org_id
HAVING count(*) > 1; 

-- Insert records
insert into public.dealer_product_base (dealer_org_id, product_id, net_cost, buyer_price, retail_hidden, retail_can_purchase, buyers_hidden, buyers_can_purchase,created_at, created_by)
select x.dealer_org_id, p.id, (x.net_cost/p.msrp)*100, (x.buyer_price/p.msrp)*100, 'false', 'true', 'false', 'true', current_timestamp, 1 
from public.product p, loading.xls_dealer_product_base x, public.manufacturer m
where x.product_model_number = p.product_model_number 
and x.mfr_abbr = m.mfr_abbr
and p.manufacturer_id = m.id 
ON CONFLICT (dealer_org_id, product_id) DO UPDATE
set product_id=EXCLUDED.product_id, net_cost=EXCLUDED.net_cost, buyer_price=EXCLUDED.buyer_price

--- Not found
select * from loading.xls_dealer_product_base x
where not exists (select p.product_model_number   
		from public.dealer_product_base d, public.product p, public.manufacturer m
		where x.mfr_abbr = m.mfr_abbr  
  		  and x.product_model_number = p.product_model_number
  		  and x.dealer_org_id = d.dealer_org_id 
          and p.id = d.product_id
  		  and p.manufacturer_id = m.id) ;
