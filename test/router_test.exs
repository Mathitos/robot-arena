defmodule RobotArena.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts RobotArena.Router.init([])

  describe "index" do
    test "returns welcome message" do
      # Create a test connection
      conn = conn(:get, "/")

      # Invoke the plug
      conn = RobotArena.Router.call(conn, @opts)

      # Assert the response and status
      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "Welcome to Robot Arena"
    end
  end
end
