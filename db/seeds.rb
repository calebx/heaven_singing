require 'csv'
file = 'db/kids.csv'
values = CSV.parse(File.read(file), headers: true).map do |row|
  row.to_hash
end

kids = values.map do |k|
  Kid.create(name: k['name'], phone: k['phone'], school: k['school'], grade: k['grade'], song: k['song'], group: k['group'])
end

grouped_kids = Kid.all.group_by(&:group)
grouped_kids.each do |group, ks|
  ks.shuffle.each_with_index do |k, i|
    k.draw = i + 1
    k.save
  end
end
