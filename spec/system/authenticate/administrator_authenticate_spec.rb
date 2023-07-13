require 'rails_helper'

feature ' Administrador se loga na aplicação ' do
  scenario 'através da tela de login de administrador' do
    Administrator.create!(email: 'admin@leilaodogalpao.com.br', password: 'password', cpf: '44047449865')

    visit new_administrator_session_path

    fill_in 'Email',	with: 'admin@leilaodogalpao.com.br'
    fill_in 'Password',	with: 'password'

    click_on 'Log in'

    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_content 'admin@leilaodogalpao.com.br'

  end
  scenario 'e vê email no navbar' do
    user = Administrator.create!(email: 'admin@leilaodogalpao.com.br', password: 'password', cpf: '123456789')

    login_as user


    visit root_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'admin@leilaodogalpao.com.br'

  end



end