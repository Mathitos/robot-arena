defmodule RobotArena do
  @moduledoc """
  Documentation for `RobotArena`.
  """

  use Application

  def start(_type, _args) do
    children = []
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
