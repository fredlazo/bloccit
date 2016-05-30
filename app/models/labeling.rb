class Labeling < ActiveRecord::Base
# #7
  belongs_to :labelable, polymorphic: true
  belongs_to :label
end
