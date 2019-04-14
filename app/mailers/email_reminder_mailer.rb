class EmailReminderMailer < ApplicationMailer

  def reminder_email(user,team)
    @user = user
    @team = team
    mail(to: @user.email, subject: "#{team.name} Stanup Reminder!")
  end
end