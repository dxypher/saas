class SlackNotificationJob < ApplicationJob
  queue_as :default

  def perform(user)
    notifier = Slack::Notifier.new(
      "https://hooks.slack.com/services/*your specific slack webhook url*"
    )
    notifier.ping "A New User has appeared! #{user.account.name} - #{user.name} || ENV: #{Rails.env}"
  end
end
