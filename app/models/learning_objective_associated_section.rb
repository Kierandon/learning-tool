class LearningObjectiveAssociatedSection < ApplicationRecord
  belongs_to :learning_objective
  belongs_to :standard_section
end
