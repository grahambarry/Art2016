class Pin < ActiveRecord::Base

  acts_as_votable
	belongs_to :use
  has_many :microposts
  has_many :reviews

# This is where you set what imagemagick will resize your variants to
	has_attached_file :image, :styles => { :large => "960x960>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :image, :attachment_presence => true
  #validates :image, dimensions: { width: 700, height: 500 }
  after_create :get_the_aspect
  after_create :pin_titler
  after_post_process :save_latlong


  



def self.search(search)
query = "%#{search}%"
  if search
Pin.where("title like ? or description like ?", query, query,)

  else
Pin.all
  end
end



  def get_the_aspect()
      dimensions = Paperclip::Geometry.from_file(image.queued_for_write[:original].path)

      if
      dimensions.width / dimensions.height >= 0.85 && dimensions.width / dimensions.height <= 1.25

        self.update_column(:aspect, 3)

elsif
        dimensions.vertical?

        self.update_column(:aspect, 2)

      else
                dimensions.horizontal?

        self.update_column(:aspect, 1)


      end
    end
  end
  def pin_titler
      

        self.update_column(:title, "- EDIT NAME -")


  end

  private

def save_latlong
  exif_data = MiniExiftool.new(image.queued_for_write[:original].path)
  self.latitude = parse_latlong(exif_data['gpslatitude'])
  self.longitude = parse_latlong(exif_data['gpslongitude'])
end

def parse_latlong(latlong)
  return unless latlong
  match, degrees, minutes, seconds, rotation = /(\d+) deg (\d+)' (.*)" (\w)/.match(latlong).to_a
  calculate_latlong(degrees, minutes, seconds, rotation)
end

def calculate_latlong(degrees, minutes, seconds, rotation)
  calculated_latlong = degrees.to_f + minutes.to_f/60 + seconds.to_f/3600
  ['S', 'W'].include?(rotation) ? -calculated_latlong : calculated_latlong
end









