defmodule Site.Resources.CrimesTest do
  use ExUnit.Case
  import Site.DataHelper
   
  test "GET should return 404 when there is no route" do
    {:ok, response} = HTTPoison.get("http://localhost:8000/crime")
    assert response.status_code == 404 
  end

  test "GET should return 200" do
    {:ok, response} = HTTPoison.get("http://localhost:8000/crimes")
    assert response.status_code == 200 
  end

  test "Get should return crimes json" do
    clear()
    ["1,2016-01,Avon and Somerset Constabulary,Avon and Somerset Constabulary,-2.511927,51.409435,On or near Harlech Close,E01014399,Bath and North East Somerset 001A,Anti-social behaviour,,"]
    |> load_examples
    {:ok, response} = HTTPoison.get("http://localhost:8000/crimes")
    assert response.body |> Poison.decode! |> length == 1 
  end

  test "Get to static crimes html should return 200" do
    {:ok, response} = HTTPoison.get("http://localhost:8000/")
    assert response.status_code == 200 
  end
  
  test "Get with filter query params should filter" do
    clear()
    load_examples()
    {:ok, response} = HTTPoison.get("http://localhost:8000/crimes?lsoa_code=E01014399&type=Anti-social%20behaviour")
    assert response.status_code == 200 
    assert response.body |> Poison.decode! |> length == 3 
  end 

  test "Get with sort should sort" do
    clear()
    load_examples()
    {:ok, response} = HTTPoison.get("http://localhost:8000/crimes?sort=lsoa_code")
    assert response.status_code == 200 
    assert response.body |> Poison.decode! |> length == 4 
  end 
end
