require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe '#create' do

    let(:params) { { email: 'a@a.com', password: '1234', name: 'Chuck Norris' } }

    before(:context) do
      invite = create(:user_invitation, email: 'a@a.com')
    end

    def do_request
      post users_path, params: { user: params }
    end

    it 'creates user' do
      # create(:user_invitation, email: params[:email])
      expect { do_request }.to change(User, :count).by(1)
    end

    it 'renders the account page' do
      # create(:user_invitation, email: params[:email])
      do_request
      expect(response).to redirect_to account_path
    end

    it 'destroys the invite record' do
      expect { do_request }.to change(UserInvitation, :count).by(-1)
    end


    context 'with invalid details' do
      let(:params) { { email: '', password: '' } }

      it 'does not create any user' do
        expect { do_request }.to change(User, :count).by(0)
      end

      it 'renders the form' do
        do_request
        expect(response.body).to have_button('Sign up now!')
      end
    end

    context 'without user invitation' do
      let(:params) { { email: 'z@z.com', password: 'password', name: 'Mr B' } }

      it 'does not create any user' do
        expect { do_request }.not_to change(User, :count)
      end

      it 'renders the form' do
        do_request
        expect(response.body).to have_button('Sign up now!')
      end
    end
  end
end
