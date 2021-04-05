require 'rails_helper'
RSpec.describe 'Itemモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:item) { build(:item) }
    subject { test_item.valid? }
    context 'nameカラム' do
      let(:test_item) { item }
      it '空欄でないこと' do
        test_item.name = ''
        is_expected.to eq false;
      end
    end
    context 'priceカラム' do
      let(:test_item) { item }
      it '空欄でないこと' do
        test_item.price = ''
        is_expected.to eq false;
      end
    end
    context 'add_priceカラム' do
      let(:test_item) { item }
      it '空欄でないこと' do
        test_item.add_price = ''
        is_expected.to eq false;
      end
    end
    context 'introductionカラム' do
      let(:test_item) { item }
      it '空欄でないこと' do
        test_item.introduction = ''
        is_expected.to eq false;
      end
    end
  end
end