# welcome screen
# get player's name
# player gets $1,000 as start, computer has $20,000
# ask how many decks the user would like to use? (1,3,5?)
# before dealing, ask player for bet amount
# deal hand: give 2 open cards to player, and 2 to computer
# check for "blackjack" of both players 
# if player blackjack and computer is not, then give 1.5x amount
# if computer blackjack and player is not, then lose full bet
# if neither, then ask player to 1) hit 2) stand 3) split 4) double
# if HIT - deal a card, and evaluate "BUST" (over 21), if not, re-ask 1) hit or 2) stand.
# if STAND - goto computer turn, and check if over 17? if not, HIT. 
# check Computer BUST. If not, rehit until over 17
# If computer STAYS and have not busted, check Player and Computer totals
# Printout highest total withover busting over 21. highest card win
# highest card wins bet amount
# ask to replay? Y/N, if "Y" then restart with game with same bet balance.

require 'pry'

def cls
  system('clear')
  system('cls')
end

def cardsums(user)
  total=0    #init record total card value
  acebig=0   #init record ace assignments of 11
  cards=user.collect{|card| card[1]}
    cards.each do |card|
       if card.include?('Jack')||card.include?('King')||card.include?('Queen')
        total+=10       
        elsif card.include?('Ace') #normal "Ace' deck variable assignment
          if total+11>21 
            total+=1
          else
          	acebig+=1   #tally up all '11' ace values
            total+=11
          end
        else
          total+=card.to_i 
       end
    end
	total-=(10*acebig) if total>21 #reducing all hands large '11' aces down to '1' value if bust
  	total
end


# main initialize program
play="Y"
turn=1
pass=0
s1=0
s2=0
call=[]
call2=[]
money=1000
cmoney=20000
cls
puts (' '*15)+"Welcome to 21 * B / l / a / c / k  - J / a / c / k * v2.0" 
puts ""
puts (' '*15)+"Includes doubling down, splitting, and error checking modules"
puts (' '*30)+"Written by Johnny Pan 6/14"
sleep 1
puts ""
puts ""
puts "Hi Sir. What's your name?"
name=gets.chomp
while play=='Y'
cls if turn>1
puts ""
puts "Hi, #{name}. Your bank roll is $#{money}. "
puts "Your computer opponent has $#{cmoney}. Try to extract that. Goodluck!"
puts ""
suits=['Spades','Clubs','Diamonds','Hearts']
cards=['2','3','4','5','6','7','8','9','10','Jack','Queen','King','Ace']
deck=(suits.product(cards))
puts "Number of decks to use? (1-5)"
numdeck=gets.chomp.to_i
while ![*1..5].include?(numdeck)
puts "invalid entry. Enter deck count (1-5 only)?"
numdeck=gets.chomp.to_i
end
deck=deck*numdeck
puts ""
puts "Okay! #{numdeck} deck(s) it is"
puts "hmm... So your gonna try to count cards huh, you'll need the luck! lol" if numdeck==1
puts ""
puts "You have $#{money}. Turn #{turn}: >> Your bet?"
betamount=gets.chomp.to_i
if betamount<0 || betamount>money 
  puts "Invalid amount! Default amount will be #{money/10}"
  betamount=money/10
end
deck.shuffle!
player=[]
computer=[]
puts ""
player<<deck.pop
puts ">> [YOU] have #{player[0][1]} (#{player[0][0].upcase})"
sleep 1
puts ""
computer<<deck.pop
puts ">> [COMPUTER] shows #{computer[0][1]} (#{computer[0][0].upcase})" 
sleep 1
puts ""
player<<deck.pop
puts ">> [YOU] have #{player[1][1]} (#{player[1][0].upcase})"
sleep 1
puts ""
computer<<deck.pop
puts ">> [COMPUTER] last card [******]"
puts "-----------------------------------------"
puts ""
puts ""
puts "Your card total: #{cardsums(player)}"
puts "Comp only shows: #{computer[0][1]} (#{computer[0][0].upcase})"
puts ""
  if cardsums(player)==21
    puts "Blackjack!!! you won $#{betamount*1.5}"
    money+=betamount*1.5
    pass=1
  end

