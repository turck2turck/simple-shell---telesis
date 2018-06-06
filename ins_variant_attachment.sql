delete FROM public.product_attachment WHERE variant_product_id in (
SELECT p.id FROM public.variant_product p, loading.akeneo a
WHERE p.product_hash = a.product_hash );

-- 5 images
INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Image', 'Y', a.primary_image
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.primary_image IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Image', 'N', a.image_secondary_1
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.image_secondary_1 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Image', 'N', a.image_secondary_2
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.image_secondary_2 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Image', 'N', a.image_secondary_3
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.image_secondary_3 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Image', 'N', a.image_secondary_4
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.image_secondary_4 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Image', 'N', a.image_secondary_5
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.image_secondary_5 IS NOT NULL;

-- 10 manuals
INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Manual', 'N', a.manual
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.manual IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Manual', 'N', a.manual_2
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.manual_2 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Manual', 'N', a.manual_3
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.manual_3 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Manual', 'N', a.manual_4
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.manual_4 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Manual', 'N', a.manual_5
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.manual_5 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Manual', 'N', a.manual_6
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.manual_6 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Manual', 'N', a.manual_7
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.manual_7 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Manual', 'N', a.manual_8
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.manual_8 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Manual', 'N', a.manual_9
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.manual_9 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Manual', 'N', a.manual_10
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.manual_10 IS NOT NULL;

-- 10 Brochures
INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Brochure', 'N', a.brochure
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.brochure IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Brochure', 'N', a.brochure_2
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.brochure_2 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Brochure', 'N', a.brochure_3
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.brochure_3 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Brochure', 'N', a.brochure_4
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.brochure_4 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Brochure', 'N', a.brochure_5
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.brochure_5 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Brochure', 'N', a.brochure_6
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.brochure_6 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Brochure', 'N', a.brochure_7
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.brochure_7 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Brochure', 'N', a.brochure_8
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.brochure_8 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Brochure', 'N', a.brochure_9
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.brochure_9 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Brochure', 'N', a.brochure_10
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.brochure_10 IS NOT NULL;

-- 10 Spec Sheets
INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Spec Sheet', 'N', a.spec_sheet_file
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.spec_sheet_file IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Spec Sheet', 'N', a.spec_sheet_file_2
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.spec_sheet_file_2 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Spec Sheet', 'N', a.spec_sheet_file_3
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.spec_sheet_file_3 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Spec Sheet', 'N', a.spec_sheet_file_4
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.spec_sheet_file_5 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Spec Sheet', 'N', a.spec_sheet_file_6
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.spec_sheet_file_6 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Spec Sheet', 'N', a.spec_sheet_file_7
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.spec_sheet_file_7 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Spec Sheet', 'N', a.spec_sheet_file_8
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.spec_sheet_file_8 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Spec Sheet', 'N', a.spec_sheet_file_9
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.spec_sheet_file_9 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'spec sheet', 'N', a.spec_sheet_file_10
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.spec_sheet_file_10 IS NOT NULL;

-- 10 Warranties
INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Warranty', 'N', a.warranty
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.warranty IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Warranty', 'N', a.warranty_2
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.warranty_2 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Warranty', 'N', a.warranty_3
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.warranty_3 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Warranty', 'N', a.warranty_4
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.warranty_4 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Warranty', 'N', a.warranty_5
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.warranty_5 IS NOT NULL;
INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Warranty', 'N', a.warranty_6
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.warranty_6 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Warranty', 'N', a.warranty_7
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.warranty_7 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Warranty', 'N', a.warranty_8
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.warranty_8 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Warranty', 'N', a.warranty_9
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.warranty_9 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Warranty', 'N', a.warranty_10
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.warranty_10 IS NOT NULL;

-- 5 Videos
INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Video', 'N', a.video_1
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.video_1 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Video', 'N', a.video_2
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.video_2 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Video', 'N', a.video_3
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.video_3 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Video', 'N', a.video_4
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.video_4 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Video', 'N', a.video_5
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.video_5 IS NOT NULL;

-- 5 Video URLs
INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Video', 'N', a.video_url_1
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.video_url_1 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Video', 'N', a.video_url_2
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.video_url_2 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Video', 'N', a.video_url_3
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.video_url_3 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Video', 'N', a.video_url_4
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.video_url_4 IS NOT NULL;

INSERT INTO public.product_attachment (variant_product_id,type,main,link)
SELECT p.id, 'Video', 'N', a.video_url_5
FROM public.variant_product p, loading.akeneo a
WHERE a.product_hash = p.product_hash
  AND a.video_url_5 IS NOT NULL;
