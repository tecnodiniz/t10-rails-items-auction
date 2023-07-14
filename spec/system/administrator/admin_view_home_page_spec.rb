require 'rails_helper'

feature 'Usuário administrator acessa página inicial' do
  scenario 'com sucesso' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', password: 'password', cpf: '44047449865')

    login_as admin
    visit root_path

    expect(page).to have_content 'Página Principal'
    expect(page).to have_content 'Lotes em andamento'
    expect(page).to have_content 'Lotes futuros'
  end
end
