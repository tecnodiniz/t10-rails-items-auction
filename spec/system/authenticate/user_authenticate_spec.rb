require 'rails_helper' 

describe 'Usuário se autentica' do 
    it 'com sucesso' do 
        user = User.create!(email:'eduardo@gmail.com', password: 'eduardo123')

        visit new_user_session_path

        fill_in "Email",	with: "eduardo@gmail.com"
        fill_in "Password",	with: "eduardo123"  

        click_on 'Log in'

        expect(page).to have_content 'Signed in successfully.'
    end
end