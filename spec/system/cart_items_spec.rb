require 'rails_helper'

describe 'cart_itemのテスト' do
  let(:group) { create(:group) }
  let!(:genre) { create(:genre) }
  let!(:genre2) { create(:genre) }
  let!(:gase) { create(:gase) }
  let!(:item) { create(:item, genre_id: genre.id) }
  before do
    visit new_group_session_path
    fill_in 'group[email]', with: group.email
    fill_in 'group[password]', with: group.password
    click_button 'Log in'
  end
  context '登録完了後のcart_itemとgas_requestについて' do
    it '削除されている' do
      visit new_public_request_path
      fill_in 'field_item_for_sale', with: Faker::Lorem.characters(number: 5)
      choose 'button_date2'
      click_button 'submit_request1'
      expect(page).not_to have_content 'すでに申請されています'
      click_on "item_#{item.id}"
      select '1', from: 'item_amount'
      click_on 'item_show_submit'
      # binding.pry
      click_on 'to_request_gas'
      fill_in "gas_amount_#{gase.id}", with: 1
      click_on 'submit_gas_request'
      click_on 'to_confirm_page'
      click_on 'fix_request'
      expect(page).to have_content '出店情報、レンタル品の申請を受付けました！'
      click_on 'group_cart_item'
      expect(CartItem.all).to eq([])
      expect(GasRequest.all).to eq([])
    end
  end
end
