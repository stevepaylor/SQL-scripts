SELECT * FROM OPENQUERY(Stay_PostgreSQL,
'SELECT public.night_audit_trail_balance(''2090'', ''741'', cast(''2025-08-13'' as date), 1, 1)') ;