# frozen_string_literal: true

RSpec.describe Tamashii::Config do
  it 'has a version number' do
    expect(Tamashii::Config::VERSION).not_to be nil
  end
end
