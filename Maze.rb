
# Maze class. initializes an empty maze then you can load a maze from a string of 1s and 0s
#display method displays the maze
#solve prints out true if the maze is solvable from begining coordinates to end coordinates
#solve has a boolean trace that if set to true will trace the maze otherwise it will not
#so trace method just calls solve with trace = true

class Maze 
  attr_accessor :maze
  N, S, E, W = 1, -1, -1, 1
  # initialize a x by y empty maze (counting by cells only)
  def initialize (x,y)
    actual_row_size = 2*x+1
    actual_column_size = 2*y+1
    @maze = Array.new(actual_column_size) {Array.new(actual_row_size, 0)}

  end

  def load (string)
    @maze.each do |inner|
      inner.map!{|item| string.slice!(0) }
      
    end          
  end

  def display
    @maze.each do |inner|
      inner.each do |elem|
        print elem
      end
      puts
    end
  end
  
  #breadth first search using an array called queue as a queue

  def solve (begX, begY, endX, endY, trace=nil)
    # visited = Hash.new
    # done = false
    # @graph = Graph.new
    # @graph.add_node(actual_begX, actual_begY)
    # @graph.nodes.keys.each do |coord
    #   if visited.has_key?([actual_begX, actual_begY])   
    #   traverse(actual_begX,actual_begY)
    #   visited.store([actual_begX, actual_begY], "node")
    # end
    solved = false
    queue = []
    queue << [begX,begY]

    while !queue.empty? && !solved
      visit = queue.shift
      x = visit[0]
      y = visit[1]

      if (x == endX && y == endY)
        solved = true
      else
        if trace
          @maze[y][x] = "x"
        end

        
        if open(x+1,y)
          queue << [x+1,y]
        end
        if open(x-1,y)
          queue << [x-1,y]
        end
        if open(x,y+1)
          queue << [x,y+1]
        end
        if open(x,y-1) 
          queue << [x,y-1]
        end
      
      end
    end

    if solved 
      if trace 
        @maze[endY][endX] = "x"
      end
      puts true
    else 
      puts false
    end
    
  end
  #check if the coordinate is open
  def open(x,y)
    if (x<0 || y<0 || x>@maze[0].size-1 || y>@maze.size-1)
      return false
    end
    return @maze[y][x] == "0"
      
  end

  def trace (begX, begY, endX, endY)
    solve(begX, begY, endX, endY,true) 
  end



  
end

m = Maze.new(4,4)
m.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")
puts "Original: \n\n"
m.display

puts " "
print 'The maze is solvable: '
m.solve(7,1,1,7)
m.trace(7,1,1,7)
puts "Trace:\n "

m.display








