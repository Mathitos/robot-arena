defmodule RobotArena.Router do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Welcome to Robot Arena")
  end

  match _ do
    IO.inspect("404")
    send_resp(conn, 404, "oops, resource not found")
  end
end
