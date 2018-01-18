#!/usr/bin/awk -f
{ record = record $0
  # If number of quotes is odd, continue reading record.
  if ( gsub( /"/, "&", record ) % 2 )
  { record = record " "
    next
  }
}
{ print record
  record = ""
}

