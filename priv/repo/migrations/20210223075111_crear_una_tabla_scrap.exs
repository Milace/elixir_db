defmodule CursoElixirDb.Repo.Migrations.CrearUnaTablaScrap do
  use Ecto.Migration

  def change do
    create table(:scraping) do
      add :title, :string
      add :desc, :string
      add :score, :string
      add :growth, :string

      timestamps()
    end
  end
end
