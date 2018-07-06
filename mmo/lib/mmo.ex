require Logger

defmodule MMO do
  use Application
  @moduledoc """
  Documentation for MMO.
  """

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(MMO.Worker, [])
    ]

    opts = [strategy: :one_for_one, name: MMO.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
