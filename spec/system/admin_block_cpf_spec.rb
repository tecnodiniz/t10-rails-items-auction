require 'rails_helper'

feature 'Administrador bloqueia cpf' do
  scenario 'com sucesso' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', password: 'password', cpf: '44047449865')

    login_as admin

    visit root_path

    click_on 'Gerenciar usuários'

    click_on 'Bloquear CPF'

    fill_in 'CPF', with: '47841884281'
    click_on 'Bloquear'

    expect(page).to have_content 'CPF bloqueado com sucesso'
  end
  scenario 'com usuário existente na aplicação' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', password: 'password', cpf: '44047449865')
    User.create!(email: 'user@gmail.com', password: 'password', cpf: '47841884281')

    login_as admin

    visit root_path

    click_on 'Gerenciar usuários'

    click_on 'Bloquear CPF'

    fill_in 'CPF', with: '47841884281'
    click_on 'Bloquear'

    expect(page).to have_content 'CPF bloqueado com sucesso'
  end
end
