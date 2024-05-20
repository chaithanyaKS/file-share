defmodule FileShare.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FileShareWeb.Telemetry,
      FileShare.Repo,
      {DNSCluster, query: Application.get_env(:file_share, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FileShare.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: FileShare.Finch},
      # Start a worker by calling: FileShare.Worker.start_link(arg)
      # {FileShare.Worker, arg},
      # Start to serve requests, typically the last entry
      FileShareWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FileShare.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FileShareWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
