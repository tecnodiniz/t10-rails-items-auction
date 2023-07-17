require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    User.create!(email: 'eduardo@gmail.com', password: 'eduardo123', cpf: '44047449865', admin: true)

    visit root_path
    click_on 'Login'

    fill_in 'E-mail',	with: 'eduardo@gmail.com'
    fill_in 'Senha',	with: 'eduardo123'

    click_on 'Log in'

    expect(page).to have_content 'Login efetuado com sucesso'
    expect(current_path).to  eq root_path
  end

  it 'com cpf bloqueado' do
    user = User.create!(email: 'eduardo@gmail.com', password: 'eduardo123', cpf: '44047449865', admin: true)
    BlockedCpf.create!(cpf: '44047449865', user:)

    visit root_path
    click_on 'Login'

    fill_in 'E-mail',	with: 'eduardo@gmail.com'
    fill_in 'Senha',	with: 'eduardo123'

    click_on 'Log in'

    expect(page).to have_content 'Seu CPF está bloqueado. Entre em contato com o suporte para obter ajuda.'
    expect(current_path).to  eq new_user_session_path
  end
end
