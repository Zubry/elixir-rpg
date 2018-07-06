defmodule MMO.Worker do
  def start_link do
    opts = [port: 4500]
    {:ok, _} = :ranch.start_listener(:MMO, 100, :ranch_tcp, opts, MMO.Handler, [])
  end
end