require 'rails_helper'

describe 'A partir da tela inicial' do
  it 'usuário administrador vê link de gerenciar usuários' do
    user = User.create!(email: 'eduardo@leilaodogalpao.com.br', password: 'password', cpf: '44047449865', admin: true)
    login_as(user)

    visit root_path

    expect(page).to have_content 'Gerenciar usuários'
  end
  it 'usuario não autenticado não vê link' do
    visit root_path

    expect(page).not_to have_content 'Gerenciar usuários'
  end
  it 'usuário comum não vê link' do
    user = User.create!(email: 'eduardo@leilaodogalpao.com.br', password: 'password', cpf: '44047449865',
                        admin: false)
    login_as(user)

    visit root_path

    expect(page).not_to have_content 'Gerenciar usuários'
  end
end
