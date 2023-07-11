require 'rails_helper'

describe 'Usuário visita página de lotes' do
  it 'e vê lotes expirados' do
    user = User.create!(email: 'eduardo@leilãoestoque.com.br', password: 'eduardo123', cpf: '44047449865',
                        admin: true)

    Lot.create!(code: 'GAD459812', start_date: '04-04-2022', limit_date: '04-05-2022', min_value: 1000.00,
                dif_value: 500.00, aproved: true, user:)

    Lot.create!(code: 'CAD409829', start_date: Date.today, limit_date: 10.days.from_now, min_value: 1000.00,
                dif_value: 500.00, aproved: true, user:)

    login_as(user)

    visit root_path
    click_on 'Lotes para leilão'
    click_on 'Visualizar lotes expirados'

    expect(page).to have_content 'GAD459812'
    expect(page).to have_content 'Finalizar'
    expect(page).not_to have_content 'CAD409829'
  end
end
