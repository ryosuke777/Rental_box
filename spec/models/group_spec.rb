require 'rails_helper'
RSpec.describe 'Groupモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:group) { build(:group) }
    subject { test_group.valid? }
    context 'group_nameカラム' do
      let(:test_group) { group }
      it '空欄でないこと' do
        test_group.group_name = ''
        is_expected.to eq false
      end
      it '2文字以上であること' do
        test_group.group_name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '20文字以下であること' do
        test_group.group_name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
    context 'group_name_kanaカラム' do
      let(:test_group) { group }
      it '空欄でないこと' do
        test_group.group_name_kana = ''
        is_expected.to eq false
      end
    end
    context 'emailカラム' do
      let(:test_group) { group }
      it '空欄でないこと' do
        test_group.email = ''
        is_expected.to eq false
      end
    end

    context 'representative_nameカラム' do
      let(:test_group) { group }
      it '空欄でないこと' do
        test_group.representative_name = ''
        is_expected.to eq false
      end
    end
    context 'representative_name_kanaカラム' do
      let(:test_group) { group }
      it '空欄でないこと' do
        test_group.representative_name_kana = ''
        is_expected.to eq false
      end
    end
    context 'representative_telephone_numberカラム' do
      let(:test_group) { group }
      it '空欄でないこと' do
        test_group.representative_telephone_number = ''
        is_expected.to eq false
      end
    end
    context 'subdelegate_nameカラム' do
      let(:test_group) { group }
      it '空欄でないこと' do
        test_group.subdelegate_name = ''
        is_expected.to eq false
      end
    end
    context 'subdelegate_name_kanaカラム' do
      let(:test_group) { group }
      it '空欄でないこと' do
        test_group.subdelegate_name_kana = ''
        is_expected.to eq false
      end
    end
    context 'subdelegate_telephone_numberカラム' do
      let(:test_group) { group }
      it '空欄でないこと' do
        test_group.subdelegate_telephone_number = ''
        is_expected.to eq false
      end
    end
    context 'subdelegate_emailカラム' do
      let(:test_group) { group }
      it '空欄でないこと' do
        test_group.subdelegate_email = ''
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Requestモデルとの関係' do
      it '1:1となっている' do
        expect(Group.reflect_on_association(:request).macro).to eq :has_one
      end
    end
  end
end
# アソシエーションのテスト
