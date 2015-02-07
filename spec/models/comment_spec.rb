require 'rails_helper'

describe Comment do

  let(:comment) {  Comment.new() }

  it { expect(comment).to validate_uniqueness_of :link }

end
