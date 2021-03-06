class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_course_enrollment_for_current_lesson, :only => [:show]

  def show
  end

  private
  def require_course_enrollment_for_current_lesson
    current_course = current_lesson.section.course

    if current_user.enrolled_in?(current_course) != true
      if current_lesson.section.course.user != current_user
       redirect_to course_path(current_course), :alert => 'You Must Be Enrolled In This Course To View Its Lesson(s)'
      end
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
