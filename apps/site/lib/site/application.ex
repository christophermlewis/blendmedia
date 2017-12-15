defmodule Site.Application do
  alias Site.Resources.Crimes
  @moduledoc false

  use Application

  def start(_type, _args) do
    dispatch = :cowboy_router.compile([
        {:_, [
                {"/", :cowboy_static, {:priv_file, :site, "index.html"}},
                {"/crimes", Crimes, []}
              ]
        }
      ])

    {ok, _} = :cowboy.start_clear(:listener,
        [port: 8000],
        %{env: %{dispatch: dispatch}}
    )
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Site.Worker.start_link(arg)
      # {Site.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Site.Supervisor]
    Supervisor.start_link(children, opts)
  end
end


