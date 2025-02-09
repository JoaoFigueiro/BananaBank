defmodule BananaBankWeb.Plugs.Auth do
  def init(opts), do: opts

  alias BananaBankWeb.Token

  def call(conn, _opts) do
    with ["Bearer " <> token] <- Plug.Conn.get_req_header(conn, "authorization"),
         {:ok, data} <- Token.verify(token) do
        assing(conn, :user_id, data)
      else
      _error ->
      conn
      |> put_status(:unauthorized)
      |> Phoenix.Controller.put_view(json: BananaBankWeb.ErrorJSON)
      |> Phoenix.Controller.render(:error, status: :not_found)
      |> halt()
    end
  end
end