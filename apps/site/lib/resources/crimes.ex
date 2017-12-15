defmodule Site.Resources.Crimes do
  alias Importer.CrimeRepo
  alias Site.Crime


  def init(request, state), do: {:cowboy_rest, request, state}

  def content_types_provided(request, state), do: {[{"text/json", :json}], request, state}
  def json(request, state) do
    json = :cowboy_req.parse_qs(request)
    |> to_atoms
    |> filters 
    |> sort
    |> CrimeRepo.all() 
    |> Poison.encode!
    {json, request, state}
  end

  defp filters(params) do
    {filters, params} = params
                        |> Map.split(Crime.filters)
   
    {filters |> Crime.filter, params}
  end 
 
  defp to_atoms(params) do
   (for {k, v} <- params, into: %{}, do: {k |> String.to_atom, v}) 
  end 

  defp sort({query, %{sort: param}}) do
    Crime.sort(param |> String.to_atom, query) 
  end
  defp sort({query, param}), do: query
  
end
