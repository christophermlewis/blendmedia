defmodule Site.CrimeTest do
  use ExUnit.Case
  alias Importer.CrimeRepo
  alias Site.Crime
  import Site.DataHelper 

  test "filter by type" do
    clear()
    load_examples()
    assert CrimeRepo.all(Importer.Crime) |> length == 4

    assert  Crime.filter([{:alias, "1"}]) 
    |> CrimeRepo.all 
    |> Enum.fetch!(0)
    |> Map.from_struct
    |> Map.drop([:id, :__meta__]) ==
        %{
              alias: "1", context: nil,
              falls_within: "Avon and Somerset Constabulary", 
              last_outcome_category: nil, latitude: "51.409435",
              location: "On or near Harlech Close", longitude: "-2.511927",
              lsoa_code: "E01014399",
              lsoa_name: "Bath and North East Somerset 001A", month: "2016-01",
              reported_by: "Avon and Somerset Constabulary",
              type: "Anti-social behaviour"}
  end 


  test "filter by more than one field" do
    clear()
    load_examples()
    assert CrimeRepo.all(Importer.Crime) |> length == 4 

    assert Crime.filter([{:lsoa_code, "E01014399"},{:type, "Anti-social behaviour"}]) |> CrimeRepo.all |> length == 3
  end

  test "sort by a field should sort" do
    clear()
    load_examples()
    assert CrimeRepo.all(Importer.Crime) |> length == 4 

    crimes = Crime.sort(:lsoa_code, Importer.Crime) |> CrimeRepo.all 
    assert crimes |> length == 4 
    assert crimes 
    |> Enum.fetch!(0)
    |> Map.from_struct
    |> Map.drop([:id, :__meta__]) ==
        %{
              alias: nil, context: nil,
              falls_within: "Avon and Somerset Constabulary", 
              last_outcome_category: nil, latitude: "51.422132",
              location: "On or near Cross Street", longitude: "-2.495055",
              lsoa_code: "E01014399",
              lsoa_name: "Bath and North East Somerset 001A", month: "2016-01",
              reported_by: "Avon and Somerset Constabulary",
              type: "unknown"}
  end
end
