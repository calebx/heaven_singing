require 'csv'
file = 'db/kids.csv'
values = CSV.parse(File.read(file), headers: true).map do |row|
  row.to_hash
end

# kids = values.map do |k|
#   Kid.create(name: k['name'].strip, phone: k['phone'].strip, school: k['school'].strip, grade: k['grade'].strip, song: k['song'].strip, group: k['group'].strip)
# end

# grouped_kids = Kid.all.group_by(&:group)
# grouped_kids.each do |group, ks|
#   ks.shuffle.each_with_index do |k, i|
#     k.draw = i + 1
#     k.save
#   end
# end

# file = 'db/after_kids.csv'
# values = CSV.parse(File.read(file), headers: true).map do |row|
#   row.to_hash
# end

kids = values.map do |k|
  Kid.create(name: k['name'].strip, phone: k['phone'].strip, school: k['school'].strip, grade: k['grade'].strip, song: k['song'].strip, group: k['group'].strip)
end

grouped_kids = Kid.all.group_by(&:group)
grouped_kids.each do |group, ks|
  ks.each_with_index do |k, i|
    Lot.create(group: group, number: i+1)
  end
end

# groups = Kid.all.map(&:group).uniq
# groups.each do |group|
#   max_draw = Kid.where(group: group).order(draw: :desc).first.draw
#   draw = max_draw
#   Kid.where(group: group).where(draw: nil).order(:id).each do |kid|
#     draw += 1
#     kid.update(draw: draw)
#   end
# end

# k = Kid.where(phone: 18657197699).first
# k.name = "陈博涵 邓筱添"
# k.save