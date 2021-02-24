defmodule CursoElixirDb.HelperScraping.Scraping do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scraping" do
    field :title, :string
    field :desc, :string
    field :score, :string
    field :growth, :string
    timestamps()
  end

  @doc false
  def changeset(scraping, attrs) do
    scraping
    |> cast(attrs, [:title, :desc, :score, :growth])
    |> validate_required([:title, :desc])
  end

  def changeset_update(scraping, attrs) do
    scraping
    |> cast(attrs, [:score, :growth])
    # |> validate_required([:score, :growth])
  end
end
