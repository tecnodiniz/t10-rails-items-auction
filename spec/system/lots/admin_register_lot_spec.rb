require 'rails_helper'

feature 'Administrador registra lote' do
  scenario 'com sucesso' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')

    login_as admin

    visit root_path

    click_on 'Lotes para leilão'
    click_on 'Cadastrar novo lote'

    fill_in 'Código', with: 'BAH295403'
    fill_in 'Data de início', with: Time.zone.today
    fill_in 'Data limite', with: 5.days.from_now
    fill_in 'Lance mínimo', with: '400'
    fill_in 'Diferença de lance', with: '500'
    click_on 'Criar Lote'

    expect(page).to have_content 'Lote criado com sucesso'
    expect(current_path).to eq lots_path
    expect(page).to have_content 'BAH295403'
    expect(page).to have_content I18n.l(Time.zone.today.to_date)
    expect(page).to have_content I18n.l(5.days.from_now.to_date)
    expect(page).to have_content '400'
    expect(page).to have_content '500'
    expect(page).to have_content 'aguardando aprovação'
    expect(page).not_to have_button 'Aprovar lote'
  end
  context 'sem sucesso' do
    scenario 'não preencheu todos os campos' do
      admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')

      login_as admin

      visit root_path

      click_on 'Lotes para leilão'
      click_on 'Cadastrar novo lote'

      fill_in 'Código', with: ''
      fill_in 'Data de início', with: ''
      fill_in 'Data limite', with: ''
      fill_in 'Lance mínimo', with: ''
      fill_in 'Diferença de lance', with: ''
      click_on 'Criar Lote'

      expect(page).to have_content 'Código não pode ficar em branco'
      expect(page).to have_content 'Data de início não pode ficar em branco'
      expect(page).to have_content 'Data limite não pode ficar em branco'
      expect(page).to have_content 'Lance mínimo não pode ficar em branco'
      expect(page).to have_content 'Diferença de lance não pode ficar em branco'
    end
    scenario 'data inicio está no passado' do
      admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')

      login_as admin

      visit root_path

      click_on 'Lotes para leilão'
      click_on 'Cadastrar novo lote'

      fill_in 'Código', with: 'BAH295403'
      fill_in 'Data de início', with: Time.zone.yesterday
      fill_in 'Data limite', with: 5.days.from_now
      fill_in 'Lance mínimo', with: '400'
      fill_in 'Diferença de lance', with: '500'
      click_on 'Criar Lote'

      expect(page).to have_content "Data de início deve ser maior ou igual a #{Time.zone.today}"
    end

    scenario 'data limite menor que a data de início' do
      admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')

      login_as admin

      visit root_path

      click_on 'Lotes para leilão'
      click_on 'Cadastrar novo lote'

      fill_in 'Código', with: 'BAH295403'
      fill_in 'Data de início', with: Time.zone.today
      fill_in 'Data limite', with: Time.zone.yesterday
      fill_in 'Lance mínimo', with: '400'
      fill_in 'Diferença de lance', with: '500'
      click_on 'Criar Lote'

      expect(page).to have_content "Data limite deve ser maior ou igual a #{Time.zone.today}"
    end
  end
end
