require 'csv'
file = 'db/kids.csv'

def check_value(k, att)
  value = k[att]
  return value.present? ? value.strip.gsub(/\s/, '') : value
end

kids_values = CSV.parse(File.read(file), headers: true).map { |row| row.to_hash }
kids_values.each do |k|
  Kid.create!(
    name: check_value(k, 'name'),
    school: check_value(k, 'school'),
    phone: check_value(k, 'phone'),
    district: check_value(k, 'district'),
    song_a: check_value(k, 'song_a'),
    song_b: check_value(k, 'song_b'),
    category: check_value(k, 'category'),
    group: check_value(k, 'group')
  )
end

grouped_kids = Kid.all.group_by { |k| k.group }
grouped_kids.each do |_, ks|
  ks.each_with_index do |k, i|
    Lot.create(group: k.group, number: i + 1)
  end
end
