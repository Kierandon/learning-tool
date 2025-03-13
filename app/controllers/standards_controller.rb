class StandardsController < ApplicationController
  before_action :set_standard, only: [ :courses, :generate_certificate, :certificate ]

  def index
    @standards = Standard.where(visibility: true)
  end

  def courses
    @standard = Standard.find(params[:id])
  end

  def generate_certificate
    completion_percentage = @standard.completion_percentage(current_user)

    if completion_percentage >= 100
      certificate = StandardCertificate.find_or_create_by(
        user: current_user,
        standard: @standard
      ) do |cert|
        cert.issue_date = Date.today
        cert.certificate_number = generate_certificate_number
        cert.competency_level = determine_competency_level
      end

      redirect_to certificate_standard_path(@standard)
    else
      flash[:alert] = "You must complete 100% of the standard to generate a certificate."
      redirect_to courses_standard_path(@standard)
    end
  end

  def certificate
    @certificate = StandardCertificate.find_by(user: current_user, standard: @standard)

    if @certificate.nil?
      flash[:alert] = "No certificate found. Please complete the standard first."
      redirect_to courses_standard_path(@standard)
      return
    end

    @completed_learning_objectives = @standard.sections.flat_map(&:learning_objectives)
                                             .select { |lo| lo.completed_by?(current_user) }
  end

  private

  def set_standard
    @standard = Standard.find(params[:id])
  end

  def generate_certificate_number
    "#{@standard.code}-#{current_user.id}-#{Time.now.to_i}"
  end

  def determine_competency_level
    "Proficient"
  end
end
