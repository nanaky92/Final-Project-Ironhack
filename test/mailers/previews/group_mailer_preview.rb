# Preview all emails at http://localhost:3000/rails/mailers/group_mailer
class GroupMailerPreview < ActionMailer::Preview
  def welcome_preview
    GroupMailer.welcome(User.first)
  end
end