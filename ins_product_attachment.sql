-- Need to delete any attachment that the product matches in the akeneo table
delete from public.product_attachment where product_id in (
select p.id from public.product p, loading.akeneo a
where p.product_hash = a.product_hash );
--and a.item_type = 'item_type_product');

delete from public.product_attachment where option_product_id in (
select p.id from public.option_product p, loading.akeneo a
where p.product_hash = a.product_hash );

delete from public.product_attachment where variant_product_id in (
select p.id from public.variant_product p, loading.akeneo a
where p.product_hash = a.product_hash );

-- 5 images
insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Image', 'Y', a.primary_image
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.primary_image is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Image', 'N', a.image_secondary_1
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.image_secondary_1 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Image', 'N', a.image_secondary_2
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.image_secondary_2 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Image', 'N', a.image_secondary_3
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.image_secondary_3 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Image', 'N', a.image_secondary_4
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.image_secondary_4 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Image', 'N', a.image_secondary_5
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.image_secondary_5 is NOT NULL;

-- 10 manuals
insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Manual', 'N', a.manual
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.manual is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Manual', 'N', a.manual_2
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.manual_2 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Manual', 'N', a.manual_3
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.manual_3 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Manual', 'N', a.manual_4
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.manual_4 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Manual', 'N', a.manual_5
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.manual_5 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Manual', 'N', a.manual_6
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.manual_6 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Manual', 'N', a.manual_7
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.manual_7 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Manual', 'N', a.manual_8
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.manual_8 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Manual', 'N', a.manual_9
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.manual_9 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Manual', 'N', a.manual_10
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.manual_10 is NOT NULL;

-- 10 Brochures
insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Brochure', 'N', a.brochure
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.brochure is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Brochure', 'N', a.brochure_2
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.brochure_2 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Brochure', 'N', a.brochure_3
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.brochure_3 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Brochure', 'N', a.brochure_4
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.brochure_4 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Brochure', 'N', a.brochure_5
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.brochure_5 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Brochure', 'N', a.brochure_6
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.brochure_6 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Brochure', 'N', a.brochure_7
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.brochure_7 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Brochure', 'N', a.brochure_8
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.brochure_8 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Brochure', 'N', a.brochure_9
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.brochure_9 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Brochure', 'N', a.brochure_10
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.brochure_10 is NOT NULL;

-- 10 Spec Sheets
insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Spec Sheet', 'N', a.spec_sheet_file
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.spec_sheet_file is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Spec Sheet', 'N', a.spec_sheet_file_2
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.spec_sheet_file_2 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Spec Sheet', 'N', a.spec_sheet_file_3
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.spec_sheet_file_3 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Spec Sheet', 'N', a.spec_sheet_file_4
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.spec_sheet_file_5 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Spec Sheet', 'N', a.spec_sheet_file_6
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.spec_sheet_file_6 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Spec Sheet', 'N', a.spec_sheet_file_7
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.spec_sheet_file_7 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Spec Sheet', 'N', a.spec_sheet_file_8
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.spec_sheet_file_8 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Spec Sheet', 'N', a.spec_sheet_file_9
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.spec_sheet_file_9 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'spec sheet', 'N', a.spec_sheet_file_10
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.spec_sheet_file_10 is NOT NULL;

-- 10 Warranties
insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Warranty', 'N', a.warranty
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.warranty is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Warranty', 'N', a.warranty_2
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.warranty_2 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Warranty', 'N', a.warranty_3
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.warranty_3 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Warranty', 'N', a.warranty_4
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.warranty_4 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Warranty', 'N', a.warranty_5
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.warranty_5 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Warranty', 'N', a.warranty_6
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.warranty_6 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Warranty', 'N', a.warranty_7
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.warranty_7 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Warranty', 'N', a.warranty_8
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.warranty_8 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Warranty', 'N', a.warranty_9
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.warranty_9 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Warranty', 'N', a.warranty_10
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.warranty_10 is NOT NULL;

-- 5 Videos
insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Video', 'N', a.video_1
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.video_1 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Video', 'N', a.video_2
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.video_2 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Video', 'N', a.video_3
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.video_3 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Video', 'N', a.video_4
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.video_4 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Video', 'N', a.video_5
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.video_5 is NOT NULL;

-- 5 Video URLs
insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Video', 'N', a.video_url_1
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.video_url_1 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Video', 'N', a.video_url_2
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.video_url_2 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Video', 'N', a.video_url_3
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.video_url_3 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Video', 'N', a.video_url_4
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.video_url_4 is NOT NULL;

insert into public.product_attachment (product_id,type,main,link)
select p.id, 'Video', 'N', a.video_url_5
from public.product p, loading.akeneo a
where a.product_hash = p.product_hash
  and a.video_url_5 is NOT NULL;
