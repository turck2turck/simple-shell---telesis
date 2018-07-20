--Run from PgAdmin
-- Insert parent records
insert into public.dealer_product_base (dealer_org_id, product_id, retail_hidden,retail_can_purchase,buyers_hidden, buyers_can_purchase,created_at, created_by)
select x.dealer_org_id, p.id, 'false', 'true', 'false', 'true', current_timestamp, 1
from public.product p, loading.batch_buyer_product_price x, public.manufacturer m
where x.mfr_abbr = m.mfr_abbr and p.manufacturer_id = m.id and p.msrp<> 1
ON CONFLICT (dealer_org_id, product_id) DO NOTHING;


-- Insert child records
insert into public.buyer_product_price (buyer_org_id,dealer_product_base_id,dealer_org_id,price,hidden_override,can_purchase_override)
select x.buyer_org_id,d.id,x.dealer_org_id,(1+(x.percentage))*d.net_cost,false,true
from loading.batch_buyer_product_price x, public.dealer_product_base d, public.product p, public.manufacturer m
where x.mfr_abbr = m.mfr_abbr and x.dealer_org_id = d.dealer_org_id and p.manufacturer_id = m.id
  and d.product_id = p.id and p.msrp <> 1 and d.net_cost is not null
ON CONFLICT (buyer_org_id,dealer_product_base_id,dealer_org_id)  DO UPDATE set price=EXCLUDED.price ; 
