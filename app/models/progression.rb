class Progression < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :current_step
end
