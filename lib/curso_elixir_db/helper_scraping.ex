defmodule CursoElixirDb.HelperScraping do
  @moduledoc """
  The HelperScraping context.
  """

  import Ecto.Query, warn: false
  alias CursoElixirDb.Repo

  alias CursoElixirDb.HelperScraping.Scraping

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Accounts{}, ...]

  """
  def list_scrap do
    Repo.all(Scraping)
  end

  @doc """
  Gets a single accounts.

  Raises `Ecto.NoResultsError` if the Accounts does not exist.

  ## Examples

      iex> get_accounts!(123)
      %Accounts{}

      iex> get_accounts!(456)
      ** (Ecto.NoResultsError)

  """
  def get_scrap!(id), do: Repo.get!(Scraping, id)

  @doc """
  Creates a accounts.

  ## Examples

      iex> create_accounts(%{field: value})
      {:ok, %Accounts{}}

      iex> create_accounts(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scrap(attrs \\ %{}) do
    %Scraping{}
    |> Scraping.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a accounts.

  ## Examples

      iex> update_accounts(accounts, %{field: new_value})
      {:ok, %Accounts{}}

      iex> update_accounts(accounts, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_scrap(%Scraping{} = scrap, attrs) do
    scrap
    |> Scraping.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a accounts.

  ## Examples

      iex> delete_accounts(accounts)
      {:ok, %Accounts{}}

      iex> delete_accounts(accounts)
      {:error, %Ecto.Changeset{}}

  """
  def delete_scrap(%Scraping{} = scrap) do
    Repo.delete(scrap)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking accounts changes.

  ## Examples

      iex> change_scrap(scrap)
      %Ecto.Changeset{data: %Accounts{}}

  """
  def change_scrap(%Scraping{} = scrap, attrs \\ %{}) do
    Scraping.changeset(scrap, attrs)
  end
end
