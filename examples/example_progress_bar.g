

#-------------------------------------------------------------------------------
#                                example progress bar
#-------------------------------------------------------------------------------

# The condition to check
LazyTrueCondition := function(n)
    Sleep (1);
    return true;
end;

#-------------------------------------------------------------------------------


# Read generators files
Read("example_generators.g");; #Be sure to be in the correct directory


# Parameters
n := 30;;  #Number of times to evaluate the conjecture
generator := SequenceGenerator;;  #Generator function
params := [];;  #Parameters for the generator

# Optional parameters
loop_index := true;  #Use the iteration index as an argument for the generator
show_progress_bar := true;  #Show the progress bar


# Test the conjecture:
result := FindCounterexample(n, generator, LazyTrueCondition, params, loop_index, show_progress_bar);;
