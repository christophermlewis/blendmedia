defmodule Importer.CrimeLoaderTest do
  use ExUnit.Case
  alias Importer.Crime
  alias Importer.CrimeLoader

  @valid_crime  %{
      alias: "e87d48c72a99bc0dcccd17bfade3d5e2aaae6cb6ab5c57a558754bab071e0594",
      month: "2017-01",
      reported_by: "Avon and Somerset Constabulary",
      falls_within: "Avon and Somerset Constabulary",
      longitude: "-2.494870",
      latitude: "51.422276",
      location: "On or near Conference/Exhibition Centre",
      lsoa_code: "E01014399",
      lsoa_name: "Bath and North East Somerset 001A",
      type: "Burglary",
      last_outcome_category: "Status update unavailable",
      context: "any value"
    }

  test "save should return {:ok, %Crime{}} for a valid crime" do
    {:ok, crime = %Crime{}} = CrimeLoader.save(@valid_crime) 
    assert crime |> Map.from_struct |> Map.drop([:__meta__, :id]) == @valid_crime
  end

  test "save should return " do
    invalid_crime = @valid_crime |> Map.drop([:month, :location])
    {:error, crime} = CrimeLoader.save(invalid_crime) 
    assert crime.errors |> length == 2
  end
end
