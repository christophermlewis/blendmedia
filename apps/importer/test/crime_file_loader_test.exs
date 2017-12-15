defmodule Importer.CrimeFileLoaderTest do
  use ExUnit.Case
  alias Importer.CrimeFileLoader
  alias Importer.CrimeRepo 
  alias Importer.Crime

  test "saves files from all sub directories" do
    CrimeRepo.delete_all(Crime) 
 
    scan_directory = "/tmp/#{Ecto.UUID.generate}"
    create_directories(scan_directory, ["1","2","3"]) 
    |> example_crime_files

    assert CrimeRepo.all(Crime) |> Enum.count  == 0 
    CrimeFileLoader.import(scan_directory)
    assert CrimeRepo.all(Crime) |> Enum.count  == 6 
  end 
    

  defp create_directories(root, directories)  do
   File.mkdir! root
   directories
   |> Enum.each(fn dir -> Path.join(root, dir) |> File.mkdir! end)
   {root, directories}
  end

  defp example_crime_files({root, directories}) do
    directories
    |> Enum.each(fn dir -> 
          Path.join(root, dir) 
          |> Path.join("crime.csv")
          |> File.write!(example_crime()) end) 
  end

  defp example_crime do
  """
 Crime ID,Month,Reported by,Falls within,Longitude,Latitude,Location,LSOA code,LSOA name,Crime type,Last outcome category,Context
   ,2016-01,Avon and Somerset Constabulary,Avon and Somerset Constabulary,-2.511927,51.409435,On or near Harlech Close,E01014399,Bath and North East Somerset 001A,Anti-social behaviour,,
   ,2016-01,Avon and Somerset Constabulary,Avon and Somerset Constabulary,-2.495055,51.422132,On or near Cross Street,E01014399,Bath and North East Somerset 001A,Anti-social behaviour,,
  """
  end
end
