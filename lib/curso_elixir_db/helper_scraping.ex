defmodule CursoElixirDb.HelperScraping do
  @moduledoc """
  The HelperScraping context.
  """

  import Ecto.Query, warn: false
  alias CursoElixirDb.Repo

  alias CursoElixirDb.HelperScraping.Scraping

  @doc """
  Returns the list of scraps.

  ## Examples

      iex> list_scrap()
      [%scrap{}, ...]

  """
  def list_scrap do
    Repo.all(Scraping)
  end

  def find_scrap_by_title(title) do
    from(s in Scraping, where: s.title == ^title)
    |> Repo.one
  end

  @doc """
  Gets a single scraps.

  Raises `Ecto.NoResultsError` if the scrap does not exist.

  ## Examples

      iex> get_scrap!(123)
      %Scraping{}

      iex> get_scraps!(456)
      ** (Ecto.NoResultsError)

  """
  def get_scrap!(id), do: Repo.get!(Scraping, id)

  @doc """
  Creates a scraps.

  ## Examples

      iex> create_scraps(%{field: value})
      {:ok, %Scraping{}}

      iex> create_scraps(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scrap(attrs \\ %{}) do
    %Scraping{}
    |> Scraping.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a scraps.

  ## Examples

      iex> update_scrap(scraps, %{field: new_value})
      {:ok, %Scraping{}}

      iex> update_scraps(scraps, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_scrap(%Scraping{} = scrap, attrs) do
    scrap
    |> Scraping.changeset_update(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a scraps.

  ## Examples

      iex> delete_scrapt(accounts)
      {:ok, %Scraping{}}

      iex> delete_scraps(scraps)
      {:error, %Ecto.Changeset{}}

  """
  def delete_scrap(%Scraping{} = scrap) do
    Repo.delete(scrap)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking scraps changes.

  ## Examples

      iex> change_scrap(scrap)
      %Ecto.Changeset{data: %Scraping{}}

  """
  def change_scrap(%Scraping{} = scrap, attrs \\ %{}) do
    Scraping.changeset(scrap, attrs)
  end
end
