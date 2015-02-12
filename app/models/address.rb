# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  description      :string(255)
#  addressable_id   :integer
#  name             :string(255)
#  street           :string(255)
#  house_number     :string(255)
#  zip              :string(255)
#  city             :string(255)
#  country          :string(255)
#  fmid             :integer
#  addressable_type :string
#

class Address < ActiveRecord::Base
  
  belongs_to :addressable, polymorphic: true
  has_many :letters



  def full_address(hide_name=false)
  	(hide_name == 1 ? "" : self.name + " / ") + self.street + " " + self.house_number + " / " + self.zip + " " + self.city + " / " + self.country
  end
  
end
