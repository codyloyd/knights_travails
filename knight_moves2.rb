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
		# -17,-15,-6,+10,15,-10,+6,17
		@legal_moves = [[1,2],[-1,2],[1,-2],[-1,-2],[2,1],[-2,1],[2,-1],[-2,-1]]
		make_knight_graph
		BFS([3,4],[2,2])
	end

	def calculate_possible_positions(position)
	# creates an array of every possible next position 
	# for an instance of a knight	
		@possible_positions = []
		@legal_moves.each do |m|
			p = [(position[0] + m[0]),(position[1]+m[1])]
			# makes sure that the possible position is a legal one (is included on gameboard)
			@possible_positions << gameboard.index(p) if gameboard.include?(p)
		end	
		return @possible_positions
	end

	def make_knight_graph
		@knight_graph = []
		gameboard.each_with_index do |p,i|
			@knight_graph << calculate_possible_positions(p)
		end		
	end

	def BFS(starting_position,final_position)
		s = gameboard.index(starting_position)
		f = gameboard.index(final_position)
		q = [s]
		until q.empty?
			node = q.shift
			# return node if node == f
			puts "SUCCESS #{gameboard[node]}" if node == f
			break if node == f
			@knight_graph[node].each do |child|
				q << child
			end
		end
	end

end

knight = Knight.new([3,5])
