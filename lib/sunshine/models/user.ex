defmodule Sunshine.User do
  alias Session

  def current_user(conn) do
    Plug.Conn.get_session conn, :current_user
  end

  def logged_in?(conn) do
    !!(current_user(conn))
  end

  def login(params) do
    case authenticate_login_pass(params["password"]) do
      true ->
        {:ok, "user1"}
      _ ->
        :error
    end
  end

  def solve_net_error(params) do
    case authenticate_net_error(params["password"]) do
      true ->
        {:ok, "userFinal"}
      _ ->
        :error
    end
  end


  defp authenticate_net_error(password) do
    password_check_en =
      :crypto.hash(:sha256, "anchor") |> Base.encode16 |> String.downcase
    password_check_he =
      :crypto.hash(:sha256, "עוגן") |> Base.encode16 |> String.downcase
    encrypted_password =
      :crypto.hash(:sha256, password) |> Base.encode16 |> String.downcase
    (encrypted_password == password_check_en) ||
      (encrypted_password == password_check_he)
  end


  defp authenticate_login_pass(password) do
    password_check =
      :crypto.hash(:sha256, "ATGC") |> Base.encode16 |> String.downcase
    encrypted_password =
      :crypto.hash(:sha256, password) |> Base.encode16 |> String.downcase
    (encrypted_password == password_check)
  end
end
