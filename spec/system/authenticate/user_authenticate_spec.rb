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
end
