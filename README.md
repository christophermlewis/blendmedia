# Blendmedia

This is an umbrella App containing to projects: importer and site

Both require an enviornment variable to a postgres database like so:
 
 export DATABASE_URL=postgres://user:password@localhost/db


To begin run

     mix deps.get

To Run importer

     cd apps/importer
     mix ecto.create
     mix ecto.migrate
     iex -S mix
     Importer.CrimeFileLoader.import("a directory")

The importer will recursively look for and files ending in *.csv and attempt to import them


To Run the site

    cd apps/site
    iex -S mix
    with your browser: http://localhost:8000

The site has been tested in chrome and uses Vue2
