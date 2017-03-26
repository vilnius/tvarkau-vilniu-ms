# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
{
  'Aplinkos tvarkymas' => false,
  'Beglobių gyvūnų gaudymas' => false,
  'Dviračių takų problemos' => false,
  'Eismo organizavimas' => false,
  'Energetika ir inžineriniai tinklai' => false,
  'Gatvių apšvietimas' => false,
  'Gatvių priežiūra ir tvarkymas' => false,
  'Gyvūnų laikymo Vilniaus miesto Savivaldybės teritorijoje taisyklių pažeidimai' => false,
  'Išorinės reklamos įrengimo taisyklių pažeidimai' => false,
  'Kapinių priežiūra' => false,
  'Komunalinių atliekų tvarkymas' => false,
  'Pastatų administravimas' => false,
  'Statinių priežiūra' => false,
  'Tiltų, viadukų, tunelių ir estakadų priežiūra' => false,
  'Transporto priemonių stovėjimo tvarkos pažeidimai' => true,
  'Triukšmo prevencijos viešosiose vietose taisyklių pažeidimas' => false,
  'Tvarkymo ir švaros taisyklių pažeidimas' => false,
  'Vaikų žaidimo ir sporto aikštelių priežiūra bei įrengimas' => false,
  'Viešasis transportas' => false,
  'Želdynų priežiūra (medžių ir krūmų genėjimas bei kirtimas' => false
}
  .each do |key, value|
  ReportType.create!(title: key, validate_plate: value)
end