class MyMath
  attr_accessor :log

  def initialize
    @log = ""
  end

  def add1(x)
    @log += "add1"
    x + 1
  end

  def square(x)
    @log += "square"
    x * x
  end
end

m = MyMath.new
m.square(m.add1(1)) # => 4
m.log # => "add1square"
