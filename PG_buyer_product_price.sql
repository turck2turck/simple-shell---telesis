-- Insert into the public.buyer_product_price only.
-- Read from loading.xls_buyer_price.
-- Run from PGAdmin.

select count(*) from loading.xls_buyer_price; --30
select * from loading.xls_buyer_price;

-- Any dups in the input file?
select product_model_number, dealer_org_id, buyer_org_id, mfr_abbr, count(*)
from loading.xls_buyer_price
group by product_model_number, dealer_org_id, mfr_abbr, buyer_org_id
HAVING count(*) > 1

-- Insert parent records
insert into public.dealer_product_base (dealer_org_id, product_id, retail_hidden,retail_can_purchase,buyers_hidden, buyers_can_purchase,created_at, created_by)
select x.dealer_org_id, p.id, 'false', 'true', 'false', 'true', current_timestamp, 1 
from public.product p, loading.xls_buyer_price x, public.manufacturer m
where x.product_model_number = p.product_model_number 
and x.mfr_abbr = m.mfr_abbr
and p.manufacturer_id = m.id 
ON CONFLICT (dealer_org_id, product_id) DO NOTHING
; --0 

-- Insert child records
insert into public.buyer_product_price (buyer_org_id,dealer_product_base_id,dealer_org_id,price,hidden_override,can_purchase_override)
select x.buyer_org_id,d.id,x.dealer_org_id,(x.price/p.msrp)*100,false,true 
from loading.xls_buyer_price x, public.dealer_product_base d, public.product p, public.manufacturer m
where x.mfr_abbr = m.mfr_abbr  
  and x.product_model_number = p.product_model_number 
  and x.dealer_org_id = d.dealer_org_id 
  and p.manufacturer_id = m.id 
  and d.product_id = p.id 
  and p.msrp <> 1 
ON CONFLICT (buyer_org_id,dealer_product_base_id,dealer_org_id)  DO UPDATE
set price=EXCLUDED.price; --30
  
-- Not found
select * from loading.xls_buyer_price
where product_model_number not in (select p.product_model_number
                from public.dealer_product_base d, public.product p, public.manufacturer m, loading.xls_buyer_price x, public.buyer_product_price b
                where x.mfr_abbr = m.mfr_abbr
                  and x.product_model_number = p.product_model_number 
	          and p.manufacturer_id = m.id
                  and x.dealer_org_id = d.dealer_org_id 
                  and b.buyer_org_id = x.buyer_org_id 
                  and b.dealer_org_id = x.dealer_org_id 
                  and b.dealer_product_base_id = d.id 
                  ); 
