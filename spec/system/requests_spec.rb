require 'rails_helper'

describe '申請のテスト' do
  let(:group) { create(:group) }
  before do
    visit new_group_session_path
    fill_in 'group[email]', with: group.email
    fill_in 'group[password]', with: group.password
    click_button 'Log in'
  end

  describe '出店情報申請のテスト' do
    let(:genre) { create(:genre) }
    let!(:gase) { create(:gase) }
    let!(:item) { create(:item, genre_id: genre.id) }
    context '表示の確認' do
      it '出店情報の申請に成功する' do
        visit new_public_request_path
        fill_in 'field_item_for_sale', with: Faker::Lorem.characters(number: 5)
        choose 'button_date2'
        click_button 'submit_request1'
        expect(page).to have_content '1泊2日'
      end
      it '申請が完了する' do
        visit new_public_request_path
        fill_in 'field_item_for_sale', with: Faker::Lorem.characters(number: 5)
        choose 'button_date2'
        click_button 'submit_request1'
        expect(page).not_to have_content 'すでに申請されています'
        click_on "item_#{item_id}"
        select '1', from: 'item_amount'
        click_on 'item_show_submit'
        click_on 'to_request_gas'
        fill_in 'gas_amount_1', with: 1
        click_on 'submit_gas_request'
        click_on 'to_confirm_page'
        click_on 'fix_request'
        expect(page).to have_content '出店情報、レンタル品の申請を受付けました！'
      end
    end
    context '合計消費電力2001W以上は弾くテスト' do
      it '持ち込み機材合計が2000Wちょうどは通す' do
        visit new_public_request_path
        fill_in 'field_item_for_sale', with: Faker::Lorem.characters(number: 5)
        choose 'button_date2'
        click_button 'submit_request1'
        visit public_items_path
        click_on 'registration_bring_in_equipment'
        fill_in 'bring_in_equipment_name', with: Faker::Lorem.characters(number: 5)
        fill_in 'power_consumption', with: 2000
        select '1', from: 'bring_in_equipment_amount'
        click_on 'submit_bring_in_equipment'
        visit public_cart_items_path
        expect(page).to have_content '次: ガス注文に進む'
      end
      it '持ち込み機材合計が2001W以上で申請できない' do
        visit new_public_request_path
        fill_in 'field_item_for_sale', with: Faker::Lorem.characters(number: 5)
        choose 'button_date2'
        click_button 'submit_request1'
        visit public_items_path
        click_on 'registration_bring_in_equipment'
        fill_in 'bring_in_equipment_name', with: Faker::Lorem.characters(number: 5)
        fill_in 'power_consumption', with: 2001
        select '1', from: 'bring_in_equipment_amount'
        click_on 'submit_bring_in_equipment'
        visit public_cart_items_path
        expect(page).to have_content '消費電力合計を2000 W以下にしてください'
        visit public_gas_requests_path
      end
      it 'レンタル機材合計が2001W以上で申請できない' do
        visit new_public_request_path
        fill_in 'field_item_for_sale', with: Faker::Lorem.characters(number: 5)
        choose 'button_date2'
        click_button 'submit_request1'
        visit public_items_path
        click_on "item_#{item_id}"
        select '10', from: 'item_amount'
        click_on 'item_show_submit'
        expect(page).to have_content '消費電力合計を2000 W以下にしてください'
      end
    end
    context '表示の確認' do
      it '1日のみの出店で延長料金が表示されない' do
        visit new_public_request_path
        fill_in 'field_item_for_sale', with: Faker::Lorem.characters(number: 5)
        choose 'button_date0'
        click_button 'submit_request1'
        # binding.pry
        visit public_items_path
        expect(page).not_to have_content '追加1日'
      end
    end
    context '管理者が確認' do
      let!(:admin) { create(:admin) }
      it '登録情報が確認できる' do
        visit new_public_request_path
        fill_in 'field_item_for_sale', with: Faker::Lorem.characters(number: 5)
        choose "button_date#{Faker::Number.within(range: 0..2)}"
        attach_file 'ad_image', "#{Rails.root}/spec/fixtures/profile.png"
        click_button 'submit_request1'
        click_on 'item_1'
        select '1', from: 'item_amount'
        click_on 'item_show_submit'
        click_on 'to_request_gas'
        fill_in 'gas_amount_1', with: 1
        click_on 'submit_gas_request'
        click_on 'to_confirm_page'
        click_on 'fix_request'
        click_on 'group_log-out'
        visit new_admin_session_path
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        click_button 'Log in'
        visit admin_groups_path
        click_on "group_#{group.id}"
        expect(page).to have_content group.request.item_for_sale
      end
      it '登録情報を修正できる' do
        visit new_public_request_path
        fill_in 'field_item_for_sale', with: Faker::Lorem.characters(number: 5)
        choose "button_date#{Faker::Number.within(range: 0..2)}"
        attach_file 'ad_image', "#{Rails.root}/spec/fixtures/profile.png"
        click_button 'submit_request1'
        click_on 'item_1'
        select '1', from: 'item_amount'
        click_on 'item_show_submit'
        click_on 'to_request_gas'
        fill_in 'gas_amount_1', with: 1
        click_on 'submit_gas_request'
        click_on 'to_confirm_page'
        click_on 'fix_request'
        click_on 'group_log-out'
        visit new_admin_session_path
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        click_button 'Log in'
        visit admin_groups_path
        click_on "group_#{group.id}"
        click_on 'admin_request_edit'
        fill_in 'order_item_amount', with: 3
        click_on 'change_submit'
        expect(page).to have_content '申請内容'
      end
      it '団体を削除できる' do
        visit new_public_request_path
        fill_in 'field_item_for_sale', with: Faker::Lorem.characters(number: 5)
        choose "button_date#{Faker::Number.within(range: 0..2)}"
        attach_file 'ad_image', "#{Rails.root}/spec/fixtures/profile.png"
        click_button 'submit_request1'
        click_on 'item_1'
        select '1', from: 'item_amount'
        click_on 'item_show_submit'
        click_on 'to_request_gas'
        fill_in 'gas_amount_1', with: 1
        click_on 'submit_gas_request'
        click_on 'to_confirm_page'
        click_on 'fix_request'
        click_on 'group_log-out'
        visit new_admin_session_path
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        click_button 'Log in'
        visit admin_groups_path
        expect(page).to have_content group.group_name.to_s
        click_on "destroy_group#{group.id}"
        visit admin_groups_path
        expect(page).not_to have_content group.group_name.to_s
      end
      it '未申請の場合、アラートメッセージが表示される' do
        visit new_admin_session_path
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        click_button 'Log in'
        visit admin_groups_path
        click_on "group_#{group.id}"
        expect(page).to have_content '申請がありません'
      end
    end
  end

  describe '申請内容確認のテスト' do
    let(:genre) { create(:genre) }
    let!(:gase) { create(:gase) }
    let!(:item) { create(:item, genre_id: genre.id) }
    context '自分の申請の確認画面への遷移' do
      it '遷移できる' do
        visit new_public_request_path
        fill_in 'field_item_for_sale', with: Faker::Lorem.characters(number: 5)
        choose 'button_date2'
        click_button 'submit_request1'
        expect(page).not_to have_content 'すでに申請されています'
        click_on 'item_1'
        select '1', from: 'item_amount'
        click_on 'item_show_submit'
        click_on 'to_request_gas'
        fill_in 'gas_amount_1', with: 1
        click_on 'submit_gas_request'
        click_on 'to_confirm_page'
        click_on 'fix_request'
        visit public_request_path(group.request.id)
        request = Request.find_by(group_id: group.id)
        expect(public_request_path(group.request.id)).to eq("/public/requests/#{request.id}")
      end
    end
    context '他人の申請の確認画面への遷移' do
      let!(:group2) { create(:group) }
      let!(:request2) { create(:request, group: group2) }
      it '遷移できない' do
        visit new_public_request_path
        fill_in 'field_item_for_sale', with: Faker::Lorem.characters(number: 5)
        choose 'button_date2'
        click_button 'submit_request1'
        expect(page).not_to have_content 'すでに申請されています'
        click_on 'item_1'
        select '1', from: 'item_amount'
        click_on 'item_show_submit'
        click_on 'to_request_gas'
        fill_in 'gas_amount_1', with: 1
        click_on 'submit_gas_request'
        click_on 'to_confirm_page'
        click_on 'fix_request'
        # binding.pry
        visit public_request_path(group.request.id)
        request = Request.find_by(group_id: group2.id)
        visit public_request_path(request.id)
        expect(page).not_to have_content group2.group_name # 飛んだページにgroup2の情報がなければOK
      end
    end
  end
