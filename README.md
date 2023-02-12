# The GAP package ConjecTuring

> DISCLAIMER: the package's name is much cooler than the package itself.

This package provides a few functions to deal with conjecture testing in an simple way:

- **FindCounterexample**: returns the first counterxample found.
- **CountCounterexamples**: returns the number of counterexamples.
- **MinimumExample**: returns the object which has minimum value given by a determined function.
- **MaximumExample**: returns the object which has maximum value given by a determined function

The four of them proceed very similiarly. They get a conjecture to test and iterate over the objects for which to test it.

The paradigm is the following one. Imagine you want to test a conjecture represented by a GAP function called **condition**. This function must receive an arbitrary object (a number, a group, a ring...) as a parameter for which to test the conjecture and will return true or false depending if this object satisfies or not the conjecture. The objects for which to test the conjecture will be given by another GAP function called **generator**. This one will generate objects based on its arguments.

## How to use

Let **FuncExample** be one of the four functions above to perform conjecture testing. This is the heading of the function and its parameters:
``` 
FuncExample(n, generator, condition, args, use_index_loop, use_bar);
```
- **n**: number of tests to execute, i.e, number of iterations to loop.
- **generator**: a function returning an object for which to test the conjecture at each iteration.
- **condition**: a function encoding the conjecture to test returning true or false if the conjecture it holds or not, respectively.
- **args**: a list with the arguments to be given to the generator (use an empty list if no arguments are needed).
- **use_index_loop**: a boolean value indicating whether or not generator will receive the loop index as a parameter. By default assigned to false.
- **use_bar**: a boolean indicating wheter or not to display a progress bar to track the completion of the task. By default assigned to false.

The parameter **condition** is replaced by **enumerator** in the function **MinimumExample** and **MaximumExample**. The function **enumerator** will require an object as an argument and will return a number.

## Usage tips

- Create GAP files to store your generator functions. Maybe you have multiple conjectures over the same group of objects (conjectures over finite groups, conjectures over rational numbers...) and it will help you to reuse your code and not writing a generator each time.

- Create templates to perform conjecture testing. Check out the ones in the *examples* folder.

## Contact

I'm Adrián Fidalgo-Díaz. If you have any suggestions or whatever, feel free to contact me at adrianfd22399@gmail.com.
