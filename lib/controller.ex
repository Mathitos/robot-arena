defmodule RobotArena.Controller do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Welcome to Robot Arena")
  end

  # forward("/users", to: UsersRouter)

  match _ do
    send_resp(conn, 404, "oops, resource not found")
  end
end
