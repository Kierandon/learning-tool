require "application_system_test_case"

class HomepageTest < ApplicationSystemTestCase
  test "visiting the homepage" do
    visit root_url

    Course.all.each do |course|
      assert_selector "h2", text: course.title
      assert_selector "p", text: course.description
      if course.image_url.nil?
        assert_selector "img[src='https://placehold.co/600x400']"
      else
        assert_selector "img[src='#{course.image_url}']"
      end
    end

    assert_selector "div[data-test-id='courses-list-header']", text: "Available Courses"
  end
end
