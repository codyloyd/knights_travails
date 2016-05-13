class Chess
	attr_accessor :gameboard
	def initialize
	end
	
	def gameboard
		#generates a 2d array of spaces on the game board.
		board = []
		8.times do |i|
			8.times do |x|
				board << [i,x]
			end
		end
		return board				
	end
end


class Knight < Chess
	attr_accessor :position, :possible_positions
	def initialize(position)
		@position = position
		#the list of moves that a knight can make.
		@legal_moves = [[1,2],[-1,2],[1,-2],[-1,-2],[2,1],[-2,1],[2,-1],[-2,-1]]
		#keeps track of the positons that already have knights on them
		@knights_on_board = [self.position] unless @knights_on_board
		calculate_possible_positions		
		knight_tree
	end

	def calculate_possible_positions
	# creates an array of every possible next position 
	# for an instance of a knight	
		@possible_positions = []
		@legal_moves.each do |m|
			p = [(self.position[0] + m[0]),(self.position[1]+m[1])]
			# makes sure that the possible position is a legal one (is included on gameboard)
			@possible_positions << p if gameboard.include?(p)
		end		
	end

	def knight_tree
		#creates a new Knight at each possible positions
		#ideally, recursively filling out the tree.
		self.possible_positions.map! do |p|
			Knight.new(p) unless @knights_on_board.include?(p)
			@knights_on_board << p
		end
	end
end


knight = Knight.new([0,1])
