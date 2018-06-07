select sku from public.product group by sku having count(*) > 1;
