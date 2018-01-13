class CitySerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :lat, :lng
end
