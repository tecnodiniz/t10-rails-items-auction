require 'rails_helper'

feature 'Administrador registra lote' do
  scenario 'com sucesso' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
    lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                      min_value: '400', dif_value: '400', administrator: admin)

    login_as admin

    visit root_path

    click_on 'Lotes para leilão'
    click_on lot.code

    expect(current_path).to eq lot_path(lot)
    expect(page).to have_content 'Lote BAH295403'
    expect(page).to have_content "Início: #{I18n.l(Time.zone.today.to_date)}"
    expect(page).to have_content "Fim: #{I18n.l(5.days.from_now.to_date)}"
    expect(page).to have_content 'Lance mínimo: R$400.0'
    expect(page).to have_content 'Diferença de lance: R$400.0'
    expect(page).to have_content 'Status: aguardando aprovação'
  end
end
