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
	def initialize(position = [0,0],parent=nil)
		@position = position
		@legal_moves = [[1,2],[-1,2],[1,-2],[-1,-2],[2,1],[-2,1],[2,-1],[-2,-1]]
		make_knight_graph

	end

	def calculate_possible_positions(position)
	# creates an array of every possible next position 
		@possible_positions = []
		@legal_moves.each do |m|
			p = [(position[0] + m[0]),(position[1]+m[1])]
			# makes sure that the possible position is a legal one (is included on gameboard)
			@possible_positions << gameboard.index(p) if gameboard.include?(p)
		end	
		return @possible_positions
	end

	def make_knight_graph
		#the knight graph is a graph of links from every position on the game board
		@knight_graph = []
		gameboard.each do |p|
			@knight_graph << calculate_possible_positions(p)
		end		
	end

	def BFS
		search_queue = [@starting_position]
		visited_nodes = []
		path = []
		until search_queue.empty?
			node = search_queue.shift
			visited_nodes << node
			@knight_graph[node].each do |child|
				path[child] = node if path[child] == nil
				return path if child == @final_position
				search_queue << child unless visited_nodes.include?(child) || search_queue.include?(child)
			end
		end
	end

	def find_shortest_path(path)
		shortest_path = [@final_position]
		loop do  
			shortest_path << path[shortest_path[-1]]
			break if shortest_path[-1] == @starting_position
		end
		shortest_path
	end

	def print_solution
		puts "You made it in #{@solution_array.length - 1} moves!"
		puts "Heres your path:"
		@solution_array.reverse.each do |i|
			puts gameboard[i].to_s
		end
	end

	def knight_moves(starting_position,final_position)
		@starting_position = gameboard.index(starting_position)
		@final_position = gameboard.index(final_position)
		@solution_array = find_shortest_path(BFS())
		print_solution
	end
end

knight = Knight.new
knight.knight_moves([3,3],[4,3])