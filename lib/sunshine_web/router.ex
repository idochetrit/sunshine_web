defmodule SunshineWeb.Router do
  use SunshineWeb, :router

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

  scope "/", SunshineWeb do
    pipe_through :browser # Use the default browser stack

    resources "/", LoginController, only: [:index, :create]
    get "/bravo", BravoController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SunshineWeb do
  #   pipe_through :api
  # end
end
