require 'rails_helper'

RSpec.describe Labeling, type: :model do
# #6
  it { is_expected.to belong_to :labelable }
end
