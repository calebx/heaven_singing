require 'csv'
file = 'db/kids.csv'
values = CSV.parse(File.read(file), headers: true).map do |row|
  row.to_hash
end

kids = values.map do |k|
  Kid.create(name: k['name'].strip, phone: k['phone'].strip, school: k['school'].strip, grade: k['grade'].strip, song: k['song'].strip, group: k['group'].strip)
end

grouped_kids = Kid.all.group_by(&:group)
grouped_kids.each do |group, ks|
  ks.shuffle.each_with_index do |k, i|
    k.draw = i + 1
    k.save
  end
end
