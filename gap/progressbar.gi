

# Init progress bar
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

# Update progress bar
InstallGlobalFunction( UpdateProgressBar, function(progbar, per)
    local i,
    current_length, new_length, diff_length;

    # Get the current length and the new length
    current_length := Int(progbar.length * progbar.current);
    new_length := Int(progbar.length * per);

    # Get the difference
    diff_length := new_length - current_length;

    # Update the bar
    for i in [1..diff_length] do
        Print(progbar.symbol);
    od;

    Print("\c");
    progbar.current := per;

    return;
end);

# End progress bar
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
