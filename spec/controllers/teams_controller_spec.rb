require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  login_admin

  let(:account) { @admin.account }

  let(:valid_attributes) do
    {
      name: Faker::Team.name,
      description: Faker::Company.catch_phrase,
      account_id: account.id,
      timezone: 'Arizona',
      days: ['monday'],
      has_reminder: true,
      reminder_time: Time.now,
      has_recap: true,
      recap_time: Time.now
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,
      description: Faker::Company.catch_phrase,
      account_id: account.id,
      timezone: 'Arizona'
    }
  end

  describe 'GET #index' do
    it 'assigns all teams as @teams' do
      team = FactoryBot.create(:team, account_id: account.id)
      get :index, params: {}
      expect(assigns(:teams)).to eq([team])
    end
  end

  describe 'GET #standups' do
    it 'assigns all standups as @standups' do
      team = FactoryBot.create(:team, account_id: account.id)
      FactoryBot.create(:team_membership, user_id: @admin.id, team_id: team.id)
      FactoryBot.create(:standup, user_id: @admin.id)
      get :standups, params: { id: team.hash_id, date: Date.today.iso8601 }
      expect(assigns(:team)).to eq(team)
      expect(assigns(:standups)).to eq([])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested team as @team' do
      team = FactoryBot.create(:team, account_id: account.id)
      get :show, params: { id: team.to_param }
      expect(assigns(:team)).to eq(team)
    end
  end

  describe 'GET #new' do
    it 'assigns a new team as @team' do
      get :new, params: {}
      expect(assigns(:team)).to be_a_new(Team)
    end
  end
  
  describe 'GET #edit' do
    it 'assigns the requested team as @team' do
      team = FactoryBot.create(:team, account_id: account.id)
      get :edit, params: { id: team.to_param }
      expect(assigns(:team)).to eq(team)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Team' do
        expect do
          post :create, params: { team: valid_attributes }
        end.to change(Team, :count).by(1)
      end

      it 'assigns a newly created team as @team' do
        post :create, params: { team: valid_attributes }
        expect(assigns(:team)).to be_a(Team)
        expect(assigns(:team)).to be_persisted
      end

      it 'redirects to the created team' do
        post :create, params: { team: valid_attributes }
        expect(response).to redirect_to(Team.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved team as @team' do
        post :create, params: { team: invalid_attributes }
        expect(assigns(:team)).to be_a_new(Team)
      end

      it "re-renders the 'new' template" do
        post :create, params: { team: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          name: Faker::Team.name,
          description: Faker::Company.catch_phrase,
          timezone: 'Arizona',
          days: ['monday']
        }
      end

      it 'updates the requested team' do
        @team = FactoryBot.create(:team, account_id: account.id)
        put :update, params: { id: @team.to_param, team: new_attributes }
        @team.reload
        expect(@team.updated_at).to be > @team.created_at
      end

      it 'assigns the requested team as @team' do
        team = FactoryBot.create(:team, account_id: account.id)
        put :update, params: { id: team.to_param, team: valid_attributes }
        expect(assigns(:team)).to eq(team)
      end

      it 'redirects to the teams' do
        team = FactoryBot.create(:team, account_id: account.id)
        put :update, params: { id: team.to_param, team: valid_attributes }
        expect(response).to redirect_to(teams_path)
      end
    end

    context 'with invalid params' do
      it 'assigns the team as @team' do
        team = FactoryBot.create(:team, account_id: account.id)
        put :update, params: { id: team.to_param, team: invalid_attributes }
        expect(assigns(:team)).to eq(team)
      end

      it "re-renders the 'edit' template" do
        team = FactoryBot.create(:team, account_id: account.id)
        put :update, params: { id: team.to_param, team: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested team' do
      team = FactoryBot.create(:team, account_id: account.id)
      expect do
        delete :destroy, params: { id: team.to_param }
      end.to change(Team, :count).by(-1)
    end

    it 'redirects to the teams list' do
      team = FactoryBot.create(:team, account_id: account.id)
      delete :destroy, params: { id: team.to_param }
      expect(response).to redirect_to(teams_url)
    end
  end
end