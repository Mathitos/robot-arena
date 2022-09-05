defmodule RobotArena.SocketHandler do
  @behaviour :cowboy_websocket

  @moduledoc """
  This module handles ws comunication with client

  made thanks to Logan Bresnahan and his [guide](https://medium.com/@loganbbres/elixir-websocket-chat-example-c72986ab5778)
  """

  def init(req, state) do
    {:cowboy_websocket, req, state}
  end

  def websocket_init(_state) do
    state = %{}
    {:ok, state}
  end

  def websocket_handle({:text, message}, state) do
    {:reply, {:text, message}, state}
  end

  def websocket_handle({:json, json}, state) do
    message = Jason.decode!(json)
    {:reply, {:text, message}, state}
  end

  def websocket_info(%{game_state_update: game_state}, _state) do
    send_update_game_state(game_state)
  end

  def websocket_info(_info, state) do
    {:ok, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end

  defp send_update_game_state(game_state) do
    try do
      message = Jason.encode!(game_state)
      {:reply, {:text, message}, %{}}
    rescue
      RuntimeError ->
        {:ok, %{}}
    end
  end
end
