class PagesController < ApplicationController
  def index
    @courses = Course.all
    @standards = Standard.all
  end
end
