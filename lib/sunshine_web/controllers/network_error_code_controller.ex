defmodule SunshineWeb.NetworkErrorCodeController do
  use SunshineWeb, :controller

  def index(conn, _params) do
    case Sunshine.User.logged_in?(conn) do
      true ->  render conn, "index.html"
      false -> conn |> redirect(to: "/")
    end
  end

  def create(conn, params) do
    case Sunshine.User.solve_net_error(params["login"]) do
      {:ok, user_id} ->
        conn
        |> put_session(:current_user, user_id)
        |> put_flash(:info, "Yea! You did it!")
        |> redirect(to: "/bravo")

      :error ->
        conn
        |> put_flash(:error, "Invalid Code!")
        |> render("index.html")
    end
  end
end
