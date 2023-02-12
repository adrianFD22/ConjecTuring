
#-------------------------------------------------------------------------------
#                              Example generators
#-------------------------------------------------------------------------------


SequenceGenerator := function(i)
  return i;
end;


EvenSequenceGenerator := function(i)
  return i*2;
end;


SequenceGeneratorShifted := function(i, start_at)
  return i + start_at-1;
end;