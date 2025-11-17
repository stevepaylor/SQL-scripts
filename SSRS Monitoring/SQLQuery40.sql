select count(*) 
from ReportServer.dbo.[Subscriptions] S 
where 0 = case 
          when S.[LastStatus] = 'New Subscription' then 1 
          when substring(S.[LastStatus],1,9) = 'Mail Sent' then 1 
          when substring(S.[LastStatus],1,5) = 'Done:' 
           and right(S.[LastStatus],9) = '0 errors.' then 1 
          when substring(S.[LastStatus],1,9) = 'The file ' 
           and patindex('%has been saved to the%',S.[LastStatus]) > 1 
           and right(S.[LastStatus],11) = 'file share.' then 1 
          else 0 
      end