class Product < ActiveRecord::Base
  acts_as_paranoid

  validates :photo_url, url: true

  attr_accessible :name, :description, :categories, :category_ids, :photo_url
  attr_accessible :price_in_cents, :price

  has_many :orders
  has_many :product_categories, :dependent => :destroy
  has_many :categories, :through => :product_categories

  validates_presence_of :name, :description
  validates_uniqueness_of :name
  validates_numericality_of :price_in_cents

  monetize :price_in_cents, :target_name => "price"

  def retired?
    retired
  end

  #default_scope where(retired: false)
  scope :retired, where(:retired => true)

  def self.search_by_name(term)
    self.where("upper(name) like ?", "%#{term.upcase}%")
  end

  def categorize(categories)
    [categories].flatten.each do |category|
      product_categories.create(category_id: category.id)
    end
  end

  def photo_url=(val)
    val = nil if val == ""
    write_attribute(:photo_url, val)
  end
end
