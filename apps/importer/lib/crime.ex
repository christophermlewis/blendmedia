defmodule Importer.Crime do
  use Ecto.Schema
  import Ecto.Changeset
  alias Importer.Crime

  @specification ~w(alias month reported_by falls_within longitude latitude location lsoa_code
                lsoa_name type last_outcome_category context)a
  @derive {Poison.Encoder, only: @specification }
  schema "crimes" do
    field  :alias, :string
    field  :month, :string
    field  :reported_by, :string
    field  :falls_within, :string
    field  :longitude, :string
    field  :latitude, :string
    field  :location, :string
    field  :lsoa_code, :string
    field  :lsoa_name, :string
    field  :type, :string
    field  :last_outcome_category, :string
    field  :context, :string
  end 

  def required_fields(), do: ~w(month reported_by falls_within longitude latitude location lsoa_code lsoa_name type )a 

  def changeset(crime = %Crime{}, params) do
    crime
    |> cast(params, @specification)
    |> validate_required(required_fields())
  end
end
