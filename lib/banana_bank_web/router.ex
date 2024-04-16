defmodule BananaBankWeb.Router do
  use BananaBankWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BananaBankWeb.Plugs.Auth
  end

  scope "/api", BananaBankWeb do
    pipe_through :api

    get "/", WelcomeController, :execute
    post "/users", UserController, :create
    post "/auth", UserController, :login
  end

  scope "/api", BananaBankWeb do
    pipe_through [:api, :auth]

    get "/users/:id", UserController, :show
    put "/users/:id", UserController, :update
    delete "/users/:id", UserController, :delete

    post "/accounts", AccountController, :create
    post "/transaction", AccountController, :transaction

  end

  # Enable LiveDashboard in development
  if Application.compile_env(:banana_bank, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: BananaBankWeb.Telemetry
    end
  end
end
