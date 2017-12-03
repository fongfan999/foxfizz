class UserService < ApplicationService
  def self.from_omniauth(auth)
    return if auth.extra.raw_info.hd != User::SCHOOL_HD

    student_id = auth.info.email[/\d+/]
    User.where(student_id: student_id).first_or_create do |user|
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.student_id = student_id
    end
  end
end
