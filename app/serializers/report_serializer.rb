class ReportSerializer < ActiveModel::Serializer
  attributes :id,
             :ref_no,
             :report_type_id,
             :lat,
             :lng,
             :user_id,
             :status_id,
             :description,
             :answer,
             :license_plate_no,
             :registered_at,
             :completed_at
end
