require 'rails_helper'

describe 'Usuário visita página de itens' do
  it 'e vê link para criar novos itens caso seja administrador' do
    user = User.create!(email: 'eduardo@leilaodogalpao.com.br', password: 'password', cpf: '44047449865', admin: true)
    login_as(user)

    visit root_path

    click_on 'Itens'

    expect(page).to have_content 'Cadastrar item para leilão'
  end
  it 'e não vê link para criar novos itens caso não seja administrador' do
    user = User.create!(email: 'eduardo@leilaodogalpao.com.br', password: 'password', cpf: '44047449865',
                        admin: false)
    login_as(user)

    visit root_path

    click_on 'Itens'

    expect(page).not_to have_content 'Cadastrar item para leilão'
  end

  it 'e não vê link para criar novos itens caso não seja administrador e nem um usuário autenticado' do
    visit root_path

    click_on 'Itens'

    expect(page).not_to have_content 'Cadastrar item para leilão'
  end
end
