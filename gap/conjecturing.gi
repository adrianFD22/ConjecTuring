#
# ConjecTuring: Rudimentary functions to help to check conjectures.
#
# Implementations
#

InstallGlobalFunction( FindCounterexample, function(n, generator, condition, args, more...)
  local i, rem,
  update_ratio, batch, use_bar, progressBar, #Progress bar
  use_loop_index,
  compute_batch, res_batch;

  #----------------------------------------
  #             Prepare variables
  #----------------------------------------
  
  # Optional parameters
  use_loop_index := Length(more) >= 1 and more[1];
  use_bar := Length(more) >= 2 and more[2];

  # Prepare batch length
  update_ratio := 100;
  batch := QuoInt(n, update_ratio);
  rem := n mod update_ratio;

  # Local function: compute each batch of conjecture testing
  compute_batch := function(index_start, index_stop)
    local act_args, act, j;

    for j in [index_start..index_stop] do
      act_args := ShallowCopy(args);
      if use_loop_index then Add(act_args, j, 1); fi; #Use loop index
      act := CallFuncList(generator, act_args);

      if not condition(act) then
        return act;
      fi;
    od;

    return true;
  end;

  #----------------------------------------
  #                  Main
  #----------------------------------------
  
  # Display header
  Print("  ________________________________\n");
  Print("  Finding counterexample ", n, " times \n");
  Print("  - Generator:  ", NameFunction(generator), "\n");
  Print("  - Condition:  ", NameFunction(condition), "\n");
  Print("  - Parameters: ", args, "\n");
  Print("  ________________________________\n\n");

  # Progress bar
  if use_bar then progressBar := ProgressBar(); fi;

  # Test
  for i in [0..update_ratio-1] do
    # Progress bar
    if use_bar then UpdateProgressBar(progressBar, i/update_ratio); fi;

    # Compute batch
    res_batch := compute_batch(i*batch+1, (i+1)*batch);

    # Check if counterexample was found
    if res_batch <> true then 

      # Progress bar
      if use_bar then EndProgressBar(progressBar); fi;

      # Display result
      Print("\n");
      Print("  Result: found counterexample!\n");
      Print("  --> ", res_batch);

      return res_batch;
    fi;
  od;

  # Remainder of tests
  res_batch := compute_batch(update_ratio*batch+1, n);
  if res_batch <> true then 

    # Progress bar
    if use_bar then EndProgressBar(progressBar); fi;

    # Display result
    Print("\n");
    Print("  Result: found counterexample!\n");
    Print("  --> ", res_batch);

    return res_batch;
  fi;

  # Progress bar
  if use_bar then EndProgressBar(progressBar); fi;

  # Display result
  Print("\n");
  Print("  Result: no concluding.\n");

  return "No concluding";
end);


InstallGlobalFunction( CountCounterexamples, function(n, generator, condition, args, more...)
  local i, rem, count,
  update_ratio, batch, use_bar, progressBar, #Progress bar
  use_loop_index,
  compute_batch, res_batch;

  #----------------------------------------
  #             Prepare variables
  #----------------------------------------
  
  # Optional parameters
  use_loop_index := Length(more) >= 1 and more[1];
  use_bar := Length(more) >= 2 and more[2];


  # Prepare batch length
  update_ratio := 100;
  batch := QuoInt(n, update_ratio);
  rem := n mod update_ratio;
  

  # Prepare variable for counterexample counting
  count := 0;

  # Local function: compute each batch of conjecture testing
  compute_batch := function(index_start, index_stop)
    local act_args, act, j;

    for j in [index_start..index_stop] do
      act_args := ShallowCopy(args);
      if use_loop_index then Add(act_args, j, 1); fi; #Use loop index
      act := CallFuncList(generator, act_args);

      if not condition(act) then
        count := count + 1;
      fi;
    od;
  end;

  #----------------------------------------
  #                  Main
  #----------------------------------------
  
  # Display header
  Print("  ________________________________\n");
  Print("  Counting counterexamples ", n, " times \n");
  Print("  - Generator:  ", NameFunction(generator), "\n");
  Print("  - Condition:  ", NameFunction(condition), "\n");
  Print("  - Parameters: ", args, "\n");
  Print("  ________________________________\n\n");

  # Progress bar
  if use_bar then progressBar := ProgressBar(); fi;


  # Test
  for i in [0..update_ratio-1] do
    # Progress bar
    if use_bar then UpdateProgressBar(progressBar, i/update_ratio); fi;

    # Compute batch
    compute_batch(i*batch+1, (i+1)*batch);
  od;

  # Remainder of tests
  compute_batch(update_ratio*batch+1, n);

  # Progress bar
  if use_bar then EndProgressBar(progressBar); fi;

  # Display result
  Print("\n");
  Print("  Result: ", count, " countexamples found!\n");

  return count;
end);


