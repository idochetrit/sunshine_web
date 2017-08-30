defmodule SunshineWeb.BravoController do
  use SunshineWeb, :controller

  def index(conn, _params) do
    case Sunshine.User.logged_in?(conn) do
      true ->  render conn, "index.html"
      false -> conn |> redirect(to: "/")
    end
  end
end
