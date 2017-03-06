# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
['Aplinkos tvarkymas',
 'Beglobių gyvūnų gaudymas',
 'Dviračių takų problemos',
 'Eismo organizavimas',
 'Energetika ir inžineriniai tinklai',
 'Gatvių apšvietimas',
 'Gatvių priežiūra ir tvarkymas',
 'Gyvūnų laikymo Vilniaus miesto Savivaldybės teritorijoje taisyklių pažeidimai',
 'Išorinės reklamos įrengimo taisyklių pažeidimai',
 'Kapinių priežiūra',
 'Komunalinių atliekų tvarkymas',
 'Pastatų administravimas',
 'Statinių priežiūra',
 'Tiltų, viadukų, tunelių ir estakadų priežiūra',
 'Transporto priemonių stovėjimo tvarkos pažeidimai',
 'Triukšmo prevencijos viešosiose vietose taisyklių pažeidimas',
 'Tvarkymo ir švaros taisyklių pažeidimas',
 'Vaikų žaidimo ir sporto aikštelių priežiūra bei įrengimas',
 'Viešasis transportas',
 'Želdynų priežiūra (medžių ir krūmų genėjimas bei kirtimas'].each do |type|
  ReportType.create!( { :title => type} )
end