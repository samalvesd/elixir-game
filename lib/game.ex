defmodule Game do

  use Application


  def start(_,_) do
    run()
    {:ok, self()}
  end

  def run() do
    IO.puts("Let's play Elixir Game!")

    IO.gets("Choice the difficult level (1, 2 or 3):")
    |> parse_input()
    |> pickup_number()
    |> play()
  end

  def play(picked_num) do
    IO.gets("I have my number. What is your guess?")
    |> parse_input()
    |> guess(picked_num, 1)
  end


  def guess(user_guess, picked_num, count) when user_guess > picked_num do
    IO.gets("Too high. Try again:")
    |> parse_input()
    |> guess(picked_num, count + 1)
  end

  def guess(user_guess, picked_num, count) when user_guess < picked_num do
    IO.gets("Too low. Try again:")
    |> parse_input()
    |> guess(picked_num, count + 1)
  end

  def guess(_,_, count) do
    IO.puts("You WIN!!! Congratulations!\nNumber of attempts: #{count}")
    show_score(count)
  end

  def show_score(guesses) when guesses > 6 do
    IO.puts("Better luck next time.")
  end

  def show_score(guesses) do
    {_, msg} = %{1..1 => "You're amazing!",
                 2..4 => "Really nice!",
                 5..6 => "You cando do better than that."}
                |> Enum.find(fn {range, _} ->
                   Enum.member?(range, guesses)
                end)
    IO.puts(msg)
  end

  def pickup_number(level) do
    level
    |> get_range()
    |> Enum.random()
  end

  def parse_input(:error) do
    IO.puts("Invalid Level!!!")
    run()
  end

  def parse_input({num, _}), do: num

  def parse_input(data) do
    data
    |> Integer.parse()
    |> parse_input()
  end

  def get_range(level) do
    case level do
       1 -> 1..10
       2 -> 2..100
       3 -> 3..1000
       _ -> IO.puts("Invalid Level!! Please, choice between 1, 2 or 3")
        run()
    end
  end
end
