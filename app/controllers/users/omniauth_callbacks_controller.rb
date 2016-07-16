class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def mock
    @user = User.find_for_mock(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'mock'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.mock_data'] = request.env['omniauth.auth']
      redirect_to new_user_session_url, alert: @user.errors
    end 
  end 
end
