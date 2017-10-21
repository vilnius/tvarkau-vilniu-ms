TVARKAU_VILNIU_DB = YAML.safe_load(ERB.new(File.read(Rails.root.join('config', 'database_vilnius.yml'))).result)[Rails.env]
