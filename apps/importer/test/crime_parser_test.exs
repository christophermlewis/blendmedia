defmodule Importer.CrimeParseTest do
  use ExUnit.Case
  alias Importer.CrimeParser


  test "parse with empty string should return :error" do
    assert "" |> CrimeParser.parse == :error
  end

  test "parse with a non binary should return :error" do
    assert CrimeParser.parse(1) == :error
    assert CrimeParser.parse(nil) == :error
    assert CrimeParser.parse([]) == :error
  end

  test "parse with incorrect number of fields should return :error" do
    field_length = 11
    assert String.duplicate(",", field_length - 1 ) |> CrimeParser.parse == :error
    assert String.duplicate(",", field_length + 1 ) |> CrimeParser.parse == :error
  end

  test "parse with valid data should return {:ok, map}" do
    valid_example = "e87d48c72a99bc0dcccd17bfade3d5e2aaae6cb6ab5c57a558754bab071e0594,2017-01,Avon and Somerset Constabulary,Avon and Somerset Constabulary,-2.494870,51.422276,On or near Conference/Exhibition Centre,E01014399,Bath and North East Somerset 001A,Burglary,Status update unavailable,"

   assert valid_example |> CrimeParser.parse == {:ok, %{
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
          context: ""
      } 
   } 
  end
end
