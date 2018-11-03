class ReportTypeSerializer < ActiveModel::Serializer
  attributes :id, :city_id, :title, :short_label, :requires_photos, :requires_viisp_auth,
    :requires_license_plate_no, :requires_violation_timestamp
end
