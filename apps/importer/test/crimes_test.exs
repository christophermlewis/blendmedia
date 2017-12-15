defmodule Importer.CrimeTest do
  use ExUnit.Case
  alias Importer.Crime

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
   
  test "valid crime map should return valid crime changeset" do
    crime = Crime.changeset(%Crime{}, @valid_crime)  
    assert crime.changes == @valid_crime 
    assert crime.errors == []
    assert crime.valid? == true
  end

  test "crime without a context field should be valid" do
    valid_crime =  @valid_crime |> Map.drop([:context])
    crime = Crime.changeset(%Crime{}, valid_crime)  
    assert crime.changes == valid_crime 
    assert crime.errors == []
    assert crime.valid? == true
  end

  test "missing required fields should return errors in changeset" do
    invalid_crime = Crime.required_fields
    |> Enum.shuffle 
    |> Enum.take(2) 
    |> (fn fields -> @valid_crime |> Map.drop(fields) end).()

    crime = Crime.changeset(%Crime{}, invalid_crime)
    assert crime.errors |> length == 2
    assert crime.valid? == false
  end
end
