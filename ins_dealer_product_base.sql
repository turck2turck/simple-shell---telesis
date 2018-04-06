insert into public.dealer_product_base (dealer_org_id, product_id, retail_price,retail_hidden,retail_can_purchase,created_at,created_by)
       select d.id, p.id,100,false, true, current_timestamp,1
       from public.product p, public.dealer_org d
       where d.name = 'all'
