require 'rails_helper'

describe 'Usuário visita tela inicial' do 
    it 'com sucesso' do 

        visit root_path

        expect(page).to have_content 'Página Principal'
    end
end