class Kid < ActiveRecord::Base
  validates :name, :phone, :school, presence: true
  validates :name, uniqueness: { scope: :phone, message: "same kids appears" }
end
