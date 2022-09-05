defmodule RobotArena.GameStateTest do
  use ExUnit.Case, async: true

  defp get_game_state(game_state_agent),
    do: Agent.get(game_state_agent, fn game_state -> game_state end)

  describe "init" do
    test "should start with empty user list" do
      {:ok, game_state_agent} = RobotArena.GameState.start_link([])
      assert get_game_state(game_state_agent) == %{users: []}
    end
  end

  describe "login" do
    setup do
      {:ok, game_state_agent} = RobotArena.GameState.start_link([])
      %{game_state_agent: game_state_agent}
    end

    test "should add user to list", %{game_state_agent: game_state_agent} do
      user_pid1 = spawn(fn -> :ok end)
      username1 = "test user"
      :ok = RobotArena.GameState.user_login(username1, user_pid1)

      user_pid2 = spawn(fn -> :ok end)
      username2 = "test user"
      :ok = RobotArena.GameState.user_login(username2, user_pid2)

      updated_game_state = get_game_state(game_state_agent)
      assert [{username2, user_pid2}, {username1, user_pid1}] == updated_game_state.users
    end
  end

  describe "logout" do
    setup do
      {:ok, game_state_agent} = RobotArena.GameState.start_link([])
      %{game_state_agent: game_state_agent}
    end

    test "should remove only given user from list", %{game_state_agent: game_state_agent} do
      user_pid1 = spawn(fn -> :ok end)
      username1 = "test user"
      :ok = RobotArena.GameState.user_login(username1, user_pid1)

      user_pid2 = spawn(fn -> :ok end)
      username2 = "test user"
      :ok = RobotArena.GameState.user_login(username2, user_pid2)

      :ok = RobotArena.GameState.user_logout(user_pid2)

      updated_game_state = get_game_state(game_state_agent)
      assert [{username1, user_pid1}] == updated_game_state.users
    end
  end
end
