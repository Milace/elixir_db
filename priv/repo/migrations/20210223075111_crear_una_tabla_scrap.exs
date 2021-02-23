defmodule CursoElixirDb.Repo.Migrations.CrearUnaTablaScrap do
  use Ecto.Migration

  def change do
    create table(:scraping) do
      add :tittle, :string
      add :descripcion, :string
      add :score, :string
      add :growth, :string

      timestamps()
    end
  end
end
