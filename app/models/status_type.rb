class StatusType < TvarkauVilniuDbBase
  self.table_name = 'PRS_STATUS_TYPES'

  alias_attribute :id, :ID
  alias_attribute :status, :STATUS
  alias_attribute :color, :COLOR
  alias_attribute :avilys_status, :AVILYS_SATUS
  alias_attribute :active, :ACTIVE
end
