defmodule Importer.CrimeRepo.Migrations.CreateCrimes do
  use Ecto.Migration

  def change do
    create table(:crimes) do
      add :alias, :string
      add :month, :string
      add :reported_by, :string
      add :falls_within, :string
      add :longitude, :string
      add :latitude, :string
      add :location, :string
      add :lsoa_code, :string
      add :lsoa_name, :string
      add :type, :string
      add :last_outcome_category, :string
      add :context, :string
    end
  end
end
