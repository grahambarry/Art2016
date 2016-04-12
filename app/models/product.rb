class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true,
            numericality: true,
            format: { :with => /\A\d{1,4}(\.\d{0,2})?\z/ }
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end