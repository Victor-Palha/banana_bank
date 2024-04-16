defmodule BananaBankWeb.FallbackController do
  use BananaBankWeb, :controller

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(BananaBankWeb.ErrorJSON)
    |> render(:error, status: :bad_request)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(BananaBankWeb.ErrorJSON)
    |> render(:error, status: :not_found)
  end

  def call(conn, {:error, "User not found"}) do
    # IO.inspect(any)
    conn
    |> put_status(:not_found)
    |> put_view(BananaBankWeb.ErrorJSON)
    |> render(:error, status: :not_found)
  end

  def call(conn, {:error, changeset}) do
    IO.inspect(changeset)
    conn
    |> put_status(:bad_request)
    |> put_view(BananaBankWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :withdraw, changeset, %{}}) do
    conn
    |> put_status(:bad_request)
    |> put_view(BananaBankWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :deposit, changeset, %{}}) do
    conn
    |> put_status(:bad_request)
    |> put_view(BananaBankWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end

end
