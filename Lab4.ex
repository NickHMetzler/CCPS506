# Lab4.ex
# Nicolas Metzler
# Student ID: 501050712
# Lab #4 - Elixir: Tail recursion
# CPS 506 Section 610
# Instructor: A. Ufkes
# Purpose: Write tail recursive functions in Elixir
#
# I hereby attest that I am the sole owner and author of this code (except for variable names provided by Prof. Ufkes) and that to the best of my knowledge, this code has not infringed on anyone’s copyright. Credit for any ideas, coding, and other materials used to develop this code has been given to the owners of the sources used in accordance to the rules of Ryerson's Academic Integrity Policy.

#Lab 4 Module
defmodule Lab4 do
    #Import necessary functions in Elixir
    import Integer
    import List


    #####################################
    # sumEven Functions                 #
    #####################################
    def sumEven(list) do
        #Start the tail recursive sumEven() function on the provided list
        sumEven(list, 0)
    end

    def sumEven([], acc) do
        #There are no more items in the list, return the accumulator
        acc
    end

    def sumEven(list, acc) do
        #Split list into Head and Tail
        [head|tail] = list
        #Tail recursion
        cond do
            #If the item is an even integer, add to the accumulator and recurse
            is_integer(head) == true && is_even(head) == true -> sumEven(tail, acc + head)
            #If the item is not an even integer, recurse
            true -> sumEven(tail, acc)
        end
    end

    #####################################
    # sumNum Functions                  #
    #####################################
    def sumNum() do
        0
    end

    def sumNum(list) do
        #Start the tail recursive sumNum() function on the provided list
        sumNum(list, 0)
    end

    def sumNum([], acc) do
        #There are no more items in the list, return the accumulator
        acc
    end

    def sumNum(list, acc) do
        #Split list into Head and Tail
        [head|tail] = list
        #Tail recursion
        cond do
            #If the item is an integer or a float, add to the accumulator and recurse
            (is_integer(head) == true || is_float(head) == true) -> sumNum(tail, acc + head)
            #If the item is not an integer or a float, recurse
            true -> sumNum(tail, acc)
        end
    end

    #####################################
    # tailFib Functions                 #
    #####################################
    def tailFib(n) do
        #Take the given value and send it off to the tailFibonacci function to be calculated
        tailFib(n, 0, 1)
    end

    def tailFib(1, num1, num2) do
        #Return the result of the Fibonacci sequence
        num2
    end

    def tailFib(n, num1, num2) do
        #Run the Fibonacci sequence over until n = 1
        tailFib(n-1, num2, num1 + num2)
    end

    #####################################
    # reduce Functions                  #
    #####################################
    def reduce(list, func) do
        #Take the head and tail of the list
        [head|tail] = list
        #Call the reduce function, using the head as the first value/accumulator
        reduce(tail, head, func)
    end

    def reduce([], acc, func) do
        #There are no more items in the list, return the accumulator
        acc
    end

    def reduce(list, acc, func) do
        #Take the head and tail of the list
        [head|tail] = list
        #Tail recursion, append the accumulator based on the function
        reduce(tail, func.(head, acc), func)
    end
end
