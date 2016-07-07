# == Schema Information
#
# Table name: material_properties
#
#  id          :integer          not null, primary key
#  material_id :integer
#  name        :string
#  value       :string
#  use_in_name :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class MaterialProperty < ApplicationRecord
  # associations
  belongs_to :material

  # scopes
  scope :used_in_name, -> { where(use_in_name: true) }
end
