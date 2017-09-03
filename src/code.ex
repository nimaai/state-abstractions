# defmodule MyLogger do
#   def start_link do
#     Task.start_link(fn -> loop("") end)
#   end

#   defp loop(log) do
#     receive do
#       {:get, caller} ->
#         send caller, log
#         loop(log)
#       {:put, value} ->
#         loop(log <> value)
#     end
#   end
# end

# defmodule MyMath do
#   def init_log do
#     {:ok, pid} = MyLogger.start_link
#     Process.register(pid, :log)
#   end

#   def add1(x) do
#     send(:log, {:put, "add1"})
#     x + 1
#   end

#   def square(x) do
#     send(:log, {:put, "square"})
#     x * x
#   end

#   def log do
#     send(:log, {:get, self()})
#   end
# end

# import MyMath
# MyMath.init_log # => true
# square(add1 1) # => 4
# log # => {:get, #PID<0.91.0>}
# flush # => "add1square", :ok

defmodule MyMath do
  def init_log do
    Agent.start_link(fn -> "" end, name: :log)
  end

  def add1(x) do
    Agent.update(:log, fn log -> log <> "add1" end)
    x + 1
  end

  def square(x) do
    Agent.update(:log, fn log -> log <> "square" end)
    x * x
  end

  def log do
    Agent.get(:log, fn log -> log end)
  end
end

# import MyMath
# init_log # => {:ok, #PID<0.91.0>}
# square(add1 1) # => 4
# log # => "add1square"
