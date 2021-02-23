defmodule CursoElixirDb.HelperScraping.Scraping do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scraping" do
    field :tittle, :string
    field :descripcion, :string
    field :score, :string
    field :growth, :string
    timestamps()
  end

  @doc false
  def changeset(scraping, attrs) do
    scraping
    |> cast(attrs, [:tittle, :descripcion, :score, :growth])
    |> validate_required([:tittle, :descripcion, :score, :growth])
  end
end
