defmodule SunshineWebWeb.LoginController do
  use SunshineWebWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, params) do
    case User.login(params, Blog.Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user)
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/bravo")
      :error ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render("index.html")
    end
  end
end