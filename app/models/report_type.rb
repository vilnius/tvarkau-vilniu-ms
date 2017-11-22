class ReportType < TvarkauVilniuDbBase
  self.table_name = 'PRS_PROBLEM_TYPES'

  alias_attribute :id, :ID
  alias_attribute :title, :PROBLEM_TYPE
  alias_attribute :short_label, :SHORT_LABEL
  alias_attribute :city_id, :CITY_ID
end
