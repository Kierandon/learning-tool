class StandardsController < ApplicationController
  def courses
    @standard = Standard.find(params[:id])
  end
end
