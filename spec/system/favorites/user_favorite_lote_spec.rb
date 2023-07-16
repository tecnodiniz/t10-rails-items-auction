require 'rails_helper'

feature 'Usuário favorita lote' do
  scenario 'com sucesso' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
    user = User.create!(email: 'user@gmail.com', cpf: '14588117602', password: 'password')
    lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                      min_value: '400', dif_value: '400', administrator: admin, status: :aproved)

    login_as user, scope: :user

    visit root_path

    click_on lot.code
    click_on 'Favoritar lote'

    expect(page).to have_content 'Lote favoritado'
  end
end
