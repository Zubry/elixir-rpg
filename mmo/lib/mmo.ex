require Logger

defmodule MMO do
  @moduledoc """
  Documentation for MMO.
  """

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

    serve(client)
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
