# == Schema Information
#
# Table name: series_steps
#
#  id           :integer          not null, primary key
#  series_id    :integer
#  work_step_id :integer
#  comment      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_series_steps_on_series_id     (series_id)
#  index_series_steps_on_work_step_id  (work_step_id)
#

class SeriesStep < ActiveRecord::Base

  # associations
  belongs_to :series
  belongs_to :work_step
  has_many :entries, dependent: :destroy, class_name: "SeriesStepEntry"

  accepts_nested_attributes_for :entries, allow_destroy: true

  delegate :product, to: :series
  delegate :name, to: :series
  
  # Scopes


  # methods
  def total(size: nil)
    if size
      self.entries.sum(size.to_sym)
    else
      self.entries.to_a.sum(&:total)
    end
  end

end
