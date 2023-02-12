
#-------------------------------------------------------------------------------
#                                conjecture_name
#-------------------------------------------------------------------------------

# The condition to check
conjecture_name := function()
    local ;


    return ;
end;

#-------------------------------------------------------------------------------


# Parameters
n := 1;;  #Number of times to evaluate the conjecture
generator := ;;  #Generator function
params := [];;  #Parameters for the generator

# Settings
loop_index := false;  #Use the iteration index as an argument for the generator
show_progress_bar := false;  #Show the progress bar


# Test the conjecture: replace FuncExample
result := FuncExample(n, generator, conjecture_name, params, loop_index, show_progress_bar);;