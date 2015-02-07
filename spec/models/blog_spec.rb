require 'rails_helper'
require_relative '../support/network'

describe Blog do

	let (:blog) { Blog.new(title:"My Blog", comments_feed_url: "http://example.com/comments/feed") }

  describe "attributes" do

  	it { expect(blog).to validate_presence_of   :title }
  	it { expect(blog).to validate_uniqueness_of :title }

  	it { expect(blog).to validate_presence_of   :comments_feed_url }
  	it { expect(blog).to validate_uniqueness_of :comments_feed_url }

  	it { expect(blog).to have_many :comments }

	  it "saves attributes" do
	    blog.save!
	    expect(blog).to be_valid
	  end
	end

	describe "permalink" do

		it "builds from title" do
			blog.build_permalink
			expect(blog.permalink).to eq 'my-blog'
		end

	end

	describe "refresh comments" do

	  it "populates comments" do
	  	stub_network
	  	blog.save!
	  	blog.comments.refresh
	  	expect(blog.comments.length).to eq 10
	  end

	end

end
