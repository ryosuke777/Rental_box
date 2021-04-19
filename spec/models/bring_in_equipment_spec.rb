require 'rails_helper'
RSpec.describe 'bring_in_equipmentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:bring_in_equipment) { build(:bring_in_equipment) }
    subject { test_bring_in_equipment.valid? }
    context 'nameカラム' do
      let(:test_bring_in_equipment) { bring_in_equipment }
      it '空欄でないこと' do
        test_bring_in_equipment.name = ''
        is_expected.to eq false
      end
    end
    context 'power_consumptionカラム' do
      let(:test_bring_in_equipment) { bring_in_equipment }
      it '空欄でないこと' do
        test_bring_in_equipment.power_consumption = ''
        is_expected.to eq false
      end
    end
    context 'amountカラム' do
      let(:test_bring_in_equipment) { bring_in_equipment }
      it '空欄でないこと' do
        test_bring_in_equipment.amount = ''
        is_expected.to eq false
      end
    end
  end
end
