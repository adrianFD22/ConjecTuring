
#-------------------------------------------------------------------------------
#                                example1
#-------------------------------------------------------------------------------

# The condition to check
IsEven := function(n)
    return n mod 2 = 0;
end;

#-------------------------------------------------------------------------------


# Read generators files
Read("example_generators.g");; #Be sure to be in the correct directory


# Parameters
n := 1000;;  #Number of times to evaluate the conjecture
generator := SequenceGenerator;;  #Generator function
params := [];;  #Parameters for the generator

# Optional parameters
loop_index := true;  #Use the iteration index as an argument for the generator
show_progress_bar := false;  #Show the progress bar


# Test the conjecture:
result := FindCounterexample(n, generator, IsEven, params, loop_index, show_progress_bar);;