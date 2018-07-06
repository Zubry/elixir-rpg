require Logger

defmodule MMO do
  use Application
  @moduledoc """
  Documentation for MMO.
  """

  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: MMO.TaskSupervisor},
      { Task, fn -> MMO.accept(4500) end }
    ]

    opts = [strategy: :one_for_one, name: MMO.Supervisor]

    Supervisor.start_link(children, opts)
  end

  def accept(port) do
    {:ok, socket} = port
      |> :gen_tcp.listen([
        :binary,
        packet: :line,
        active: false,
        reuseaddr: true
      ])

    Logger.info("Now listening on port #{port}")
    listener(socket)
  end

  defp listener(socket) do
    {:ok, client} = socket
      |> :gen_tcp.accept

    {:ok, pid} = Task.Supervisor.start_child(MMO.TaskSupervisor, fn -> serve(client) end)
    :ok = :gen_tcp.controlling_process(client, pid)

    listener(socket)
  end

  defp serve(socket) do
    socket
      |> read_line
      |> write_line(socket)

    serve(socket)
  end

  defp read_line(socket) do
    {:ok, data} = socket
      |> :gen_tcp.recv(0)

    data
  end

  defp write_line(line, socket) do
    socket
      |> :gen_tcp.send('hello')
  end
end
