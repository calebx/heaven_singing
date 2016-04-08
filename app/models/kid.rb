class Kid < ActiveRecord::Base
  validates :name, :phone, :school, presence: true
  validates :name, uniqueness: { scope: :phone, message: "same kids appears" }

  class << self
    def seek(name, phone)
      kid = self.where(name: name, phone: phone).first
      if kid.present?
        return kid
      else
        return self.where(phone: phone).find { |k| k.name.include? name }
      end
    end
  end
end
