defmodule Importer.CrimeFileLoader do
  alias Importer.CrimeParser
  alias Importer.CrimeLoader
  @async_timeout 300000
  def import(root_dir) do
    tasks = Path.wildcard("#{root_dir}/**/*.csv")
    |> Enum.map(fn file -> 
                    Task.async(fn ->
                      file 
                      |> File.read! 
                      |> String.split("\n")
                      |> Enum.drop(1) 
                      |> Enum.each(fn crime -> 
                        crime
                        |> CrimeParser.parse 
                        |> save end) 
                      end)
                end)                   
    tasks
    |> Enum.each(fn task -> task |> Task.await(@async_timeout) end)
  end

  defp save({:ok, crime}), do: crime |> CrimeLoader.save
  defp save(:error), do: :nop 
end
