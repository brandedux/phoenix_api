defmodule MyAppWeb.Router do
  use MyAppWeb, :router
  # Add POW and Oauth2 Provider
  use Pow.Phoenix.Router
  use Pow.Extension.Phoenix.Router, otp_app: :my_app
  use PhoenixOauth2Provider.Router, otp_app: :my_app

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # ==============
  # Add POW Plugin
  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
  end

  scope "/" do
    pipe_through :api

    oauth_api_routes()
  end

  scope "/" do
    pipe_through [:browser, :protected]

    oauth_routes()
  end

  # ===================
  # Setup Versioned API
  pipeline :api_protected do
    plug ExOauth2Provider.Plug.VerifyHeader, otp_app: :my_app, realm: "Bearer"
    plug ExOauth2Provider.Plug.EnsureAuthenticated
  end

  scope "/api/v1", MyAppWeb.API.V1 do
    pipe_through [:api, :api_protected]

    resources "/accounts", UserController
  end

  # =============
  # Default Scope
  scope "/", MyAppWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", MyAppWeb do
  #   pipe_through :api
  # end
end
