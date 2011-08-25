require 'spec_helper'

describe ShoppingCartItem do
	it { should belong_to :user }
	it { should have_many :materials }
end
