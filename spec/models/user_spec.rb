# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  subject { build :user }

  it_behaves_like "model with uuid"

  context "factory" do
    it_behaves_like "valid factory"
  end

  context "associations" do
    it { is_expected.to have_many(:issues) }
  end

  context "validation" do
    before do
      skip "Validation handled by Github - this app is just storing a local copy of the data"
    end

    it { is_expected.to validate_presence_of(:login) }

    it { is_expected.to validate_inclusion_of(:type).in_array(described_class::EXPECTED_TYPES) }

    %i[url avatar_url].each do |url_col|
      # Could be moved to shared example for use with other URL columns
      context "#{url_col}" do
        it { is_expected.to allow_value("http://www.example.com").for(url_col) }
        it { is_expected.to allow_value("https://subdomain.exmaple.co.uk/path?query=1#link").for(url_col) }
        it { is_expected.to allow_value(nil).for(url_col) }
        it { is_expected.to allow_value("").for(url_col) }

        it { is_expected.not_to allow_value("invalid-url").for(url_col).with_message("must be a valid URL") }
        it { is_expected.not_to allow_value("ftp://example.com").for(url_col).with_message("must be a valid URL") }
        it { is_expected.not_to allow_value("www.example.com").for(url_col).with_message("must be a valid URL") }
      end
    end
  end
end
