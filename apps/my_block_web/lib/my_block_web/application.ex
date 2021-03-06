defmodule MyBlockWeb.Application do
  @moduledoc """
  The MyBlockWeb Application Service.

  The my_block system user web interface lives in this application.
  """
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      %{
        id: MyBlockWeb.Endpoint,
        start: {MyBlockWeb.Endpoint, :start_link, []},
        restart: :permanent,
        type: :supervisor
      }
      # Start your own worker by calling: MyBlockWeb.Worker.start_link(arg1, arg2, arg3)
      # worker(MyBlockWeb.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MyBlockWeb.Supervisor]
    Logger.add_backend(Sentry.LoggerBackend)
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MyBlockWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
