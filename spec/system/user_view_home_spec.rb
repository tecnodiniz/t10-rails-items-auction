require 'rails_helper'

describe 'Usuário visita tela inicial' do 
    it 'com sucesso' do 
        user = User.create!(email:'eduardo@gmail.com', password: 'eduardo123', admin: false, cpf: '44047449865')

        login_as(user)

        visit root_path

        expect(page).to have_content 'Página Principal'
    end
    
end