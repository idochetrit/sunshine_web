defmodule SunshineWeb.LoginController do
  use SunshineWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, params) do
    case Sunshine.User.login(params["login"]) do
      {:ok, user_id} ->
        conn
        |> put_session(:current_user, user_id)
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/net_error")

      :error ->
        conn
        |> put_flash(:error, "Invalid Password!")
        |> render("index.html")
    end
  end
end
