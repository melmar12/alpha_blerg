require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

	def setup
		@user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
	end

	test 'get new category form and creat categroy' do 
		sign_in_as(@user, "password")
		get new_category_path
		assert_template 'categories/new'
		assert_difference 'Category.count', 1 do
			post_via_redirect categories_path, category: {name: "food"}	
		end
		assert_template 'categories/index'
		assert_match 'food', response.body 
	end


	test 'invalid category submission results in failure' do
		sign_in_as(@user, "password")
		get new_category_path
		assert_template 'categories/new'
		assert_no_difference 'Category.count' do
			post categories_path, category: {name: " "}	
		end
		assert_template 'categories/new'
		#assert_select 'ul.yo'
	end
	
end