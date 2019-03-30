class AccountsController < ApplicationController
  load_and_authorize_resource find_by: :hash_id, except: [:create]
  around_action :use_time_zone, only: [:edit]

  def new
    redirect_to root_path unless current_user.account.nil?
    @account = Account.new
  end

  def show
    set_teams_and_standups(Date.today.iso8601)
  end

  def standups
    set_teams_and_standups(current_date)
  end

  def create
    @account = Account.new(account_params)
    result = NewRegistrationService.(account: @account, user: current_user)
    if result.success?
      redirect_to root_path, success: 'Your account has been created!'
    else
      @account = result.account
      render :new
    end
  end

  private
  def account_params
    params.require(:account).permit(:name, :addr1, :addr2,
                                    :city, :state, :zip,
                                    :country)
  end

  def set_teams_and_standups(date)
    @team = Team.friendly.includes(:users).find(params[:id])
    @standups = @team.users.flat_map do |u|
      u.standups.where(standup_date: date)
      .includes(:dids, :todos, :blockers)
      .references(:tasks)
    end
  end
end
