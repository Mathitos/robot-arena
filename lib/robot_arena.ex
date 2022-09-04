defmodule RobotArena do
  use Application

  @moduledoc """
  Documentation for `RobotArena`.
  """

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: RobotArena.Controller, options: [port: 4001]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
