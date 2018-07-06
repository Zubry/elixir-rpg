defmodule MMO.Application do
  use Application

  def start(_type, _args) do
    children = [
      { Task, fn -> MMO.accept(4500) end }
    ]

    opts = [strategy: :one_for_one, name: MMO.TaskSupervisor]

    Supervisor.start_link(children, opts)
  end
end