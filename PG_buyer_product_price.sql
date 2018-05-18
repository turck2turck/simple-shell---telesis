-- Insert into the public.buyer_product_price only.
-- Read from loading.xls_buyer_price.

select count(*) from loading.xls_buyer_price; --594
select * from loading.xls_dealer_product_base;

-- Any dups in the input file?
select product_model_number, dealer_org_id, buyer_org_id, mfr_abbr, count(*)
from loading.xls_buyer_price
group by product_model_number, dealer_org_id, mfr_abbr, buyer_org_id
HAVING count(*) > 1

-- Insert parent records
insert into public.dealer_product_base (dealer_org_id, product_id, retail_hidden,retail_can_purchase,buyers_hidden, buyers_can_purchase,created_at, created_by)
select x.dealer_org_id, p.id, 'false', 'true', 'false', 'true', current_timestamp, 1 
from public.product p, loading.xls_dealer_product_base x, public.manufacturer m
where x.product_model_number = p.product_model_number 
and x.mfr_abbr = m.mfr_abbr
and p.manufacturer_id = m.id 
ON CONFLICT (dealer_org_id, product_id) DO UPDATE
set product_id=EXCLUDED.product_id, net_cost=EXCLUDED.net_cost, buyer_price=EXCLUDED.buyer_price;

-- Insert child records
insert into public.buyer_product_price (buyer_org_id,dealer_product_base_id,dealer_org_id,price,hidden_override,can_purchase_override)
select x.buyer_org_id,d.id,x.dealer_org_id,round((x.price/p.msrp)*100,2),false,true 
from loading.xls_buyer_price x, public.dealer_product_base d, public.product p, public.manufacturer m
where x.mfr_abbr = m.mfr_abbr  
  and x.product_model_number = p.product_model_number 
  and x.dealer_org_id = d.dealer_org_id 
  and p.manufacturer_id = m.id 
  and d.product_id = p.id  
ON CONFLICT (buyer_org_id,dealer_product_base_id,dealer_org_id)  DO UPDATE
set buyer_org_id=EXCLUDED/buyer_org_id, dealer_product_base_id=EXCLUDED.dealer_product_base,dealer_org_id=EXCLUDED.dealer_org_id;
   
-- Not found
                                         
select * from loading.xls_buyer_price 
where product_model_number not in (select p.product_model_number   
		from public.dealer_product_base d, public.product p, public.manufacturer m, loading.xls_buyer_price x
		   where x.mfr_abbr = m.mfr_abbr  
  		 and x.product_model_number = p.product_model_number
  		 and x.dealer_org_id = d.dealer_org_id 
  		 and p.manufacturer_id = m.id)  ;
