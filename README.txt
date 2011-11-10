data project demo
-----------------

The point of this project was to demonstrate data import/munging skills
and to create a nice dynamic query interface. I had interviewed with a
research team that has their data scattered among several different
systems (hence data importing and rearranging - to port data between
systems). They also have a tool that lets them create their own queries
into one of those datasets, but it is really clunky to use.

So I looked around for some free data that had some kind of central
"subject" with several types of other data related into it, to parallel
the patients that the research group has as their research subjects. I
settled on the European Union's public statistics with their
statistical regions as my "subjects."

The data importing scripts are in tools/ with data/ being the files
actually imported, and db/data.yml containing the imported data (thanks
to yaml_db). I kept the data imported small because I wanted to stay
inside the 5MB of a free heroku database, and because I wanted to get
something visible done quickly. So there isn't a whole lot of data
munging demonstrated, but the basics are there: rearranging the data
structure, translating their letter flags into boolean fields (not
revealed in the web interface), and extracting the countries from the
region list (the country list then had to be hand-tweaked).

The querying interface is a Rails 3.0 app. Some of the data are yearly
numbers, and some are three-year averages (as explained on
http://floating-stream-101.heroku.com/about_data ). This made for a
more complicated joining situation than I wanted to foist on the user,
so I brought in the rails_sql_views gem to let me create database views
in my migrations. (I then had to fix bugs in rails_sql_views' schema
dump and postgres adapter: https://github.com/laripk/rails_sql_views .)


A note to my agile programming friends: I know there aren't nearly 
enough tests. This is pretty much all spike at this point. 
Tests will be added when I revisit this project.

