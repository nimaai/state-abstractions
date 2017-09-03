defmodule MyLogger do
  def start_link do
    Task.start_link(fn -> loop("") end)
  end

  defp loop(log) do
    receive do
      {:get, caller} ->
        send caller, log
        loop(log)
      {:put, value} ->
        loop(log <> value)
    end
  end
end

defmodule MyMath do
  def init_log do
    {:ok, pid} = MyLogger.start_link
    Process.register(pid, :log)
  end

  def add1(x) do
    send(:log, {:put, "add1"})
    x + 1
  end

  def square(x) do
    send(:log, {:put, "square"})
    x * x
  end

  def log do
    send(:log, {:get, self()})
  end
end
