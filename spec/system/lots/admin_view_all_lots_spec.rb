require 'rails_helper'

feature 'Administrador registra lote' do
  scenario 'com sucesso' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
    Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                min_value: '400', dif_value: '400', administrator: admin)
    Lot.create!(code: 'HAB295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                min_value: '200', dif_value: '100', administrator: admin, status: 3)

    Lot.create!(code: 'HAJ495403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                min_value: '800', dif_value: '900', administrator: admin, status: 5)

    login_as admin

    visit root_path

    click_on 'Lotes para leilão'

    expect(page).to have_content 'BAH295403'
    expect(page).to have_content I18n.l(Time.zone.today.to_date)
    expect(page).to have_content I18n.l(5.days.from_now.to_date)
    expect(page).to have_content '400'
    expect(page).to have_content '100'
    expect(page).to have_content '100'
    expect(page).to have_content 'aguardando aprovação'
    expect(page).to have_content 'HAB295403'
    expect(page).to have_content 'aprovado'
    expect(page).to have_content 'HAJ495403'
    expect(page).to have_content 'encerrado'
  end
end
