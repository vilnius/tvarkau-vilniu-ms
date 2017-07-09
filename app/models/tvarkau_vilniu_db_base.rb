class TvarkauVilniuDbBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection TVARKAU_VILNIU_DB
end