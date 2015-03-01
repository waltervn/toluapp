function assert (status,msg) 
   if not status then 
      error("ERROR: " .. (msg or "assertion failed"),2) 
   end 
end

