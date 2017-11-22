class MainCfg < TvarkauVilniuDbBase
  self.table_name = 'PRS_MAIN_CFG'

  alias_attribute :id, :ID
  alias_attribute :city_full_name, :CITY_FULL_NAME
  alias_attribute :city_system_name, :CITY_SYSTEM_NAME
  alias_attribute :city_name, :CITY_NAME
  alias_attribute :page_size, :PAGE_SIZE
end
