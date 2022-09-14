# Lab3.ex
# Nicolas Metzler
# Student ID: 501050712
# Lab #3 - Elixir: Lists and Expressions
# CPS 506 Section 610
# Instructor: A. Ufkes
# Purpose: Write Elixir functions that operate on lists without explicit looping or branching
#
# I hereby attest that I am the sole owner and author of this code (except for variable names provided by Prof. Ufkes) and that to the best of my knowledge, this code has not infringed on anyone’s copyright. Credit for any ideas, coding, and other materials used to develop this code has been given to the owners of the sources used in accordance to the rules of Ryerson's Academic Integrity Policy.

#Lab 3 Module
defmodule Lab3 do
    #Import necessary functions in Elixir
    import Integer
    import List
    
    def first_two(list) do
        #Grab the first element
        [head | tail] = list
        first_element = head

        #grab the second element
        [head | tail] = tail
        second_element = head

        #Compare and return
        first_element == second_element
    end    

    
    def even_size(list) do
        #Get size of list and check if even
        size = length(list)
        is_even(size)
    end   


    def front_back(list) do
        #Take head of list, make it a list, and add it to the back
        #This has to be done due to Elixir using linked lists
        [head | tail] = list
        new_list = tail ++ [head]
        new_list
    end   


    def next_nine_nine(list) do
        #Take the tail of the list and place 99 at the front
        [head | tail] = list
        tail_list = [99 | tail]
        
        #Add head back on the top of the list
        new_list = [head | tail_list]
        new_list
    end 


    def is_coord(list) do
        #get size of list and first element
        size = length(list)
        [head | tail] = list
        first_element = head

        #Get the second element from the top of the tail
        [head | tail] = tail
        second_element = head

        #Check for length of 2 AND if both elements are a number (integer or float)
        size == 2 && ((is_integer(first_element) && is_integer(second_element)) || (is_float(first_element) && is_float(second_element)) || (is_integer(first_element) && is_float(second_element)) || (is_float(first_element) && is_integer(second_element)))
    end


    def hello_if_so(list) do
        #Remove "Hello" from the list if it exists, do nothing if it doesn't
        removed_hello = delete(list, "Hello")

        #Add "Hello" to the end of the new list
        new_list = removed_hello ++ ["Hello"]
        new_list
    end

end