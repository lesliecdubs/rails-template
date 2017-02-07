# frozen_string_literal: true
RSpec.shared_examples :publishable do
  context 'scope' do
    before do
      @published_items   = create_list( model_name, 3, published_at: Time.zone.now)
      @unpublished_items = create_list( model_name, 3)
    end

    describe '.published' do
      it 'should return an active record array of published items' do
        expect(described_class.published).to match_array(@published_items)
      end
    end

    describe '.unpublished' do
      it 'should return an active record array of unpublished items' do
        expect(described_class.unpublished).to match_array(@unpublished_items)
      end
    end
  end

  describe '#publish' do
    it 'should set the published_at column to the current time' do
      model = create model_name

      Timecop.freeze do
        current_time = Time.zone.now
        model.publish
        expect(model.published_at.to_i).to eq current_time.to_i
      end
    end
  end

  describe '#unpublish' do
    it 'should set the published_at column to nil' do
      model = create model_name, published_at: Time.zone.now
      model.unpublish

      expect(model.published_at).to be_nil
    end
  end
end
