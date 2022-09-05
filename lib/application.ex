defmodule RobotArena.Application do
  use Application

  @moduledoc """
  Documentation for `RobotArena`.
  """

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: MyWebsocketApp.Router,
        options: [
          dispatch: dispatch(),
          port: 4000
        ]
      )
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
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
