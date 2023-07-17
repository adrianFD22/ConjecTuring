


InstallGlobalFunction( ProgressBar, function()
  local progbar, i;

  # Attributes
  progbar := rec(current := 0, symbol := "█", length := 50);
  progbar.length := Maximum(10, SizeScreen()[1] - 30);

  # Print the heading
  Print("  Progress: |");
  for i in [1..progbar.length] do
    Print("-");
  od;
  Print("|  0% Complete");
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


InstallGlobalFunction(TestProgressBar, function()
    local progbar, i,
    length, step,
    duration_sec, delay_micro_sec;

    length := 10;
    duration_sec := 5;

    step := Float(1 / length);
    delay_micro_sec := QuoInt(duration_sec * 1000000, length);

    progbar := ProgressBar();

    for i in [1..length-1] do
        UpdateProgressBar(progbar, i * step);
        MicroSleep(delay_micro_sec);
    od;

    EndProgressBar(progbar);
end);
