class Product < ActiveRecord::Base
  attr_accessible :title, :description, :activity, :price, :image_link, :category_ids, :categories

  validates_presence_of :title, :description
  validates_numericality_of :price, :greater_than => 0

  validates_uniqueness_of :title

  has_many :order_items
  has_many :product_categories
  has_many :categories, :through => :product_categories
  has_many :orders, through: :order_items

  default_scope where(:activity => true)

  def self.find_by_title(search_term)
    Product.where("upper(title) like ?", "%#{search_term.upcase}%")
  end

  def self.find_by_category(search_term)
    categories = Category.where("upper(title) like ?", search_term.upcase).all
    results = []
    categories.each do |category|
      results << category.products.all
    end
    results.flatten.uniq
  end

  def status?
    activity
  end
end