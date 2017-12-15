defmodule Importer.CrimeParser do
  def parse(""), do: :error
  def parse(data) when data |> is_binary do
    with split when split |> length == 12 <- String.split(data, ",") do
       map = [:alias,
         :month,
         :reported_by,
         :falls_within,
         :longitude,
         :latitude,
         :location,
         :lsoa_code,
         :lsoa_name,
         :type,
         :last_outcome_category,
         :context]
      |> Enum.zip(split) 
      |> Enum.into(%{})

      {:ok, map}
    else
      _ -> :error
    end
  end 
  def parse(_), do: :error
end

defmodule Importer.CrimeLoader do
  alias Importer.Crime
  alias Importer.CrimeRepo

  def save(crime) do
    Crime.changeset(%Crime{}, crime) 
    |> CrimeRepo.insert
  end 
end
