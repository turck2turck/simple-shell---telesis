UPDATE loading.manufacturer_address SET mfr_id=(select id from public.manufacturer where mfr_abbreviation = mfr_abbr)
