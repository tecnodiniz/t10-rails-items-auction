require 'rails_helper'

describe 'Usuário se cadastra na plataforma' do
  it 'com sucesso' do
    visit root_path

    click_on 'Login'
    click_on 'Sign up'

    fill_in 'E-mail',	with: 'diniz@gmail.com'
    fill_in 'Senha',	with: 'password123'
    fill_in 'Confirme sua senha',	with: 'password123'
    fill_in 'CPF', with: '23667678703'

    click_on 'Sign up'
    new_user = User.last

    expect(page).to have_content 'Você realizou seu registro com sucesso'
    expect(new_user.admin).to eq false
  end
  it 'e falha ao usar o domínio de um administrador do sistema' do
    visit root_path

    click_on 'Login'
    click_on 'Sign up'

    fill_in 'E-mail',	with: 'diniz@leilaodogalpao.com.br'
    fill_in 'Senha',	with: 'password123'
    fill_in 'Confirme sua senha',	with: 'password123'
    fill_in 'CPF', with: '23667678703'

    click_on 'Sign up'

    expect(page).to have_content 'O domínio @leilaodogalpao.com.br não é permitido'
  end
end
