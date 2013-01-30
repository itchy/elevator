class Direction
  def initialize
    @state = nil
  end

  def up?
    @state == :up
  end

  def down?
    @state == :down
  end

  def idle?
    ! up? && ! down? 
  end

  def idle
    @state = :idle
  end

  def set(direction)
    @state = direction.to_sym
  end
end

class Elevator
  attr_accessor :current_floor

  def initialize(floor)
  	@queue = []
    @direction = Direction.new
  	@current_floor = floor
  end

  def call(floor)
  	@queue << floor unless @queue.member? floor 
  end



  def determine_direction
    return if more_floors_in_same_direction
    @direction.idle
    return if @queue.empty?
    if @queue.first > @current_floor
      @direction.set(:up)
    else
      @direction.set(:down)
    end
  end


  def more_floors_in_same_direction
    return if @queue.empty?
    return (@queue.max > @current_floor) if @direction.up?
    return (@queue.min < @current_floor) if @direction.down?
  end

  def tick(count=1)
    count.times do
      if @queue.member? @current_floor
        @queue.delete @current_floor
      end

      determine_direction

      if @direction.down?
        @current_floor -= 1
      elsif @direction.up?
        @current_floor += 1
      end 

    end
  end
end  


describe "Elevator" do
	context "elevator is on floor 1" do
		before do
			@elevator = Elevator.new(1)
		end
	  
    it "responds to calls" do
	  	@elevator.call(2)
	  	@elevator.tick()
	  	@elevator.current_floor.should be 2
	  end  

	  it "takes a tic to move" do
	  	@elevator.call(3)
	  	@elevator.tick()
	  	@elevator.current_floor.should be 2
	  	@elevator.tick()
	  	@elevator.current_floor.should be 3
	  end

	  it "queues floors to visit" do
	  	@elevator.call(3)
	  	@elevator.tick
	  	@elevator.call 1
	  	@elevator.tick
	  	@elevator.current_floor.should be 3 #we think
	  end

    it "should remove the current floor from the queue" do
      @elevator.call(2)
      @elevator.tick()
      @elevator.call(3)
      @elevator.tick()
      @elevator.current_floor.should be 3 
    end

    it "continues in a direction" do
      @elevator.call 3
      @elevator.tick()
      @elevator.call 1
      @elevator.call 4
      @elevator.tick 2
      @elevator.current_floor.should be 4
    end

    it "will change direction after after reaching limit of direction" do
      @elevator.call 3
      @elevator.tick 
      @elevator.call 1
      @elevator.call 4
      @elevator.tick 20
      @elevator.current_floor.should be 1      
    end

  end 
end  