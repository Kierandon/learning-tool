class VerificationsController < ApplicationController
  def show
    @certificate = StandardCertificate.find_by(certificate_number: params[:certificate_number])

    if @certificate.nil?
      @verification_status = "invalid"
    else
      @verification_status = "valid"
      @standard = @certificate.standard
      @user = @certificate.user
      @completed_learning_objectives = @standard.sections.flat_map(&:learning_objectives)
                                               .select { |lo| lo.completed_by?(@user) }
    end
  end
end
