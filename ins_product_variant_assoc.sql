DELETE FROM public.product_variant_assoc WHERE variant_product_id IN (
SELECT p.id FROM public.variant_product p, loading.akeneo a
WHERE p.product_hash = a.product_hash );

INSERT INTO public.product_variant_assoc(variant_product_id, variant_id)
SELECT p.id, v.id FROM public.variant_product p, loading.akeneo a, public.variant v
WHERE a.variant_hash1 IS NOT NULL AND a.product_hash = p.product_hash AND v.variant_hash = a.variant_hash1;

INSERT INTO public.product_variant_assoc(variant_product_id, variant_id)
SELECT p.id, v.id FROM public.variant_product p, loading.akeneo a, public.variant v
WHERE a.variant_hash2 IS NOT NULL AND a.product_hash = p.product_hash AND v.variant_hash = a.variant_hash2;

INSERT INTO public.product_variant_assoc(variant_product_id, variant_id)
SELECT p.id, v.id FROM public.variant_product p, loading.akeneo a, public.variant v
WHERE a.variant_hash3 IS NOT NULL AND a.product_hash = p.product_hash AND v.variant_hash = a.variant_hash3;

INSERT INTO public.product_variant_assoc(variant_product_id, variant_id)
SELECT p.id, v.id FROM public.variant_product p, loading.akeneo a, public.variant v
WHERE a.variant_hash4 IS NOT NULL AND a.product_hash = p.product_hash AND v.variant_hash = a.variant_hash4;

INSERT INTO public.product_variant_assoc(variant_product_id, variant_id)
SELECT p.id, v.id FROM public.variant_product p, loading.akeneo a, public.variant v
WHERE a.variant_hash5 IS NOT NULL AND a.product_hash = p.product_hash AND v.variant_hash = a.variant_hash5;

INSERT INTO public.product_variant_assoc(variant_product_id, variant_id)
SELECT p.id, v.id FROM public.variant_product p, loading.akeneo a, public.variant v
WHERE a.variant_hash6 IS NOT NULL AND a.product_hash = p.product_hash AND v.variant_hash = a.variant_hash6;

INSERT INTO public.product_variant_assoc(variant_product_id, variant_id)
SELECT p.id, v.id FROM public.variant_product p, loading.akeneo a, public.variant v
WHERE a.variant_hash7 IS NOT NULL AND a.product_hash = p.product_hash AND v.variant_hash = a.variant_hash7;

INSERT INTO public.product_variant_assoc(variant_product_id, variant_id)
SELECT p.id, v.id FROM public.variant_product p, loading.akeneo a, public.variant v
WHERE a.variant_hash8 IS NOT NULL AND a.product_hash = p.product_hash AND v.variant_hash = a.variant_hash8;

INSERT INTO public.product_variant_assoc(variant_product_id, variant_id)
SELECT p.id, v.id FROM public.variant_product p, loading.akeneo a, public.variant v
WHERE a.variant_hash9 IS NOT NULL AND a.product_hash = p.product_hash AND v.variant_hash = a.variant_hash9;

INSERT INTO public.product_variant_assoc(variant_product_id, variant_id)
SELECT p.id, v.id FROM public.variant_product p, loading.akeneo a, public.variant v
WHERE a.variant_hash10 IS NOT NULL AND a.product_hash = p.product_hash AND v.variant_hash = a.variant_hash10;