InstallGlobalFunction( MinimumExample, function(n, generator, enumerator, args, more...)
  local i, rem, counterexample_min, counterexample_obj, 
  update_ratio, batch, use_bar, progressBar, #Progress bar
  use_loop_index,
  compute_batch, res_batch;

  #----------------------------------------
  #             Prepare variables
  #----------------------------------------
  
  # Optional parameters
  use_loop_index := Length(more) >= 1 and more[1];
  use_bar := Length(more) >= 2 and more[2];


  # Prepare batch length
  update_ratio := 100;
  batch := QuoInt(n, update_ratio);
  rem := n mod update_ratio;
  

  # Prepare variable for finding the minimum
  counterexample_min := infinity;

  # Local function: compute each batch of conjecture testing
  compute_batch := function(index_start, index_stop)
    local act_args, act, j, act_num;

    for j in [index_start..index_stop] do
      act_args := ShallowCopy(args);
      if use_loop_index then Add(act_args, j, 1); fi; #Use loop index
      act := CallFuncList(generator, act_args);
      
      act_num := enumerator(act);

      if act_num < counterexample_min then
        counterexample_min := act_num;
        counterexample_obj := act;
      fi;
    od;
  end;

  #----------------------------------------
  #                  Main
  #----------------------------------------
  
  # Display header
  Print("  ________________________________\n");
  Print("  Finding the minimum ", n, " times \n");
  Print("  - Generator:  ", NameFunction(generator), "\n");
  Print("  - Enumerator:  ", NameFunction(enumerator), "\n");
  Print("  - Parameters: ", args, "\n");
  Print("  ________________________________\n\n");

  # Progress bar
  if use_bar then progressBar := ProgressBar(); fi;


  # Test
  for i in [0..update_ratio-1] do
    # Progress bar
    if use_bar then UpdateProgressBar(progressBar, i/update_ratio); fi;

    # Compute batch
    compute_batch(i*batch+1, (i+1)*batch);
  od;

  # Remainder of tests
  compute_batch(update_ratio*batch+1, n);

  # Progress bar
  if use_bar then EndProgressBar(progressBar); fi;

  # Display result
  Print("\n");
  Print("  Minimum: ", counterexample_min, ".\n");
  Print("  --> ", counterexample_obj);

  return counterexample_obj;
end);


InstallGlobalFunction( MaximumExample, function(n, generator, enumerator, args, more...)
  local i, rem, counterexample_max, counterexample_obj, 
  update_ratio, batch, use_bar, progressBar, #Progress bar
  use_loop_index,
  compute_batch, res_batch;

  #----------------------------------------
  #             Prepare variables
  #----------------------------------------
  
  # Optional parameters
  use_loop_index := Length(more) >= 1 and more[1];
  use_bar := Length(more) >= 2 and more[2];


  # Prepare batch length
  update_ratio := 100;
  batch := QuoInt(n, update_ratio);
  rem := n mod update_ratio;
  

  # Prepare variable for finding the minimum
  counterexample_max := -infinity;

  # Local function: compute each batch of conjecture testing
  compute_batch := function(index_start, index_stop)
    local act_args, act, j, act_num;

    for j in [index_start..index_stop] do
      act_args := ShallowCopy(args);
      if use_loop_index then Add(act_args, j, 1); fi; #Use loop index
      act := CallFuncList(generator, act_args);
      
      act_num := enumerator(act);

      if act_num > counterexample_max then
        counterexample_max := act_num;
        counterexample_obj := act;
      fi;
    od;
  end;

  #----------------------------------------
  #                  Main
  #----------------------------------------
  
  # Display header
  Print("  ________________________________\n");
  Print("  Finding the maximum ", n, " times \n");
  Print("  - Generator:  ", NameFunction(generator), "\n");
  Print("  - Enumerator:  ", NameFunction(enumerator), "\n");
  Print("  - Parameters: ", args, "\n");
  Print("  ________________________________\n\n");

  # Progress bar
  if use_bar then progressBar := ProgressBar(); fi;


  # Test
  for i in [0..update_ratio-1] do
    # Progress bar
    if use_bar then UpdateProgressBar(progressBar, i/update_ratio); fi;

    # Compute batch
    compute_batch(i*batch+1, (i+1)*batch);
  od;

  # Remainder of tests
  compute_batch(update_ratio*batch+1, n);

  # Progress bar
  if use_bar then EndProgressBar(progressBar); fi;

  # Display result
  Print("\n");
  Print("  Maximum: ", counterexample_max, ".\n");
  Print("  --> ", counterexample_obj);

  return counterexample_obj;
end);