end

describe '申請のテスト（失敗するパターン）' do
  let(:group) { create(:group) }
  before do
    visit new_group_session_path
    fill_in 'group[email]', with: group.email
    fill_in 'group[password]', with: group.password
    click_button 'Log in'
  end
  describe '申請のテスト' do
    context '販売品目、出店日が入力されていない' do
      it '申請に失敗する' do
        visit new_public_request_path
        click_button 'submit_request1'
        expect(page).to have_content '必要事項を入力してください'
      end
    end
    context '販売品目抜け' do
      it '申請に失敗する' do
        visit new_public_request_path
        # fill_in 'field_item_for_sale', with: Faker::Lorem.characters(number:5)
        choose 'button_date2'
        click_button 'submit_request1'
        expect(page).to have_content '必要事項を入力してください'
      end
    end
    context '出店日抜け' do
      it '申請に失敗する' do
        visit new_public_request_path
        fill_in 'field_item_for_sale', with: Faker::Lorem.characters(number: 5)
        # choose 'button_date', with: Faker::Number.within(range: 0..2)
        click_button 'submit_request1'
        expect(page).to have_content '必要事項を入力してください'
      end
    end
    context '既に申請されている' do
      it '申請に失敗する' do
        visit new_public_request_path
        fill_in 'field_item_for_sale', with: Faker::Lorem.characters(number: 5)
        choose 'button_date2'
        click_button 'submit_request1'
        visit new_public_request_path
        fill_in 'field_item_for_sale', with: Faker::Lorem.characters(number: 5)
        choose 'button_date2'
        click_button 'submit_request1'
        expect(page).to have_content 'すでに申請されています。'
      end
    end
  end
end
