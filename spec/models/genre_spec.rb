require 'rails_helper'
RSpec.describe 'Genreモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:genre) { build(:genre) }
    subject { test_genre.valid? }
    context 'nameカラム' do
      let(:test_genre) { genre }
      it '空欄でないこと' do
        test_genre.name = ''
        is_expected.to eq false
      end
    end
    context 'is_activeカラム' do
      let(:test_genre) { genre }
      it '空欄でないこと' do
        test_genre.is_active = ''
        is_expected.to eq false
      end
    end
  end
end
