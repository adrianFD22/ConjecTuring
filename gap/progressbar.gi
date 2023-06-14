

# Init progress bar
InstallGlobalFunction( ProgressBar, function(more...)
    local progbar, i;

  # Attributes
    progbar := rec(current := 0, symbol := "█", length := 50);
    if Length(more) <> 0 then progbar.length := more[1]; fi;

  # Print the heading
    Print("            ");
    for i in [1..progbar.length] do
        Print("_");
    od;
    Print("\n  Progress: ");
    Print("\c");
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
