require 'rails_helper'

describe 'レンタル品表示のテスト' do
  let(:genre) { create(:genre) }
  # let!(:item) { create(:item, genre_id:genre.id) }
  let!(:admin) { create(:admin) }
  # let!(:group) { create(:group)}
  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'Log in'
  end
  context '動画のリンク' do
    let!(:genre2) { create(:genre) }
    it '表示される' do
      visit new_admin_item_path
      fill_in 'item_name', with: Faker::Lorem.characters(number: 5)
      fill_in 'item_introduction', with: Faker::Lorem.characters(number: 100)
      fill_in 'video_url', with: Faker::Internet.url
      fill_in 'manual_url', with: Faker::Internet.url
      find("option[value='#{genre2.id}']").select_option
      fill_in 'item_price', with: Faker::Number.within(range: 6000..10_000)
      fill_in 'item_add_price', with: Faker::Number.within(range: 600..2000)
      fill_in 'power_consumption', with: Faker::Number.within(range: 600..1200)
      fill_in 'fuel_economy', with: Faker::Number.within(range: 0.1..1.5).round(2)
      click_on 'item_submit'
      expect(page).to have_content '動画'
      visit public_items_path
      expect(page).to have_content '動画'
    end
    it '表示されない' do
      visit new_admin_item_path
      fill_in 'item_name', with: Faker::Lorem.characters(number: 5)
      fill_in 'item_introduction', with: Faker::Lorem.characters(number: 100)
      check 'video'
      fill_in 'manual_url', with: Faker::Internet.url
      find("option[value='#{genre2.id}']").select_option
      fill_in 'item_price', with: Faker::Number.within(range: 6000..10_000)
      fill_in 'item_add_price', with: Faker::Number.within(range: 600..2000)
      fill_in 'power_consumption', with: Faker::Number.within(range: 600..1200)
      fill_in 'fuel_economy', with: Faker::Number.within(range: 0.1..1.5).round(2)
      click_on 'item_submit'
      expect(page).not_to have_content '動画'
      visit public_items_path
      expect(page).not_to have_content '動画'
    end
  end
  context '説明書のリンク' do
    let!(:genre2) { create(:genre) }
    it '表示される' do
      visit new_admin_item_path
      fill_in 'item_name', with: Faker::Lorem.characters(number: 5)
      fill_in 'item_introduction', with: Faker::Lorem.characters(number: 100)
      fill_in 'video_url', with: Faker::Internet.url
      fill_in 'manual_url', with: Faker::Internet.url
      find("option[value='#{genre2.id}']").select_option
      fill_in 'item_price', with: Faker::Number.within(range: 6000..10_000)
      fill_in 'item_add_price', with: Faker::Number.within(range: 600..2000)
      fill_in 'power_consumption', with: Faker::Number.within(range: 600..1200)
      fill_in 'fuel_economy', with: Faker::Number.within(range: 0.1..1.5).round(2)
      click_on 'item_submit'
      expect(page).to have_content '説明書'
      visit public_items_path
      expect(page).to have_content '説明書'
    end
    it '表示されない' do
      visit new_admin_item_path
      fill_in 'item_name', with: Faker::Lorem.characters(number: 5)
      fill_in 'item_introduction', with: Faker::Lorem.characters(number: 100)
      fill_in 'video_url', with: Faker::Internet.url
      check 'manual'
      find("option[value='#{genre2.id}']").select_option
      fill_in 'item_price', with: Faker::Number.within(range: 6000..10_000)
      fill_in 'item_add_price', with: Faker::Number.within(range: 600..2000)
      fill_in 'power_consumption', with: Faker::Number.within(range: 600..1200)
      fill_in 'fuel_economy', with: Faker::Number.within(range: 0.1..1.5).round(2)
      click_on 'item_submit'
      expect(page).not_to have_content '説明書'
      visit public_items_path
      expect(page).not_to have_content '説明書'
    end
  end
  context '編集のテスト' do
    let!(:genre2) { create(:genre) }
    let!(:genre3) { create(:genre) }
    it '編集ページへのリンクが表示される' do
      visit new_admin_item_path
      fill_in 'item_name', with: Faker::Lorem.characters(number: 5)
      fill_in 'item_introduction', with: Faker::Lorem.characters(number: 100)
      fill_in 'video_url', with: Faker::Internet.url
      fill_in 'manual_url', with: Faker::Internet.url
      find("option[value='#{genre2.id}']").select_option
      fill_in 'item_price', with: Faker::Number.within(range: 6000..10_000)
      fill_in 'item_add_price', with: Faker::Number.within(range: 600..2000)
      fill_in 'power_consumption', with: Faker::Number.within(range: 600..1200)
      fill_in 'fuel_economy', with: Faker::Number.within(range: 0.1..1.5).round(2)
      click_on 'item_submit'
      expect(page).to have_content 'レンタル品詳細'
    end
    it 'レンタル品編集ページが表示される' do
      visit new_admin_item_path
      fill_in 'item_name', with: Faker::Lorem.characters(number: 5)
      fill_in 'item_introduction', with: Faker::Lorem.characters(number: 100)
      fill_in 'video_url', with: Faker::Internet.url
      fill_in 'manual_url', with: Faker::Internet.url
      find("option[value='#{genre2.id}']").select_option
      fill_in 'item_price', with: Faker::Number.within(range: 6000..10_000)
      fill_in 'item_add_price', with: Faker::Number.within(range: 600..2000)
      fill_in 'power_consumption', with: Faker::Number.within(range: 600..1200)
      fill_in 'fuel_economy', with: Faker::Number.within(range: 0.1..1.5).round(2)
      click_on 'item_submit'
      click_on 'item_edit'
      expect(page).to have_content 'レンタル品編集'
    end
    it '編集内容が反映される' do
      visit new_admin_item_path
      fill_in 'item_name', with: 'item_name_before'
      fill_in 'item_introduction', with: 'introduction_before'
      fill_in 'video_url', with: 'video_url_before'
      fill_in 'manual_url', with: 'manual_url_before'
      find("option[value='#{genre2.id}']").select_option
      fill_in 'item_price', with: 1000
      fill_in 'item_add_price', with: 500
      fill_in 'power_consumption', with: 1000
      fill_in 'fuel_economy', with: 0.5
      click_on 'item_submit'
      click_on 'item_edit'
      expect(page).to have_content 'レンタル品編集'
      fill_in 'item_name', with: 'item_name_after'
      fill_in 'item_introduction', with: 'introduction_after'
      fill_in 'video_url', with: 'video_url_after'
      fill_in 'manual_url', with: 'manual_url_after'
      find("option[value='#{genre3.id}']").select_option
      fill_in 'item_price', with: 2000
      fill_in 'item_add_price', with: 800
      fill_in 'power_consumption', with: 3000
      uncheck 'fuel_economy_0'
      fill_in 'fuel_economy', with: 0.9
      click_on 'item_update'
      expect(page).to have_content 'item_name_after'
      expect(page).to have_content 'introduction_after'
      expect(page).to have_content genre3.name.to_s
      expect(page).to have_content (2000).to_i.to_s
      expect(page).to have_content (800).to_i.to_s
      expect(page).to have_content '3000'
      expect(page).to have_content '0.9'
      click_on 'item_edit'
      check 'video'
      check 'manual'
      click_on 'item_update'
      expect(page).not_to have_content '動画'
      expect(page).not_to have_content '説明書'
    end
    it '登録したレンタル品を削除できる' do
      visit new_admin_item_path
      fill_in 'item_name', with: 'item_name_destroy_before'
      fill_in 'item_introduction', with: 'introduction_before'
      fill_in 'video_url', with: 'video_url_before'
      fill_in 'manual_url', with: 'manual_url_before'
      find("option[value='#{genre2.id}']").select_option
      fill_in 'item_price', with: 1000
      fill_in 'item_add_price', with: 500
      fill_in 'power_consumption', with: 1000
      fill_in 'fuel_economy', with: 0.5
      click_on 'item_submit'
      click_on 'item_edit'
      click_on 'item_destroy'
      visit admin_items_path
      expect(page).not_to have_content 'item_name_destroy_before'
    end
  end
end
