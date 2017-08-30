defmodule User do
  alias Session

  def current_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end

  def logged_in?(conn), do: !!current_user(conn)

  def login(params, repo) do
    user = params["username"] |> String.downcase
    user = case user do
      "liordizdar" -> user
      _ -> nil
    end 
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  defp authenticate(user, password) do
    password_check = :crypto.hash(:sha, "whatever")
    case user do
      nil -> false
      _   -> :crypto.hash(:sha, password) == password_check
    end
  end
end