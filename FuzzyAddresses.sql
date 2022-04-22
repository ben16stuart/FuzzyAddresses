Select distinct
o.business_name,
l.license_number,
l2.license_number,
l.physical_address||' '||l.physical_city||' '||l.physical_state||' '||l.physical_zip address1, 
l2.physical_address||' '||l2.physical_city||' '||l2.physical_state||' '||l2.physical_zip matchaddress2

from mylo.license l 
join mylo.recursive_ownership o on o.business = l.license_number
join mylo.license l2 on regexp_replace(l.physical_address||l.physical_city||l.physical_state||l.physical_zip, '[^a-zA-Z0-9]+', '','g')<> 
				regexp_replace(l2.physical_address||l2.physical_city||l2.physical_state||l2.physical_zip, '[^a-zA-Z0-9]+', '','g')
	and levenshtein(regexp_replace(l.physical_address||l.physical_city||l.physical_state||l.physical_zip, '[^a-zA-Z0-9]+', '','g'),
				regexp_replace(l2.physical_address||l2.physical_city||l2.physical_state||l2.physical_zip, '[^a-zA-Z0-9]+', '','g')) <2 

join mylo.recursive_ownership o2 on o2.business = l2.license_number
where o2.business_name = o.business_name
