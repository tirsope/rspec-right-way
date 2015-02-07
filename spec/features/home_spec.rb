require "rails_helper"
describe "Home Page" do
	describe "GET /" do

		context "empty database" do
			before(:each) do
				visit '/'
			end

			it "render success" do
				expect(page.status_code).to be(200)
			end

			it "populates title" do
				expect(page).to have_title "Comments Dashboard"
			end

			describe "masthead" do

				it "displays the title" do
					expect(page).to have_selector 'h1', text: 'Comments Dashboard'
				end

				it "displays the subtitle" do
					expect(page).to have_selector 'h2', text: 'Read comments from your favorite blogs'
				end
			end

		end
	end

	context "popultaed database" do

		fixtures :blogs 

		before(:each) do
			visit '/'
		end

		it "show a list of blogs" do
			expect(page).to have_selector('li a'), text:'Mashable'
		end
	end
end