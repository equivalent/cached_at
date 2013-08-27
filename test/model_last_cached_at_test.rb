require 'test_helper'

describe 'ModelLastCachedAt' do
  describe 'last_cached_at' do
    let(:last_cached_at){ User.last_cached_at }
    let(:maximum_cached_at){ User.last_cached_at }
    let(:mocked_time){ 2.minutes.ago }

    context 'when run first time' do
      it 'should set model name based last cached at' do
        last_cached_at.must_equal User.instance_variable_get("@user_last_cached_at")
      end

      it 'should return last cached at value of last updated record' do
        maximum_cached_at = User.maximum(:cached_at)
        last_cached_at.must_be_kind_of Time
        last_cached_at.must_equal maximum_cached_at
      end
    end

    context 'when run second time' do
      before{ User.instance_variable_set "@user_last_cached_at", mocked_time }
      it 'shouldn\'t try to fetch the maximum value with another call' do
        last_cached_at.must_equal mocked_time
      end

      context 'with refresh true argument' do
        it 'should fetch the maximum value with another call' do
          User.last_cached_at(true).wont_equal mocked_time
        end
      end
    end
  end
end
