class ReportType < TvarkauVilniuDbBase
  self.table_name = 'PRS_PROBLEM_TYPES'

  alias_attribute :id, :ID
  alias_attribute :title, :PROBLEM_TYPE
end
