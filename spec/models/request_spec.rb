require 'rails_helper'

RSpec.describe 'Requestモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:group) { create(:group) }
    let!(:request) { build(:request, group_id: group.id) }

    context 'dateカラム' do
      it '空欄でないこと' do
        request.date = ''
        expect(request.valid?).to eq false;
      end
    end
    context 'item_for_saleカラム' do
      it '空欄でないこと' do
        request.item_for_sale = ''
        expect(request.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Groupモデルとの関係' do
      it 'N:1となっている' do
        expect(Request.reflect_on_association(:group).macro).to eq :belongs_to
      end
    end
  end
end