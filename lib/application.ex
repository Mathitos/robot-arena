defmodule RobotArena.Application do
  use Application

  @moduledoc """
  Documentation for `RobotArena`.
  """

  @env Mix.env()

  def start(_type, _args) do
    children = get_children(@env)

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  defp get_children(:test) do
    [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: MyWebsocketApp.Router,
        options: [
          dispatch: dispatch(),
          port: 4000
        ]
      )
    ]
  end

  defp get_children(_) do
    [
      {RobotArena.GameState, []},
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: MyWebsocketApp.Router,
        options: [
          dispatch: dispatch(),
          port: 4000
        ]
      )
    ]
  end

  defp dispatch do
    [
      {:_,
       [
         {"/ws/[...]", RobotArena.SocketHandler, []},
         {:_, Plug.Cowboy.Handler, {RobotArena.Router, []}}
       ]}
    ]
  end
end
