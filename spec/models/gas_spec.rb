require 'rails_helper'
RSpec.describe 'Gaseモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:gase) { build(:gase) }
    subject { test_gase.valid? }
    context 'nameカラム' do
      let(:test_gase) { gase }
      it '空欄でないこと' do
        test_gase.name = ''
        is_expected.to eq false
      end
    end
    context 'priceカラム' do
      let(:test_gase) { gase }
      it '空欄でないこと' do
        test_gase.price = ''
        is_expected.to eq false
      end
    end
    context 'amountカラム' do
      let(:test_gase) { gase }
      it '空欄でないこと' do
        test_gase.amount = ''
        is_expected.to eq false
      end
    end
    context 'is_activeカラム' do
      let(:test_gase) { gase }
      it '空欄でないこと' do
        test_gase.is_active = ''
        is_expected.to eq false
      end
    end
  end
end
