require "test_helper"

class CartTest < Minitest::Test 
	def test_adds_one_items
		cart = Cart.new
		cart.add_item 1

		assert_equal cart.empty?, false
	end

	def test_adds_up_in_quanity
		cart = Cart.new
		3.times { cart.add_item 1 }

		assert_equal cart.items.length, 1		
		assert_equal cart.items.first.quantity, 3		
	end

	def test_retrieves_products
		product = Product.create name:"Tomato", price: 1

		cart = Cart.new
		cart.add_item product.id

		assert_kind_of Product, cart.items.first.product		
	end

	def test_serializes_to_hash
		cart = Cart.new
		cart.add_item 1

		assert_equal cart.serialize, session_hash
	end

	def test_builds_from_hash
		cart = Cart.build_from_hash session_hash
		assert_equal 1, cart.items.first.product_id
	end

	private

	def session_hash
		{
			"cart" => {
				"items" => [
					{ "product_id" => 1, "quantity" => 1 }
				]
			}
		}
	end
end