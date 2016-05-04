class Kid < ActiveRecord::Base
  validates :name, :phone, :school, :who, presence: true
  validates :name, uniqueness: { scope: :phone, message: "same kids appears" }
  has_one :lot

  class << self
    def seek(name, phone)
      kid = self.where(name: name, phone: phone).first
      return kid if kid.present?
      kid = self.where(phone: phone).find { |k| k.name.include? name }
      return kid
    end
  end

  def draw_a_lot
    if lot
      return lot
    else
      lot = nil
      Lot.transaction do
        lot = Lot.lock.where(group: self.group, half: self.half).where(kid_id: nil).order("RANDOM()").first
        lot.update(kid_id: self.id) if lot
      end
      return lot
    end
  end
end
