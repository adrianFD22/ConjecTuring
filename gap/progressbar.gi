


InstallGlobalFunction( ProgressBar, function(more...)
  local progbar, i;

  # Attributes
  progbar := rec(current := 0, symbol := "█", length := 50);
  if Length(more) <> 0 then progbar.length := more[1]; fi;

  # Print the heading
  Print("  Progress: |\c");
  for i in [1..progbar.length] do
    Print("-\c");
  od;
  Print("|  0% Complete\c");
  return progbar;
end);


InstallGlobalFunction( UpdateProgressBar, function(progbar, per)
  local i, show_per;

  progbar.current := per;

  # Update bar
  Print("\r\c"); #Relocate cursor
  Print("  Progress: |\c");
  for i in [1..Int(progbar.current*progbar.length)] do Print(progbar.symbol,"\c"); od;
  for i in [1..progbar.length-Int(progbar.current*progbar.length)] do Print("-\c"); od;
  Print("| \c");

  # Update percentaje
  if Int(progbar.current*100) < 10 then Print(" \c"); fi;
  show_per := Int(progbar.current*100);
  Print(show_per, "\% Complete\c");

  return;
end);


InstallGlobalFunction( EndProgressBar, function(progbar)
  UpdateProgressBar(progbar, 1);
  Print("\n");
end);
