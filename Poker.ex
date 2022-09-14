# Poker.ex
# Nicolas Metzler and Saba Zubair
# Student ID's (respectively): 501050712 and 500711970
# Poker Assignment
# CPS 506 Section 610
# Instructor: A. Ufkes
# Purpose: Write a program that takes a deck, deals, and decides the winner of a Poker game
#
# We hereby attest that we are the sole owners and authors of this code and that to the best of our knowledge, this code has not infringed on anyone’s copyright. Credit for any ideas, coding, and other materials used to develop this code has been given to the owners of the sources used in accordance to the rules of Ryerson's Academic Integrity Policy.

# Poker Module
defmodule Poker do
  IO.puts "\nPoker.ex\nCreated by Nicolas Metzler (501050712) and Saba Zubair (500711970)\nCPS 506 Section 610\nInstructor: A. Ufkes\n\nWe hereby attest that we are the sole owners and authors of this code and that to the best of our knowledge, this code has not infringed on anyone’s copyright. Credit for any ideas, coding, and other materials used to develop this code has been given to the owners of the sources used in accordance to the rules of Ryerson's Academic Integrity Policy.\n\n"
  ##################################################
  # Deal Function                                  #
  ##################################################
  def deal(deck) do

    # Deal hands
    hand1 = hand1(deck, [])
    hand2 = hand2(deck, [])
    pool = pool(deck, [])

    # Find the winning hand
    winningHand = cond do
      # Check for Royal Flush
      royalFlush(pool, hand1) != 0 && royalFlush(pool, hand2) != 0 -> ["Split the Pot"]
      royalFlush(pool, hand1) != 0 && royalFlush(pool, hand2) == 0 -> returnInfo(royalFlush(pool, hand1), [])
      royalFlush(pool, hand1) == 0 && royalFlush(pool, hand2) != 0 -> returnInfo(royalFlush(pool, hand2), [])
      # Check for Straight Flush
      straightFlush(pool, hand1) != 0 && straightFlush(pool, hand2) != 0 -> returnInfo(tieBreakHand(hand1, hand2, straightFlush(pool, hand2), straightFlush(pool, hand2)), [])
      straightFlush(pool, hand1) != 0 && straightFlush(pool, hand2) == 0 -> returnInfo(straightFlush(pool, hand1), [])
      straightFlush(pool, hand1) == 0 && straightFlush(pool, hand2) != 0 -> returnInfo(straightFlush(pool, hand2), [])
      # Check for Four of a Kind
      fourOfAKind(pool, hand1) != 0 && fourOfAKind(pool, hand2) != 0 -> returnInfo(tieBreakHand(hand1, hand2, fourOfAKind(pool, hand2), fourOfAKind(pool, hand2)), [])
      fourOfAKind(pool, hand1) != 0 && fourOfAKind(pool, hand2) == 0 -> returnInfo(fourOfAKind(pool, hand1), [])
      fourOfAKind(pool, hand1) == 0 && fourOfAKind(pool, hand2) != 0 -> returnInfo(fourOfAKind(pool, hand2), [])
      # Check for Full House
      fullHouse(pool, hand1) != 0 && fullHouse(pool, hand2) != 0 -> returnInfo(tieBreakHand(hand1, hand2, fullHouse(pool, hand1), fullHouse(pool, hand2)), [])
      fullHouse(pool, hand1) != 0 && fullHouse(pool, hand2) == 0 -> returnInfo(fullHouse(pool, hand1), [])
      fullHouse(pool, hand1) == 0 && fullHouse(pool, hand2) != 0 -> returnInfo(fullHouse(pool, hand2), [])
      # Check for Flush
      flush(pool, hand1) != 0 && flush(pool, hand2) != 0 -> returnInfo(tieBreakHand(hand1, hand2, flush(pool, hand2), flush(pool, hand2)), [])
      flush(pool, hand1) != 0 && flush(pool, hand2) == 0 -> returnInfo(flush(pool, hand1), [])
      flush(pool, hand1) == 0 && flush(pool, hand2) != 0 -> returnInfo(flush(pool, hand2), [])
      # Check for Straight
      straight(pool, hand1) != 0 && straight(pool, hand2) != 0 -> returnInfo(tieBreakHand(hand1, hand2, straight(pool, hand2), straight(pool, hand2)), [])
      straight(pool, hand1) != 0 && straight(pool, hand2) == 0 -> returnInfo(straight(pool, hand1), [])
      straight(pool, hand1) == 0 && straight(pool, hand2) != 0 -> returnInfo(straight(pool, hand2), [])
      # Check for Three of a Kind
      trio(pool, hand1) != 0 && trio(pool, hand2) != 0 -> returnInfo(tieBreakHand(hand1, hand2, trio(pool, hand1), trio(pool, hand2)), [])
      trio(pool, hand1) != 0 && trio(pool, hand2) == 0 -> returnInfo(trio(pool, hand1), [])
      trio(pool, hand1) == 0 && trio(pool, hand2) != 0 -> returnInfo(trio(pool, hand2), [])
      # Check for Two Pairs
      twoPairs(pool, hand1) != 0 && twoPairs(pool, hand2) != 0 -> returnInfo(tieBreakHand(hand1, hand2, twoPairs(pool, hand2), twoPairs(pool, hand2)), [])
      twoPairs(pool, hand1) != 0 && twoPairs(pool, hand2) == 0 -> returnInfo(twoPairs(pool, hand1), [])
      twoPairs(pool, hand1) == 0 && twoPairs(pool, hand2) != 0 -> returnInfo(twoPairs(pool, hand2), [])
      # Check for Pairs
      pair(pool, hand1) != 0 && pair(pool, hand2) != 0 -> returnInfo(tieBreakHand(hand1, hand2, pair(pool, hand1), pair(pool, hand2)), [])
      pair(pool, hand1) != 0 && pair(pool, hand2) == 0 -> returnInfo(pair(pool, hand1), [])
      pair(pool, hand1) == 0 && pair(pool, hand2) != 0 -> returnInfo(pair(pool, hand2), [])
      # Check for High Card
      highCard(hand1, hand2) != 0 ->  returnInfo(highCard(hand1, hand2), [])
      true -> 0
    end
    # Return the formatted winning hand
    winningHand
  end

  ##################################################
  # Creation of Hands and Pool                     #
  ##################################################
  # Create Hand 1
  def hand1(deck, hand) do
    lenHand = length(hand)
    lenDeck = length(deck)
    [head|tail] = deck
    cond do
      lenHand < 2 && (lenDeck == 7 || lenDeck == 9) -> hand1(tail, hand ++ [head])
      lenHand < 2 && (lenDeck != 7 || lenDeck != 9) -> hand1(tail, hand)
      lenHand == 2 -> hand
      true -> IO.puts "Error on Hand1"
    end
  end

  # Create Hand 2
  def hand2(deck, hand) do
    lenHand = length(hand)
    lenDeck = length(deck)
    [head|tail] = deck
    cond do
      lenHand < 2 && (lenDeck == 6 || lenDeck == 8) -> hand2(tail, hand ++ [head])
      lenHand < 2 && (lenDeck != 6 || lenDeck != 8) -> hand2(tail, hand)
      lenHand == 2 -> hand
      true -> IO.puts "Error on Hand2"
    end
  end

  # Create Pool
  def pool(deck, pool) do
    lenPool = length(pool)
    lenDeck = length(deck)
    [head|tail] = deck
    cond do
      lenPool == 4 -> pool(tail ++ [1], pool ++ [head])
      lenPool < 5 && lenDeck <= 5 -> pool(tail, pool ++ [head])
      lenPool < 5 && lenDeck > 5 -> pool(tail, [])
      lenPool == 5 -> pool
      true -> IO.puts "Error on Pool"
    end
  end


  ##################################################
  # Tie Breaker Functions                          #
  ##################################################

  # Break tie by value of card in hand
  def tieBreakHand(hand1, hand2, hand1Sol, hand2Sol) do
    # we need only test 1 element from each
    head1 = hd(Enum.reverse(Enum.sort(makeSame(hand1, []))))
    card1 = head1
    head2 = hd(Enum.reverse(Enum.sort(makeSame(hand2, []))))
    card2 = head2
    cond do
      aceChecker(hand1) == true && aceChecker(hand2) == false -> hand1Sol
      aceChecker(hand1) == false && aceChecker(hand2) == true -> hand2Sol
      rankCheck(card1) > rankCheck(card2) -> hand1Sol
      rankCheck(card1) < rankCheck(card2) -> hand2Sol
      true -> IO.puts "Error on tieBreakHand"
    end
  end

  # Check for Ace
  def aceChecker(hand1) do
    head = hd(Enum.sort(hand1))
    if head == 1 || head == 14 || head == 27 || head == 40 do
      true
    else
      false
    end
  end

  def aceCheckerCard(card) do
    if card == 1 || card == 14 || card == 27 || card == 40 do
      true
    else
      false
    end
  end

  # Set cards to a number 1-13 for easier comparison
  def rankCheck(card) do
    cond do
      card > 0 && card < 14 -> card
      card > 13 && card < 27 -> card - 13
      card > 26 && card < 40 -> card - 26
      card > 39 && card < 53 -> card - 39
      true -> IO.puts "Error on rankCheck"
    end
  end

  ##################################################
  # Hand Checking                                  #
  ##################################################
  # Royal Flush Main Function
  def royalFlush(pool, hand) do
    # Set flush conditions
    flush1 = [1, 10, 11, 12, 13]
    flush2 = [14, 23, 24, 25, 26]
    flush3 = [27, 36, 37, 38, 39]
    flush4 = [40, 49, 50, 51, 52]

    # Set checked lists
    checkList1 = checkForCards(flush1, pool, [])
    checkList2 = checkForCards(flush2, pool, [])
    checkList3 = checkForCards(flush3, pool, [])
    checkList4 = checkForCards(flush4, pool, [])

    # How many elements of each flush does the pool contain
    acc1 = length(checkList1)
    acc2 = length(checkList2)
    acc3 = length(checkList3)
    acc4 = length(checkList4)

    # Check which flush it could contain
    chosenFlush = cond do
      acc1 >=3 && acc1 <= 4 -> flush1
      acc2 >=3 && acc2 <= 4 -> flush2
      acc3 >=3 && acc3 <= 4 -> flush3
      acc4 >=3 && acc4 <= 4 -> flush4
      true -> 0
    end

    if chosenFlush != 0 do
      #Check what card(s) the hand needs
      neededCards = absentCards(chosenFlush, pool, [])
      # If we have a Royal Flush, return it
      if checkForCards(neededCards, hand, []) == neededCards do
        chosenFlush
      else
        # If we don't have a Royal Flush, return 0
        0
      end
    else
      # No flush is possible, return 0
      0
    end

  end

  # Straight Flush Main Function
  def straightFlush(pool, hand) do
    # Check for flush in old Pool
    oldPoolFlushCheck = checkConsecutive(Enum.sort(pool), [], 0)
    tail = tl(pool)
    newPool = Enum.sort(tail ++ hand)
    newerPool = Enum.sort(List.delete_at(pool, length(pool)-1) ++ hand)
    newestPool = Enum.sort(pool ++ hand)
    newPoolFlushCheck = cond do
      length(oldPoolFlushCheck) == 5 && length(checkConsecutive(newPool, [], 0)) == 5 -> checkConsecutive(newPool, [], 0)
      length(oldPoolFlushCheck) == 5 && length(checkConsecutive(newPool, [], 0)) != 5 -> checkConsecutive(newerPool, [], 0)
      true -> checkConsecutive(newestPool, [], 0)
    end
    cond do
      # Return flush if it exists
      length(newPoolFlushCheck) == 5 -> newPoolFlushCheck
      # No flush is found, return 0
      true -> 0
    end
  end

  #Four of a Kind Main Function
  def fourOfAKind(pool, hand) do
    # Set group conditions
    kind1 = [1, 14, 27, 40]
    kind2 = [2, 15, 28, 41]
    kind3 = [3, 16, 29, 42]
    kind4 = [4, 17, 30, 43]
    kind5 = [5, 18, 31, 44]
    kind6 = [6, 19, 32, 45]
    kind7 = [7, 20, 33, 46]
    kind8 = [8, 21, 34, 47]
    kind9 = [9, 22, 35, 48]
    kind10 = [10, 23, 36, 49]
    kind11 = [11, 24, 37, 50]
    kind12 = [12, 25, 38, 51]
    kind13 = [13, 26, 39, 52]

    # How many elements of each kind does the pool contain
    acc1 = length(checkForCards(kind1, pool, []))
    acc2 = length(checkForCards(kind2, pool, []))
    acc3 = length(checkForCards(kind3, pool, []))
    acc4 = length(checkForCards(kind4, pool, []))
    acc5 = length(checkForCards(kind5, pool, []))
    acc6 = length(checkForCards(kind6, pool, []))
    acc7 = length(checkForCards(kind7, pool, []))
    acc8 = length(checkForCards(kind8, pool, []))
    acc9 = length(checkForCards(kind9, pool, []))
    acc10 = length(checkForCards(kind10, pool, []))
    acc11 = length(checkForCards(kind11, pool, []))
    acc12 = length(checkForCards(kind12, pool, []))
    acc13 = length(checkForCards(kind13, pool, []))

    # How many elements of each kind does each hand contain?
    hand1 = length(checkForCards(kind1, hand, []))
    hand2 = length(checkForCards(kind2, hand, []))
    hand3 = length(checkForCards(kind3, hand, []))
    hand4 = length(checkForCards(kind4, hand, []))
    hand5 = length(checkForCards(kind5, hand, []))
    hand6 = length(checkForCards(kind6, hand, []))
    hand7 = length(checkForCards(kind7, hand, []))
    hand8 = length(checkForCards(kind8, hand, []))
    hand9 = length(checkForCards(kind9, hand, []))
    hand10 = length(checkForCards(kind10, hand, []))
    hand11 = length(checkForCards(kind11, hand, []))
    hand12 = length(checkForCards(kind12, hand, []))
    hand13 = length(checkForCards(kind13, hand, []))

    # Check which four it contains and return the result
    cond do
      (acc1 == 3 && hand1 == 1) || (acc1 == 2 && hand1 == 2) -> kind1
      (acc2 == 3 && hand2 == 1) || (acc2 == 2 && hand2 == 2) -> kind2
      (acc3 == 3 && hand3 == 1) || (acc3 == 2 && hand3 == 2) -> kind3
      (acc4 == 3 && hand4 == 1) || (acc4 == 2 && hand4 == 2) -> kind4
      (acc5 == 3 && hand5 == 1) || (acc5 == 2 && hand5 == 2) -> kind5
      (acc6 == 3 && hand6 == 1) || (acc6 == 2 && hand6 == 2) -> kind6
      (acc7 == 3 && hand7 == 1) || (acc7 == 2 && hand7 == 2) -> kind7
      (acc8 == 3 && hand8 == 1) || (acc8 == 2 && hand8 == 2) -> kind8
      (acc9 == 3 && hand9 == 1) || (acc9 == 2 && hand9 == 2) -> kind9
      (acc10 == 3 && hand10 == 1) || (acc10 == 2 && hand10 == 2) -> kind10
      (acc11 == 3 && hand11 == 1) || (acc11 == 2 && hand11 == 2) -> kind11
      (acc12 == 3 && hand12 == 1) || (acc12 == 2 && hand12 == 2) -> kind12
      (acc13 == 3 && hand13 == 1) || (acc13 == 2 && hand13 == 2) -> kind13
      true -> 0
    end
  end

  # Straight main function
  def straight(pool, hand) do
    newPool = Enum.sort(makeSame((pool ++ hand), []))
    # Check for flush in old and new Pools
    newPoolFlushCheck = checkConsecutive(newPool, [], 0)
    oldPoolFlushCheck = checkConsecutive(Enum.sort(makeSame(pool, [])), [], 0)
    cond do
      #Check if same straight is in both pools
      oldPoolFlushCheck == newPoolFlushCheck -> 0
      # Return straight if it exists
      length(newPoolFlushCheck) == 5 -> makeBack(newPoolFlushCheck, pool ++ hand, [])
      # No straight is found, return 0
      true -> 0
    end
  end

  # Flush Main Function
  def flush(pool, hand) do
    # Set flush conditions
    flush1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    flush2 = [14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]
    flush3 = [27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39]
    flush4 = [40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52]

    # How many elements of each flush does the pool contain
    acc1 = length(checkForCards(flush1, pool, []))
    acc2 = length(checkForCards(flush2, pool, []))
    acc3 = length(checkForCards(flush3, pool, []))
    acc4 = length(checkForCards(flush4, pool, []))

    # Check which flush it could contain (Pool must contain at least 3 of the same suite)
    chosenFlush = cond do
      acc1 >=3 -> flush1
      acc2 >=3 -> flush2
      acc3 >=3 -> flush3
      acc4 >=3 -> flush4
      true -> 0
    end

    #
    if chosenFlush != 0 do
      # Get possibilities
      newPool = Enum.sort(pool ++ hand)
      newPoolChecked = Enum.sort(checkForCards(chosenFlush, newPool, []))
      newPoolCheckedRm = tl(newPoolChecked)
      newPoolCheckedRm2 = tl(newPoolCheckedRm)
      newPoolCheckedRmTop = tl(Enum.reverse(newPoolChecked))
      newPoolCheckedRmTop2 = tl(Enum.reverse(newPoolCheckedRm))

      # Find a solution
      cond do
        # Make sure it's not a false positive
        checkForCards(chosenFlush, pool, []) == newPoolChecked -> 0
        # Clean Flush found
        length(newPoolChecked) == 5 -> newPoolChecked
        # More than 5 in a suite found (figure out which cards to drop)
        length(newPoolChecked) == 6 && pool != newPoolCheckedRm -> newPoolCheckedRm
        length(newPoolChecked) == 7 && pool != newPoolCheckedRm2 -> newPoolCheckedRm2
        length(newPoolChecked) == 6 && pool == newPoolCheckedRm -> newPoolCheckedRmTop
        length(newPoolChecked) == 7 && pool == newPoolCheckedRm2 -> newPoolCheckedRmTop2
        true -> 0
      end
    else
      0
    end
  end

  # Full House main function
  def fullHouse(pool, hand) do
    if trioFull(pool, hand) != 0 do
      #Trio was found, now find Duo
      newPool = pool -- trioFull(pool, hand)
      newHand = hand -- trioFull(pool, hand)
      if pairFull(newPool, newHand) != 0 do
        #Duo was found, we have a full house
        Enum.sort((trioFull(pool, hand)) ++ (pairFull(newPool, newHand)))
      else
        0
      end
    else
      0
    end
  end

  # Group of three, only used for Full House Main Function
  # This is because it's possible to have 3 in pool and 2 in hand
  def trioFull(pool, hand) do
    # Set groups that can make up threes
    kind1 = [1, 14, 27, 40]
    kind2 = [2, 15, 28, 41]
    kind3 = [3, 16, 29, 42]
    kind4 = [4, 17, 30, 43]
    kind5 = [5, 18, 31, 44]
    kind6 = [6, 19, 32, 45]
    kind7 = [7, 20, 33, 46]
    kind8 = [8, 21, 34, 47]
    kind9 = [9, 22, 35, 48]
    kind10 = [10, 23, 36, 49]
    kind11 = [11, 24, 37, 50]
    kind12 = [12, 25, 38, 51]
    kind13 = [13, 26, 39, 52]

    # How many elements of each kind does the pool contain
    acc1 = length(checkForCards(kind1, pool, []))
    acc2 = length(checkForCards(kind2, pool, []))
    acc3 = length(checkForCards(kind3, pool, []))
    acc4 = length(checkForCards(kind4, pool, []))
    acc5 = length(checkForCards(kind5, pool, []))
    acc6 = length(checkForCards(kind6, pool, []))
    acc7 = length(checkForCards(kind7, pool, []))
    acc8 = length(checkForCards(kind8, pool, []))
    acc9 = length(checkForCards(kind9, pool, []))
    acc10 = length(checkForCards(kind10, pool, []))
    acc11 = length(checkForCards(kind11, pool, []))
    acc12 = length(checkForCards(kind12, pool, []))
    acc13 = length(checkForCards(kind13, pool, []))

    # How many elements of each kind does each hand contain?
    hand1 = length(checkForCards(kind1, hand, []))
    hand2 = length(checkForCards(kind2, hand, []))
    hand3 = length(checkForCards(kind3, hand, []))
    hand4 = length(checkForCards(kind4, hand, []))
    hand5 = length(checkForCards(kind5, hand, []))
    hand6 = length(checkForCards(kind6, hand, []))
    hand7 = length(checkForCards(kind7, hand, []))
    hand8 = length(checkForCards(kind8, hand, []))
    hand9 = length(checkForCards(kind9, hand, []))
    hand10 = length(checkForCards(kind10, hand, []))
    hand11 = length(checkForCards(kind11, hand, []))
    hand12 = length(checkForCards(kind12, hand, []))
    hand13 = length(checkForCards(kind13, hand, []))

    # Check for 3 in the Pool or in the Pool and Hand combined, return them
    cond do
      hand1 == 3 || acc1 == 3 || (acc1 == 1 && hand1 == 2) || (acc1 == 2 && hand1 == 1) -> checkForCards(kind1, pool, []) ++ checkForCards(kind1, hand, [])
      hand2 == 3 || acc2 == 3 || (acc2 == 1 && hand2 == 2) || (acc2 == 2 && hand2 == 1) -> checkForCards(kind2, pool, []) ++ checkForCards(kind2, hand, [])
      hand3 == 3 || acc3 == 3 || (acc3 == 1 && hand3 == 2) || (acc3 == 2 && hand3 == 1) -> checkForCards(kind3, pool, []) ++ checkForCards(kind3, hand, [])
      hand4 == 3 || acc4 == 3 || (acc4 == 1 && hand4 == 2) || (acc4 == 2 && hand4 == 1) -> checkForCards(kind4, pool, []) ++ checkForCards(kind4, hand, [])
      hand5 == 3 || acc5 == 3 || (acc5 == 1 && hand5 == 2) || (acc5 == 2 && hand5 == 1) -> checkForCards(kind5, pool, []) ++ checkForCards(kind5, hand, [])
      hand6 == 3 || acc6 == 3 || (acc6 == 1 && hand6 == 2) || (acc6 == 2 && hand6 == 1) -> checkForCards(kind6, pool, []) ++ checkForCards(kind6, hand, [])
      hand7 == 3 || acc7 == 3 || (acc7 == 1 && hand7 == 2) || (acc7 == 2 && hand7 == 1) -> checkForCards(kind7, pool, []) ++ checkForCards(kind7, hand, [])
      hand8 == 3 || acc8 == 3 || (acc8 == 1 && hand8 == 2) || (acc8 == 2 && hand8 == 1) -> checkForCards(kind8, pool, []) ++ checkForCards(kind8, hand, [])
      hand9 == 3 || acc9 == 3 || (acc9 == 1 && hand9 == 2) || (acc9 == 2 && hand9 == 1) -> checkForCards(kind9, pool, []) ++ checkForCards(kind9, hand, [])
      hand10 == 3 || acc10 == 3 || (acc10 == 1 && hand10 == 2) || (acc10 == 2 && hand10 == 1) -> checkForCards(kind10, pool, []) ++ checkForCards(kind10, hand, [])
      hand11 == 3 || acc11 == 3 || (acc11 == 1 && hand11 == 2) || (acc11 == 2 && hand11 == 1) -> checkForCards(kind11, pool, []) ++ checkForCards(kind11, hand, [])
      hand12 == 3 || acc12 == 3 || (acc12 == 1 && hand12 == 2) || (acc12 == 2 && hand12 == 1) -> checkForCards(kind12, pool, []) ++ checkForCards(kind12, hand, [])
      hand13 == 3 || acc13 == 3 || (acc13 == 1 && hand13 == 2) || (acc13 == 2 && hand13 == 1) -> checkForCards(kind13, pool, []) ++ checkForCards(kind13, hand, [])
      true -> 0
    end
  end

  # Pair, only used for Full House
  # This is because it's possible to have 3 in pool and 2 in hand
  def pairFull(pool, hand) do
    # Set groups that can make up pairs
    kind1 = [1, 14, 27, 40]
    kind2 = [2, 15, 28, 41]
    kind3 = [3, 16, 29, 42]
    kind4 = [4, 17, 30, 43]
    kind5 = [5, 18, 31, 44]
    kind6 = [6, 19, 32, 45]
    kind7 = [7, 20, 33, 46]
    kind8 = [8, 21, 34, 47]
    kind9 = [9, 22, 35, 48]
    kind10 = [10, 23, 36, 49]
    kind11 = [11, 24, 37, 50]
    kind12 = [12, 25, 38, 51]
    kind13 = [13, 26, 39, 52]

    # How many elements of each kind does the pool contain
    acc1 = length(checkForCards(kind1, pool, []))
    acc2 = length(checkForCards(kind2, pool, []))
    acc3 = length(checkForCards(kind3, pool, []))
    acc4 = length(checkForCards(kind4, pool, []))
    acc5 = length(checkForCards(kind5, pool, []))
    acc6 = length(checkForCards(kind6, pool, []))
    acc7 = length(checkForCards(kind7, pool, []))
    acc8 = length(checkForCards(kind8, pool, []))
    acc9 = length(checkForCards(kind9, pool, []))
    acc10 = length(checkForCards(kind10, pool, []))
    acc11 = length(checkForCards(kind11, pool, []))
    acc12 = length(checkForCards(kind12, pool, []))
    acc13 = length(checkForCards(kind13, pool, []))

    # How many elements of each kind does each hand contain?
    hand1 = length(checkForCards(kind1, hand, []))
    hand2 = length(checkForCards(kind2, hand, []))
    hand3 = length(checkForCards(kind3, hand, []))
    hand4 = length(checkForCards(kind4, hand, []))
    hand5 = length(checkForCards(kind5, hand, []))
    hand6 = length(checkForCards(kind6, hand, []))
    hand7 = length(checkForCards(kind7, hand, []))
    hand8 = length(checkForCards(kind8, hand, []))
    hand9 = length(checkForCards(kind9, hand, []))
    hand10 = length(checkForCards(kind10, hand, []))
    hand11 = length(checkForCards(kind11, hand, []))
    hand12 = length(checkForCards(kind12, hand, []))
    hand13 = length(checkForCards(kind13, hand, []))

    # Check for 2 in Pool, 2 in Hand, or 1 in Pool and 1 in Hand, return the result
    cond do
      hand1 == 2 || acc1 == 2 || (acc1 == 1 && hand1 == 1) -> checkForCards(kind1, pool, []) ++ checkForCards(kind1, hand, [])
      hand2 == 2 || acc2 == 2 || (acc2 == 1 && hand2 == 1) -> checkForCards(kind2, pool, []) ++ checkForCards(kind2, hand, [])
      hand3 == 2 || acc3 == 2 || (acc3 == 1 && hand3 == 1) -> checkForCards(kind3, pool, []) ++ checkForCards(kind3, hand, [])
      hand4 == 2 || acc4 == 2 || (acc4 == 1 && hand4 == 1) -> checkForCards(kind4, pool, []) ++ checkForCards(kind4, hand, [])
      hand5 == 2 || acc5 == 2 || (acc5 == 1 && hand5 == 1) -> checkForCards(kind5, pool, []) ++ checkForCards(kind5, hand, [])
      hand6 == 2 || acc6 == 2 || (acc6 == 1 && hand6 == 1) -> checkForCards(kind6, pool, []) ++ checkForCards(kind6, hand, [])
      hand7 == 2 || acc7 == 2 || (acc7 == 1 && hand7 == 1) -> checkForCards(kind7, pool, []) ++ checkForCards(kind7, hand, [])
      hand8 == 2 || acc8 == 2 || (acc8 == 1 && hand8 == 1) -> checkForCards(kind8, pool, []) ++ checkForCards(kind8, hand, [])
      hand9 == 2 || acc9 == 2 || (acc9 == 1 && hand9 == 1) -> checkForCards(kind9, pool, []) ++ checkForCards(kind9, hand, [])
      hand10 == 2 || acc10 == 2 || (acc10 == 1 && hand10 == 1) -> checkForCards(kind10, pool, []) ++ checkForCards(kind10, hand, [])
      hand11 == 2 || acc11 == 2 || (acc11 == 1 && hand11 == 1) -> checkForCards(kind11, pool, []) ++ checkForCards(kind11, hand, [])
      hand12 == 2 || acc12 == 2 || (acc12 == 1 && hand12 == 1) -> checkForCards(kind12, pool, []) ++ checkForCards(kind12, hand, [])
      hand13 == 2 || acc13 == 2 || (acc13 == 1 && hand13 == 1) -> checkForCards(kind13, pool, []) ++ checkForCards(kind13, hand, [])
      true -> 0
    end
  end

  # Three of a Kind Main Function
  def trio(pool, hand) do
    # Set groups that can make up pairs
    kind1 = [1, 14, 27, 40]
    kind2 = [2, 15, 28, 41]
    kind3 = [3, 16, 29, 42]
    kind4 = [4, 17, 30, 43]
    kind5 = [5, 18, 31, 44]
    kind6 = [6, 19, 32, 45]
    kind7 = [7, 20, 33, 46]
    kind8 = [8, 21, 34, 47]
    kind9 = [9, 22, 35, 48]
    kind10 = [10, 23, 36, 49]
    kind11 = [11, 24, 37, 50]
    kind12 = [12, 25, 38, 51]
    kind13 = [13, 26, 39, 52]

    # How many elements of each kind does the pool contain
    acc1 = length(checkForCards(kind1, pool, []))
    acc2 = length(checkForCards(kind2, pool, []))
    acc3 = length(checkForCards(kind3, pool, []))
    acc4 = length(checkForCards(kind4, pool, []))
    acc5 = length(checkForCards(kind5, pool, []))
    acc6 = length(checkForCards(kind6, pool, []))
    acc7 = length(checkForCards(kind7, pool, []))
    acc8 = length(checkForCards(kind8, pool, []))
    acc9 = length(checkForCards(kind9, pool, []))
    acc10 = length(checkForCards(kind10, pool, []))
    acc11 = length(checkForCards(kind11, pool, []))
    acc12 = length(checkForCards(kind12, pool, []))
    acc13 = length(checkForCards(kind13, pool, []))

    # How many elements of each kind does each hand contain?
    hand1 = length(checkForCards(kind1, hand, []))
    hand2 = length(checkForCards(kind2, hand, []))
    hand3 = length(checkForCards(kind3, hand, []))
    hand4 = length(checkForCards(kind4, hand, []))
    hand5 = length(checkForCards(kind5, hand, []))
    hand6 = length(checkForCards(kind6, hand, []))
    hand7 = length(checkForCards(kind7, hand, []))
    hand8 = length(checkForCards(kind8, hand, []))
    hand9 = length(checkForCards(kind9, hand, []))
    hand10 = length(checkForCards(kind10, hand, []))
    hand11 = length(checkForCards(kind11, hand, []))
    hand12 = length(checkForCards(kind12, hand, []))
    hand13 = length(checkForCards(kind13, hand, []))

    # Check for 3 in the Pool and Hand combined, return them
    cond do
      (acc1 == 1 && hand1 == 2) || (acc1 == 2 && hand1 == 1) -> checkForCards(kind1, pool, []) ++ checkForCards(kind1, hand, [])
      (acc2 == 1 && hand2 == 2) || (acc2 == 2 && hand2 == 1) -> checkForCards(kind2, pool, []) ++ checkForCards(kind2, hand, [])
      (acc3 == 1 && hand3 == 2) || (acc3 == 2 && hand3 == 1) -> checkForCards(kind3, pool, []) ++ checkForCards(kind3, hand, [])
      (acc4 == 1 && hand4 == 2) || (acc4 == 2 && hand4 == 1) -> checkForCards(kind4, pool, []) ++ checkForCards(kind4, hand, [])
      (acc5 == 1 && hand5 == 2) || (acc5 == 2 && hand5 == 1) -> checkForCards(kind5, pool, []) ++ checkForCards(kind5, hand, [])
      (acc6 == 1 && hand6 == 2) || (acc6 == 2 && hand6 == 1) -> checkForCards(kind6, pool, []) ++ checkForCards(kind6, hand, [])
      (acc7 == 1 && hand7 == 2) || (acc7 == 2 && hand7 == 1) -> checkForCards(kind7, pool, []) ++ checkForCards(kind7, hand, [])
      (acc8 == 1 && hand8 == 2) || (acc8 == 2 && hand8 == 1) -> checkForCards(kind8, pool, []) ++ checkForCards(kind8, hand, [])
      (acc9 == 1 && hand9 == 2) || (acc9 == 2 && hand9 == 1) -> checkForCards(kind9, pool, []) ++ checkForCards(kind9, hand, [])
      (acc10 == 1 && hand10 == 2) || (acc10 == 2 && hand10 == 1) -> checkForCards(kind10, pool, []) ++ checkForCards(kind10, hand, [])
      (acc11 == 1 && hand11 == 2) || (acc11 == 2 && hand11 == 1) -> checkForCards(kind11, pool, []) ++ checkForCards(kind11, hand, [])
      (acc12 == 1 && hand12 == 2) || (acc12 == 2 && hand12 == 1) -> checkForCards(kind12, pool, []) ++ checkForCards(kind12, hand, [])
      (acc13 == 1 && hand13 == 2) || (acc13 == 2 && hand13 == 1) -> checkForCards(kind13, pool, []) ++ checkForCards(kind13, hand, [])
      true -> 0
    end
  end

  # Pair Main Function
  def pair(pool, hand) do
    # Set groups that can make up pairs
    kind1 = [1, 14, 27, 40]
    kind2 = [2, 15, 28, 41]
    kind3 = [3, 16, 29, 42]
    kind4 = [4, 17, 30, 43]
    kind5 = [5, 18, 31, 44]
    kind6 = [6, 19, 32, 45]
    kind7 = [7, 20, 33, 46]
    kind8 = [8, 21, 34, 47]
    kind9 = [9, 22, 35, 48]
    kind10 = [10, 23, 36, 49]
    kind11 = [11, 24, 37, 50]
    kind12 = [12, 25, 38, 51]
    kind13 = [13, 26, 39, 52]

    # How many elements of each kind does the pool contain
    acc1 = length(checkForCards(kind1, pool, []))
    acc2 = length(checkForCards(kind2, pool, []))
    acc3 = length(checkForCards(kind3, pool, []))
    acc4 = length(checkForCards(kind4, pool, []))
    acc5 = length(checkForCards(kind5, pool, []))
    acc6 = length(checkForCards(kind6, pool, []))
    acc7 = length(checkForCards(kind7, pool, []))
    acc8 = length(checkForCards(kind8, pool, []))
    acc9 = length(checkForCards(kind9, pool, []))
    acc10 = length(checkForCards(kind10, pool, []))
    acc11 = length(checkForCards(kind11, pool, []))
    acc12 = length(checkForCards(kind12, pool, []))
    acc13 = length(checkForCards(kind13, pool, []))

    # How many elements of each kind does each hand contain?
    hand1 = length(checkForCards(kind1, hand, []))
    hand2 = length(checkForCards(kind2, hand, []))
    hand3 = length(checkForCards(kind3, hand, []))
    hand4 = length(checkForCards(kind4, hand, []))
    hand5 = length(checkForCards(kind5, hand, []))
    hand6 = length(checkForCards(kind6, hand, []))
    hand7 = length(checkForCards(kind7, hand, []))
    hand8 = length(checkForCards(kind8, hand, []))
    hand9 = length(checkForCards(kind9, hand, []))
    hand10 = length(checkForCards(kind10, hand, []))
    hand11 = length(checkForCards(kind11, hand, []))
    hand12 = length(checkForCards(kind12, hand, []))
    hand13 = length(checkForCards(kind13, hand, []))

    # Check for 1 in Pool and 1 in Hand, return the result
    cond do
      acc1 == 1 && hand1 == 1 -> checkForCards(kind1, pool, []) ++ checkForCards(kind1, hand, [])
      acc2 == 1 && hand2 == 1 -> checkForCards(kind2, pool, []) ++ checkForCards(kind2, hand, [])
      acc3 == 1 && hand3 == 1 -> checkForCards(kind3, pool, []) ++ checkForCards(kind3, hand, [])
      acc4 == 1 && hand4 == 1 -> checkForCards(kind4, pool, []) ++ checkForCards(kind4, hand, [])
      acc5 == 1 && hand5 == 1 -> checkForCards(kind5, pool, []) ++ checkForCards(kind5, hand, [])
      acc6 == 1 && hand6 == 1 -> checkForCards(kind6, pool, []) ++ checkForCards(kind6, hand, [])
      acc7 == 1 && hand7 == 1 -> checkForCards(kind7, pool, []) ++ checkForCards(kind7, hand, [])
      acc8 == 1 && hand8 == 1 -> checkForCards(kind8, pool, []) ++ checkForCards(kind8, hand, [])
      acc9 == 1 && hand9 == 1 -> checkForCards(kind9, pool, []) ++ checkForCards(kind9, hand, [])
      acc10 == 1 && hand10 == 1 -> checkForCards(kind10, pool, []) ++ checkForCards(kind10, hand, [])
      acc11 == 1 && hand11 == 1 -> checkForCards(kind11, pool, []) ++ checkForCards(kind11, hand, [])
      acc12 == 1 && hand12 == 1 -> checkForCards(kind12, pool, []) ++ checkForCards(kind12, hand, [])
      acc13 == 1 && hand13 == 1 -> checkForCards(kind13, pool, []) ++ checkForCards(kind13, hand, [])
      true -> 0
    end
  end

  # Two Pairs Main Function
  def twoPairs(pool, hand) do
    if pair(pool, hand) != 0 do
      # First pair was found, now find the second one
      newPool = pool -- pair(pool, hand)
      newHand = hand -- pair(pool, hand)
      if pair(newPool, newHand) != 0 do
        # Second Pair was found, we have Two Pairs
        Enum.sort((pair(pool, hand)) ++ (pair(newPool, newHand)))
      else
        # Second Pair was not found, return 0
        0
      end
    else
      # No pairs found, return 0
      0
    end
  end

  # High card main function
  def highCard(hand1, hand2) do
    # Take the cards from Hand 1
    hand1Card1 = hd(hand1)
    hand1Card2 = hd(tl(hand1))

    # Take the cards from Hand 2
    hand2Card1 = hd(hand2)
    hand2Card2 = hd(tl(hand2))

    # Return the highest card
    compareFour(hand1Card1, hand1Card2, hand2Card1, hand2Card2)
  end

  # Used for High Card function
  def compareFour(card1, card2, card3, card4) do
    cond do
      # Check for aces
      rankCheck(card1) == 1 && rankCheck(card2) != 1 && rankCheck(card3) != 1 && rankCheck(card4) != 1 -> card1
      rankCheck(card1) != 1 && rankCheck(card2) == 1 && rankCheck(card3) != 1 && rankCheck(card4) != 1 -> card2
      rankCheck(card1) != 1 && rankCheck(card2) != 1 && rankCheck(card3) == 1 && rankCheck(card4) != 1 -> card3
      rankCheck(card1) != 1 && rankCheck(card2) != 1 && rankCheck(card3) != 1 && rankCheck(card4) == 1 -> card4
      # Check which card is the highest
      rankCheck(card1) > rankCheck(card2) && rankCheck(card1) > rankCheck(card3) && rankCheck(card1) > rankCheck(card4) -> card1
      rankCheck(card2) > rankCheck(card1) && rankCheck(card2) > rankCheck(card3) && rankCheck(card2) > rankCheck(card4) -> card2
      rankCheck(card3) > rankCheck(card2) && rankCheck(card3) > rankCheck(card1) && rankCheck(card3) > rankCheck(card4) -> card3
      rankCheck(card4) > rankCheck(card2) && rankCheck(card4) > rankCheck(card3) && rankCheck(card4) > rankCheck(card1) -> card4
      # No winner
      true -> 0
    end
  end

  ##################################################
  # General Support Functions                      #
  ##################################################
  # Check if a list of cards are contained in Pool or Hand
  def checkForCards(checkList, pool, contained) do
    lenCheckList = length(checkList)
    lenPool = length(pool)
    [head|tail] = checkList
    card = head
    returnedCard = cond do
      lenCheckList >= 1 && lenPool >= 1 -> checkForCard(card, pool)
      true -> 0
    end
    cond do
      lenCheckList > 1 && returnedCard == 0 -> checkForCards(tail, pool, contained)
      lenCheckList > 1 && returnedCard != 0 -> checkForCards(tail, pool, contained ++ [returnedCard])
      lenCheckList <= 1 && returnedCard == 0 -> contained
      lenCheckList <= 1 && returnedCard != 0 -> contained ++ [returnedCard]
      true -> IO.puts "Error on checkForCards"
    end
  end

  # Check if specific card is contained in Pool or Hand
  def checkForCard(card, pool) do
    lenPool = length(pool)
    [head|tail] = pool
    cond do
      card == head -> card
      lenPool > 1 -> checkForCard(card, tail)
      lenPool <= 1 -> 0
      true -> IO.puts "Error on checkForCard"
    end
  end

  # Check for cards absent in Pool
  def absentCards(checkList, pool, necessary) do
    lenCheckList = length(checkList)
    [head|tail] = checkList
    card = head
    returnedCard = cond do
      checkForCard(card, pool) == 0 -> card
      true -> 0
    end
    cond do
      lenCheckList > 1 && returnedCard == 0 -> absentCards(tail, pool, necessary)
      lenCheckList > 1 && returnedCard != 0 -> absentCards(tail, pool, necessary ++ [returnedCard])
      lenCheckList <= 1 && returnedCard == 0 -> necessary
      lenCheckList <= 1 && returnedCard != 0 -> necessary ++ [returnedCard]
      true -> IO.puts "Error on absentCards"
    end
  end

  # Set all cards to 1 through 13
  def makeSame(cards, returnHand) do
    lenCheckList = length(cards)
    [head|tail] = cards
    card = head
    cond do
      lenCheckList > 1 -> makeSame(tail, returnHand ++ [rankCheck(card)])
      lenCheckList <= 1 -> returnHand ++ [rankCheck(card)]
      true -> IO.puts "Error on makeSame"
    end
  end

  def makeBack(cards, ogList, returnHand) do
    lenCheckList = length(cards)
    [head|tail] = cards
    card = head
    returnCard = cond do
      checkForCard(card, ogList) != 0 -> card
      checkForCard(card + 13, ogList) != 0 -> card + 13
      checkForCard(card + 26, ogList) != 0 -> card + 26
      checkForCard(card + 39, ogList) != 0 -> card + 39
      true -> 0
    end
    cond do
      lenCheckList > 1 && returnCard != 0-> makeBack(tail, ogList, returnHand ++ [returnCard])
      lenCheckList <= 1 && returnCard != 0 -> returnHand ++ [returnCard]
      lenCheckList > 1 -> makeBack(tail, ogList, returnHand)
      lenCheckList <= 1 -> returnHand
      true -> IO.puts "Error on makeSame"
    end
  end

  # Check for Straight Flushes
  def checkConsecutive(pool, returnHand, acc) do
    lenReturnHand = length(returnHand)
    [head|tail] = pool
    leadingCard = head
    newPool = tail
    lenPool = length(newPool)
    trailingCard = hd(tail)
    cond do
      # Found 5 consecutive
      lenReturnHand == 5 -> returnHand
      # Found 5 consecutive at the end of the list
      (lenPool <= 1 || acc == 5) && leadingCard + 1 == trailingCard -> returnHand ++ [trailingCard]
      # End of the list
      (lenPool <= 1 || acc == 5) && leadingCard + 1 != trailingCard -> returnHand
      # Check for false consecutive (between suites)
      (leadingCard == 13 && trailingCard == 14) || (leadingCard == 26 && trailingCard == 27) || (leadingCard == 39 && trailingCard == 40) -> checkConsecutive(newPool, [], 0)
      # Beginning of a new consecutive list
      leadingCard + 1 == trailingCard && acc == 0 -> checkConsecutive(newPool, returnHand ++ [leadingCard] ++ [trailingCard], acc + 1)
      # Add to the consecutive list
      leadingCard + 1 == trailingCard -> checkConsecutive(newPool, returnHand ++ [trailingCard], acc + 1)
      # Reset consecutive list
      leadingCard + 1 != trailingCard -> checkConsecutive(newPool, [], 0)
      true -> IO.puts "Error on checkConsecutive"
    end
  end

  ##################################################
  # Return Card Information Processing             #
  ##################################################
  # Return the formatted cards and suites
  def returnInfo(winningHand, returnHand) do
    lenCheckList = length(winningHand)
    [head|tail] = winningHand
    card = head
    cond do
      lenCheckList > 1 -> returnInfo(tail, returnHand ++ [cardInfo(card)])
      lenCheckList <= 1 -> returnHand ++ [cardInfo(card)]
      true -> IO.puts "Error on checkForCards"
    end
  end

  # Return one card formatted properly
  def cardInfo(card) do
    cond do
      card > 0 && card < 14 -> "#{card}C"
      card > 13 && card < 27 -> "#{card - 13}D"
      card > 26 && card < 40 -> "#{card - 26}H"
      card > 39 && card < 53 -> "#{card - 39}S"
    end
  end
end
