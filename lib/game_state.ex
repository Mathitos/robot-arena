defmodule RobotArena.GameState do
  use Agent

  require Logger

  def start_link(_opts) do
    Agent.start_link(
      fn ->
        %{
          users: []
        }
      end,
      name: __MODULE__,
      timeout: 15_000
    )
  end

  def user_login(user_name, pid) do
    Agent.update(__MODULE__, fn game_state ->
      %{game_state | users: [{user_name, pid} | game_state.users]}
    end)
  end

  def user_logout(pid) do
    Agent.update(__MODULE__, fn game_state ->
      %{
        game_state
        | users:
            Enum.filter(game_state.users, fn usr ->
              elem(usr, 1) != pid
            end)
      }
    end)
  end
end
