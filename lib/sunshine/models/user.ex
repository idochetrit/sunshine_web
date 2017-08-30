defmodule Sunshine.User do
  alias Session

  def current_user(conn) do
    Plug.Conn.get_session conn, :current_user
  end


  def logged_in?(conn) do
    !!(current_user(conn))
  end


  def login(params) do
    user = params["username"] |> String.downcase
    user =
      case user do
        "liordizdar" ->
          user
        _ ->
          nil
      end
    case authenticate(user, params["password"]) do
      true ->
        {:ok, user}
      _ ->
        :error
    end
  end


  defp authenticate(user, password) do
    password_check =
      :crypto.hash(:sha256, "whatever") |> Base.encode16 |> String.downcase
    encrypted_password =
      :crypto.hash(:sha256, password) |> Base.encode16 |> String.downcase
    case user do
      nil -> false
      _ -> (encrypted_password == password_check)
    end
  end
end
