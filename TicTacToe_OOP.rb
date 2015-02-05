class Player
  attr_reader:name
  def initialize(name2)
    @name = name2
  end

end

class Human < Player
  def fill(board1)
    spots_left=board1.remain
    if spots_left.size != 0
    begin
      puts "Please pick any number in #{spots_left} positions on the board"
      choice = gets.chomp
    end while choice.to_i.to_s == 'O' && !spots_left.include?(choice.to_i)
      board1.name_board[choice.to_i] = 'X'
      board1.show
      return
    end
  end
end

class Computer < Player
  def fill(board1)
    spots_left = board1.remain
    if spots_left.size != 0
      choice = spots_left.sample
      board1.name_board[choice] = 'O'
      board1.show
    end
    board1.show
    return ' '
  end
end

class Board
  attr_accessor:name_board
  def initialize()
    @name_board = Array.new(9){|element|element=' '}
  end

  def remain
    slots = name_board.each_index.select{|x|@name_board[x] ==' '}
    return slots
  end

  def show
    puts "-----------"
    for i in 0..name_board.size-1
      if i == 2 || i == 5 || i == 8
        puts name_board[i]
        puts "---------"
      else
        print name_board[i]+ ' | '
      end
    end
  end
end

class Game
  attr_accessor:a,:b,:c
  def initialize(name,name2)
    @a = Human.new('Loc Ho')
    @b =Computer.new('IBM')
    @c = Board.new
  end

  def check_winner
      winner=' '
      winning_lines=[[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,8]]
      winning_lines.each do |x|
         if c.name_board.values_at(*x).count('X') == 3
           winner = "#{a.name} wins"
           return winner
         end
         if c.name_board.values_at(*x).count('O') == 3
           winner = "#{b.name} wins"
           return winner
         end
      end
      if c.remain.size == 0
      return "Its a tie"
      end
      return winner
  end

  def play
    message = ' '
    begin
      a.fill(c)
      b.fill(c)
      message = check_winner
    end while message == ' ' && c.remain.size != 0
    puts message
  end
  
end

player1 = Human.new()
computer1 = Computer.new()
m = Game.new(player1,computer1)
m.play
