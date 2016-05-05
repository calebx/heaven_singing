class Lot < ActiveRecord::Base
  def display_num
    if self.half == "后半场"
      extra = Lot.where(group: self.group, half: "前半场").count
      return self.number + extra
    else
      return self.number
    end
  end
end
