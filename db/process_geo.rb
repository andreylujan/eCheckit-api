f = File.open("./db/region_cl.sql", "r")

regions = {}

f.each_line do |line|
    info = line.split(',')
    region_id = info[0]
    name = info[1].strip.mb_chars.downcase.to_s.capitalize
    roman = info[2].strip
    regions[region_id] = {
        name: name,
        roman: roman,
        provinces: {},
        communes: []
    }
end

f.close

provinces = {}

f = File.open("./db/provincia_cl.sql", "r")
f.each_line do |line|
    info = line.split(',')
    province_id = info[0]
    region_id = info[1]
    name = info[2].strip
    provinces[province_id] = {
        name: name,
        communes: [],
        region_id: region_id
    }
    regions[region_id][:provinces][province_id] = provinces[province_id]
end

f.close

f = File.open("./db/comuna_cl.sql", "r")
f.each_line do |line|
    info = line.split(',')
    commune_id = info[0]
    province_id = info[1]
    name = info[2].gsub("\n", "").strip.mb_chars.downcase.to_s.capitalize
    regions[provinces[province_id][:region_id]][:communes] << name
end

f.close

data = []
regions.each do |key, region|
    region.delete(:provinces)
    data << region
end

data.each do |region|
    r = Region.find_by_name(region[:name])
    if r.nil?
        r = Region.create name: region[:name], roman_numeral: region[:roman]
    end
    region[:communes].each do |commune|
        c = Commune.find_by_region_id_and_name r.id, commune
        if c.nil?
            Commune.create region: r, name: commune
        end
    end
end