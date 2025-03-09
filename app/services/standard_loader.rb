# app/services/standard_loader.rb
class StandardLoader
  def self.load_from_yaml(yaml_path)
    new.load_from_yaml(yaml_path)
  end

  def load_from_yaml(yaml_path)
    data = YAML.load_file(yaml_path).deep_symbolize_keys
    create_standard_from_data(data[:standard])
  end

  private

  def create_standard_from_data(data)
    standard = Standard.find_or_initialize_by(code: data[:id])

    standard.update!(
      name: data[:name],
      url: data[:url],
      description: ActionText::Content.new(data[:description])
    )

    process_sections(standard, data[:sections])

    standard
  end

  def process_sections(standard, sections_data, parent_section = nil)
    return unless sections_data

    sections_data.each do |section_data|
      section_id = section_data[:id] || section_data[:section_id] || sanitize_for_id(section_data[:name])

      section = StandardSection.find_or_initialize_by(
        standard: standard,
        section_id: section_id
      )

      section.update!(
        name: section_data[:name],
        url: section_data[:url],
        published_on: section_data[:published_on],
        parent_section: parent_section,
        description: section_data[:description] ? ActionText::Content.new(section_data[:description]) : nil
      )

      process_learning_objectives(section, section_data[:learning_objectives]) if section_data[:learning_objectives]
      process_sections(standard, section_data[:sections], section) if section_data[:sections]
    end
  end

  def process_learning_objectives(section, learning_objectives_data)
    return unless learning_objectives_data

    learning_objectives_data.each do |lo_data|
      objective_id = lo_data[:id] || sanitize_for_id(lo_data[:description])

      objective = LearningObjective.find_or_initialize_by(
        standard_section: section,
        objective_id: objective_id
      )

      objective.update!(
        description: lo_data[:description],
        completion_criteria: lo_data[:completion_criteria]
      )
    end
  end

  def sanitize_for_id(name)
    return "section_#{SecureRandom.hex(4)}" unless name
    result = name.downcase.gsub(/[^a-z0-9\s]/i, "").gsub(/\s+/, "_")
    result.blank? ? "section_#{SecureRandom.hex(4)}" : result
  end
end
