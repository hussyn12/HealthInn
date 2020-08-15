class Post < ActiveRecord::Base
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories 
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  belongs_to :moderator
  extend FriendlyId
  is_impressionable
  friendly_id :title, use: :slugged
  has_attached_file :image,
                    
                    style: { large: "600x600>", medium: "300x300>", thumb: "150x150#" },
                    :convert_options => {
                        :thumb    => '-set colorspace sRGB -strip',
                        :large    => '-set colorspace sRGB -strip',
                        :medium   => '-set colorspace sRGB -strip -sharpen 0x0.5'
                    }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :title, presence: true
  validates :content, presence: true
  scope :by_category_ids, lambda {|cid| joins(:categories).where(['categories.id = ?',cid])}
    scope :draft,     ->{ where(status: "Draft") }
  scope :published, ->{ where(status: "Published") }
  scope :scheduled, ->{ where(status: "Scheduled") }
  scope :most_recent, -> { order(id: :desc) }

  before_validation :clean_up_status

  def display_day_published
    " #{created_at.strftime('%-b %-d, %Y')}"
  end

  def clean_up_status
    self.published_at = case status
                        when "Draft"
                          nil
                        when "Published"
                          Time.zone.now
                        else
                          published_at
                        end
    true
  end
  def schedule
          puts "!!!!!!!!!!!!!!!#{self.status}!!!!!!!!!!!!!!!"
          if self.status == "Scheduled"
            begin
                SchedulePost.set(wait_until: published_at).perform_later(self)
            rescue Exception => e
                self.update_attributes(status: "Scheduling-error", error: e.message)
            end
          else
            :published
          end
        end
 

 def self.matching_title_or_content search 
     if search.present?
      @posts = Post.where("title LIKE ? OR content LIKE ?", "%#{search}%", "%#{search}%")
     else
      @posts = Post.all.order(id: :desc)
     end
  end

  def self.by_category cat
    if cat.present?
      @posts = by_category_ids(cat)
    else
     @posts = Post.all
    end
  end 

  def should_generate_new_friendly_id?
   title_changed?
  end  

  def self.variable_for tag
     if tag.present?
      @posts = Post.tagged_with(tag)
     else
      @posts = Post.all
     end
  end
  
    def self.tagged_with(name)
        Tag.find_by_name!(name).posts
    end

def self.tag_counts
  Tag.select("tags.*, count(taggings.tag_id) as count").
    joins(:taggings).group("taggings.tag_id")
end

def tag_list
  tags.map(&:name).join(", ")
end

def tag_rel
  tags.map(&:name).first(2).join(", ")
end  

def tag_list=(names)
  self.tags = names.split(",").map do |n|
    Tag.where(name: n.strip).first_or_create!
  end
end
  def previous_post
    Post.where(["id < ?", id]).last || Post.last
  end

  def next_post
    Post.where(["id > ?", id]).first || Post.first
  end
  

end