while cardsums(player)<21
 	puts ""
 	puts ">> Choose: (1)Hit (2)Stand" if player[2]!=nil
 	puts ">> Choose: (1)Hit (2)Stand (3)Double" if player[0][1]!=player[1][1] && player[2]==nil
 	puts ">> Choose: (1)Hit (2)Stand (3)Double (4)Split" if player[0][1]==player[1][1] && player[2]==nil
 	choose=gets.chomp.to_i
  if choose==1
  puts ""
  print "Dealer passes you a card....#{deck.last[1].upcase} of #{deck.last[0].upcase}"
  player<<deck.pop
  sleep 1
  puts ""
  puts "Your total is now #{cardsums(player)}"
 end
 if choose==2
  puts "Okay, you stand at #{cardsums(player)}"
  break
 end
 if choose==3
  betamount*2<money ? maxbet=betamount*2: maxbet=money
    puts "How much will be your total wager? (min $#{betamount} max $#{maxbet})"
    double=gets.chomp.to_i
    if double>maxbet || double<betamount
     puts "invalid entry"
     next
    else
      betamount=double
      print "Dealer passes you a card....#{deck.last[1].upcase} of #{deck.last[0].upcase}"
    player<<deck.pop
    sleep 1
    puts ""
    puts "Your total is now #{cardsums(player)}"
      if cardsums(player)>21
        puts "You busted! you lost $#{betamount}"
        money-=betamount
        pass=1
      end
    break
    end
  end
 	  if choose==4
      call<<player[0]
      while s1<22
      puts ""
      puts "your [1st] split hand is #{call}"
      puts "Command => (1)hit (2)stand" 
      dset=gets.chomp.to_i
      if dset==2
          puts "Ok, Set[1] stand on:#{s1}" 
          puts ""
        break
        end
      call<<deck.pop if dset==1 
      puts "---------------"
      puts ""
      s1=cardsums(call) 
      puts "You got .......... >> #{call[-1]}"
      puts ""
      puts ""
      puts "Split set[1] Total >>#{s1}"
      end

      call2<<player[1]
      while s2<22
      puts ""
      puts "your [2nd] split hand is #{call2}"
      puts "Command => (1)hit (2)stand" 
      dset=gets.chomp.to_i
      if dset==2
          puts "Ok, Set[2] stand on:#{s2}" 
          puts ""
        break
      end
      call2<<deck.pop if dset==1 
      puts "---------------"
      puts ""
      s2=cardsums(call2) 
      puts "You got .......... >> #{call2[-1]}"
      puts ""
      puts ""
      puts "Split set[2] Total >>#{s2}"
      end
    end

  if cardsums(player)>21
    puts "You busted! you lost $#{betamount}"
    money-=betamount
    pass=1
  end
  if cardsums(player)==21
    puts ""
    puts "BlackJack baby!! Great job."
    puts ""
  end
end
  
if pass==0 ## computer dealer hits until 17 or if player bust skips this section
puts ""
puts "------------------------------------"
puts ""
puts "Dealer shows his card... #{computer}" 
puts "Dealer total is... #{cardsums(computer)}"
puts ""
  while cardsums(computer)<17 
   computer<<deck.pop
   sleep 1
   puts "Dealer hits a...#{computer.last[1].upcase} of #{computer.last[0].upcase}"
   puts "Dealer total...#{cardsums(computer)}"
    puts ""
    puts "You have #{cardsums(player)} and dealer has #{cardsums(computer)}" if s1==nil
    #binding.pry
    puts ""
    if cardsums(computer)>21 && s1!=nil
      puts "Dealer busted!"
      money+=betamount*2 
      cmoney-=betamount*2
      break
    end
  end
   
  if s1!=nil
    if cardsums(computer)>s1 && cardsums(computer)<22 || s1>21
      puts "First split hand: #{s1} [LOSES] to dealer: #{cardsums(computer)}"
      money-=betamount
      cmoney+=betamount
    elsif cardsums(computer)<s1 && s1<22
      puts "First split hand: #{s1} [WINS] to dealer: #{cardsums(computer)}"
      money+=betamount
      cmoney-=betamount
    elsif cardsums(computer)==s1 
      puts "First split hand [TIES] with computer hand"
    end

    if cardsums(computer)>s2 && cardsums(computer)<22 || s2>21
      puts "Second split hand: #{s2} [LOSES] to dealer: #{cardsums(computer)}"
      money-=betamount
      cmoney+=betamount
    elsif cardsums(computer)<s2 && s2<22
      puts "Second split hand: #{s2} [WINS] to dealer: #{cardsums(computer)}"
      money+=betamount
      cmoney-=betamount
    elsif cardsums(computer)==s2 
      puts "Second split hand [TIES] with computer hand"
    end
  end



    if s1==nil && cardsums(computer)>21
      puts "Dealer busted! You win +$#{betamount}"
      money+=betamount
      cmoney-=betamount
    elsif s1==nil && cardsums(computer)>cardsums(player)
      puts "You lose! -$#{betamount}"
      money-=betamount
      cmoney+=betamount
    elsif s1==nil && cardsums(computer)<cardsums(player)
      puts "You win! +$#{betamount}"
      money+=betamount
      cmoney-=betamount
    elsif cardsums(computer)==cardsums(player)
      puts "It's a tie!"
      puts "Your balance: $#{money}"
    end
end

puts ""
turn+=1 #accumulate turns
pass=0  #reset bust 
s1=nil #reset split deck1
s2=nil #reset split deck2
if money<1
  puts "Muahaha... Your Bankrupt! Goodbye #{name}!"
  break
end
puts "Your final Balance: $#{money}"
puts ""
puts "Do you want to play again? (Y/N)"
play=gets.chomp.to_s
end