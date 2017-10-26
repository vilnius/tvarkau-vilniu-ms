TVARKAU_VILNIU_DB = YAML.load(ERB.new(File.read(Rails.root.join('config', 'database_vilnius.yml'))).result)[Rails.env]
