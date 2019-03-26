class ActivityController < ApplicationController
  authorize_resource :class => "ActivityController"

  def mine
    @standups = current_user
                .standups
                .includes(:dids, :todos, :blocker)
                .references(:tasks)
                .order('standup_date DESC')
  end

  def feed
  end
end
