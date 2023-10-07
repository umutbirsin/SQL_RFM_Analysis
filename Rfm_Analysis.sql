create database rfm_e_commerce

create table RFM
(
	invoice_no varchar,
	stock_code	varchar,
	description	varchar,
	quantity	integer,
	invoice_date	timestamp,
	unit_price	float,
	customer_id	integer,
	country		varchar

)
;

copy rfm from '/Library/PostgreSQL/15/bin/e_commerce_data_.csv' delimiter ',' csv header

select*from rfm
select invoice_no , count (invoice_no)from rfm group by 1 order by 2 desc
select* from rfm where invoice_no='549120'
select count (customer_id) from rfm where customer_id is null
select max(invoice_date) from rfm
select customer_id, invoice_date from rfm order by 2 desc
select count (distinct invoice_no) from rfm where customer_id is null
--RECENCY COUNT
SELECT customer_id,
		max(invoice_date) as last_order_date,
		(select max(invoice_date) from rfm) as last_day,
		('2011-12-09 12:50:00'::timestamp)-max(invoice_date) as day_diff,
		extract (day from(('2011-12-09 12:50:00'::timestamp)-max(invoice_date))) as recency
		from rfm
		where customer_id is not null
		group by 1
		order by 2
--FREQUENCY COUNT
select customer_id,
		count(distinct invoice_no) as frequency
		from rfm
		where customer_id is not null
		group by 1
		order by 2 desc
		
--MONETARY COUNT

SELECT customer_id,
		round ((sum(unit_price))) as monetary
		from rfm
		group by 1 
		order by 2 desc


--RFM ANALYSIS		
with recency as 
(
	SELECT customer_id,
		max(invoice_date) as last_order_date,
		(select max(invoice_date) from rfm) as last_day,
		('2011-12-09 12:50:00'::timestamp)-max(invoice_date) as day_diff,
		extract (day from(('2011-12-09 12:50:00'::timestamp)-max(invoice_date))) as recency
		from rfm
		group by 1
		order by 2
), frequency as 
(
select customer_id,
		count(distinct invoice_no) as frequency
		from rfm
		where customer_id is not null
		group by 1
		order by 2 desc
),monetary as 

(
SELECT customer_id,
		round ((sum(unit_price))) as monetary
		from rfm
		where customer_id is not null
		group by 1 
		order by 2 desc
),rfm as (

select 	r.customer_id,
		r.recency,
	 (case when recency  between 0 and 14 then 5 
	 	when recency  between 15 and 31 then 4 
		when recency  between 32 and 90 then 3 
		when recency  between 91 and 180 then 2
		 when recency>=181 then 1 end ) as recency_point,
	f.frequency,
		(case when frequency  between 0 and 1 then 1 
		when frequency  between 2 and 5 then 2 
		when frequency  between 6 and 15 then 3 
	 	when frequency  between 16 and 40 then 4
		when frequency>=41 then 5 end) as frequency_point,
	m.monetary,
	(case when monetary  between 0 and 50 then 1 
		when monetary  between 51 and 250 then 2 
		 when monetary  between 251 and 1000 then 3 
		 when monetary  between 1001 and 2499 then 4
		 when monetary>=2500 then 5 end) as monetary_point
from recency as r 
inner join frequency as f on r.customer_id=f.customer_id
inner join monetary as m on r.customer_id=m.customer_id
)

select customer_id,
		recency_point,
		frequency_point,
		monetary_point
		from rfm
		order by 2 desc ,3 desc,4 desc