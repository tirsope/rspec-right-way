require_relative '../../../../lib/wordpress/comments/client'
require_relative '../../../support/match_date.rb'

describe Wordpress::Comments::Client do	

	let(:client) { Wordpress::Comments::Client.new 'http://www.lavinotinto.com/feed/' }
	let(:xml) { File.read(File.join('spec', 'fixtures', 'feed.xml')) }

	describe "#initialize" do
		
		it "stores a URL" do
			expect(client.url).to eq 'http://www.lavinotinto.com/feed/'
		end

	end

	describe "#parse" do

		let(:comments) { client.parse xml }
		let(:comment) { comments.first }

		it "extracts the link" do
			link = 'http://www.lavinotinto.com/san-juan-esta-preparada-para-albergar-la-serie-del-caribe-2015/'
			expect(comment[:link]).to eq link
		end

		it  "extracts the title" do
			title = "San Juan está preparada para albergar la Serie del Caribe 2015"
			expect(comment[:title]).to eq title
		end

		it  "extracts the name of the commenter" do
			expect(comment[:commenter]).to eq 'Gress Mejías'
		end

		it  "extracts the publication date" do
			#Tue, 27 Jan 2015 15:06:58 +0000
			expect(comment[:date].year).to eq 2015
		end

		it  "extracts the publication date (redux)" do
			#Tue, 27 Jan 2015 15:06:58 +0000
			expect(comment[:date]).to match_date '2015-01-27'
		end

	end

	describe "#fetch" do
		let(:comments) { client.fetch }

		context "success" do

			before(:each) do
				allow(client).to receive(:get).and_return(xml)
			end

			it "build comments object" do
				expect(comments.length).to eq 10
			end

		end

		context "bad URL" do

			let(:client) { Wordpress::Comments::Client.new 'not a URL' }

			it "raises error" do
				expect {
					client.fetch
				}.to raise_error(Errno::ENOENT)
			end

		end

		context "bad XML" do

			before(:each) do
				allow(client).to receive(:get).and_return("BAD XML!")
			end

			it "raise error from Nokogiri" do
				expect {
					client.fetch
				}.to raise_error(Nokogiri::XML::SyntaxError)
			end

		end
	end
	
end