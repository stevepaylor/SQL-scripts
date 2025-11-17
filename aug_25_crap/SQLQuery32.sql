ALTER ROLE viejas_paylors WITH SUPERUSER 

COPY public.countries TO 'E:\PostgreSQL_XFER\countries.csv' WITH (FORMAT CSV, HEADER);

psql -h stay-datawarehouse.onagilysys.com -U viejas_paylors -d stay_prod -c "\copy public.countries TO 'C:\PostgreSQL_XFER\countries.csv' with (format csv);"