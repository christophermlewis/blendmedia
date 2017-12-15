defmodule Site.DataHelper do
  alias Importer.CrimeRepo
  def clear(), do: CrimeRepo.delete_all(Importer.Crime)     
  def load_examples() do
    ["1,2016-01,Avon and Somerset Constabulary,Avon and Somerset Constabulary,-2.511927,51.409435,On or near Harlech Close,E01014399,Bath and North East Somerset 001A,Anti-social behaviour,,",",2016-01,Avon and Somerset Constabulary,Avon and Somerset Constabulary,-2.495055,51.422132,On or near Cross Street,E01014399,Bath and North East Somerset 001A,Anti-social behaviour,,",",2016-01,Avon and Somerset Constabulary,Avon and Somerset Constabulary,-2.511927,51.409435,On or near Harlech Close,E01014399,Bath and North East Somerset 001A,Anti-social behaviour,,",",2016-01,Avon and Somerset Constabulary,Avon and Somerset Constabulary,-2.495055,51.422132,On or near Cross Street,E01014399,Bath and North East Somerset 001A,unknown,,"]
    |> load_examples
  end


  def load_examples(examples) do 
     examples
     |> Enum.each(fn crime -> 
                 crime
                 |> Importer.CrimeParser.parse
                 |> (fn {:ok, crime} -> crime |> Importer.CrimeLoader.save end).() 
                 end)
  end
end
