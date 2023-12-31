defmodule RentCarsWeb.Router do
  use RentCarsWeb, :router
  alias RentCarsWeb.Middleware.EnsureAuthenticated
  alias RentCarsWeb.Middleware.IsAdmin

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {RentCarsWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :is_admin do
    plug IsAdmin
  end

  pipeline :authenticated do
    plug EnsureAuthenticated
  end

  scope "/", RentCarsWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", RentCarsWeb.Api, as: :api do
    pipe_through :api

    get "/cars", CarController, :index

    scope "/admin", Admin, as: :admin do
      pipe_through :is_admin

      post "/cars", CarController, :create
      patch "/cars/images/:id", CarController, :create_images
      get "/cars/:id", CarController, :show
      put "/cars/:id", CarController, :update

      resources "/categories", CategoryController
      resources "/specifications", SpecificationController
    end

    scope "/" do
      pipe_through :authenticated

      post "/session/me", SessionController, :me
      get "/users/:id", UserController, :show
      patch "/users/photo", UserController, :upload_photo

      post "/rentals", RentalController, :create
      post "/rentals/return/:id", RentalController, :return
      get "/rentals", RentalController, :index
    end

    post "/users", UserController, :create

    post "/session", SessionController, :create
    post "/session/forgot_password", SessionController, :forgot_password
    post "/session/reset_password", SessionController, :reset_password
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RentCarsWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
