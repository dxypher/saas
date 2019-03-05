module FeatureMacros
  def login_user
    before(:each) do
      @user = FactoryBot.create(:user)
      @user.add_role :user
      login_as(@user, :scope => :user)
    end
  end
end