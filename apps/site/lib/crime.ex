defmodule Site.Crime do
  import Ecto.Query
  alias Importer.Crime
  
   def filters(), do: ~w(alias month reported_by falls_within longitude latitude location lsoa_code lsoa_name type last_outcome_category context)a

  def filter(params) do
    params
    |> Enum.reduce(Crime, &filter/2)
  end

  def filter({param, value}, query) do 
    from c in query,
    where: field(c, ^param) == ^value 
  end

  def sort(field, query) do
    from c in query,
    order_by: ^field
  end 
    
end
