class Reports::Dto < ::Dto
  def self.for(reports)
    new(reports).all
  end

  attr_reader :reports, :return_array

  def initialize(reports)
    @return_array = reports.is_a?(Array)
    @reports = Array.wrap(reports)
  end

  def all
    return_array ? as_array : as_array.first
  end

  private

  def as_array
    @reports.map do |report|
      {
        id: report[:ID],
        report_type_id: report[:PROBLEM_TYPE_ID],
        address: report[:ADDRESS],
        lat: report[:COORDS_GOOGLE_LAT],
        lng: report[:COORDS_GOOGLE_LNG],
        description: report[:DESCRIPTION],
        user_id: report[:USER_ID],
        status_id: report[:STATUS_ID],
        answer: report[:ANSWER],
        car_plate_no: report[:CAR_PLATE_NO],
        violation_datetime: report[:VIOLATION_DATETIME],
        registration_date: report[:REG_DATE],
        complete_date: report[:COMPLETE_DATE],
      }
    end
  end
end
