class Kid < ActiveRecord::Base
  validates :name, :phone, :school, :who, presence: true
  validates :who, uniqueness: { scope: :phone, message: "same kids appears" }
  has_one :lot

  class << self
    def seek(who, phone)
      kid = self.where(who: who, phone: phone).first
      return kid if kid.present?
      kid = self.where(phone: phone).find { |k| k.who.include? who }
      return kid if kid.present?
      kid = self.where(phone: phone).find { |k| k.school.include? who } if who.present? && who.length >= 4
      return kid
    end
  end

  def draw_a_lot
    if lot
      return lot
    else
      lot = nil
      Lot.transaction do
        lot = Lot.lock.where(group: self.group).where(kid_id: nil).order("RANDOM()").first
        lot.update(kid_id: self.id) if lot
      end
      return lot
    end
  end
end
