defmodule SunshineWeb.BravoController do
  use SunshineWeb, :controller

  def index(conn, _params) do
    case conn |> User.logged_in? do
      true -> render conn, "index.html"
      false -> conn |> redirect(to: "/")
    end
  end
end
