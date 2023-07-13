require 'rails_helper'

feature 'Adminsitrador cadastra novo admin' do
  scenario 'com sucesso' do
    user = Administrator.create!(email: 'admin@leilaodogalpao.com.br', password: 'password', cpf: '44047449865')

    login_as user

    visit root_path
    click_on 'Gerenciar usuários'
    click_on 'Novo administrador'

    fill_in 'Email', with:'administrador@leilaodogalpao.com.br'
    fill_in 'CPF', with:'123456789'
    fill_in 'Password', with:'password'
    fill_in 'Password confirmation', with:'password'

    click_on 'Criar Administrator'

    expect(page).to have_content 'Administrador cadastrado com sucesso'
    expect(page).to have_content 'administrador@leilaodogalpao.com'

  end

  scenario 'falha ao não usar email com domínio @leilaodogalpao.com.br' do 
    user = Administrator.create!(email: 'admin@leilaodogalpao.com.br', password: 'password', cpf: '44047449865')

    login_as user

    visit root_path
    click_on 'Gerenciar usuários'
    click_on 'Novo administrador'

    fill_in 'Email', with:'administrador@gmail.com.br'
    fill_in 'CPF', with:'123456789'
    fill_in 'Password', with:'password'
    fill_in 'Password confirmation', with:'password'

    click_on 'Criar Administrator'

    expect(page).to have_content 'Erro, não foi possível criar administrador'
    expect(page).to have_content 'Email email deve conter o domínio @leilaodogalpao.com.br'

  end
end