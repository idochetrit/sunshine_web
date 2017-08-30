defmodule SunshineWeb.LoginController do
  use SunshineWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, params) do
    case Sunshine.User.login(params["login"]) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user)
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/bravo")

      :error ->
        conn
        |> put_flash(:error, "Wrong! Bitch!")
        |> render("index.html")
    end
  end
end
