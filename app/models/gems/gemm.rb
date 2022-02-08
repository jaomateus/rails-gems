class Gemm < ApplicationRecord
  self.table_name = "gems"

  after_create :add_tags

  include ::Typeable
  include ::Slugable

  store_attribute :details, :homepage_uri, :string
  store_attribute :details, :project_uri, :string
  store_attribute :details, :funding_uri, :string
  store_attribute :details, :wiki_uri, :string
  store_attribute :details, :source_code_uri, :string
  store_attribute :details, :documentation_uri, :string
  store_attribute :details, :bug_tracker_uri, :string
  store_attribute :details, :mailing_list_uri, :string

  attribute :liked, :boolean

  has_many :likes, dependent: :destroy, foreign_key: "gem_id"
  has_many :users, through: :likes, dependent: :destroy

  has_many :taggings, dependent: :destroy, foreign_key: "gem_id"
  has_many :tags, through: :taggings

  scope :for_slug, ->(slug) { where(slug: slug) }
  scope :for_user, ->(user) { joins(:likes).where(likes: { user_id: user.id }) if user.present? }
  scope :for_tag, ->(tag) { joins(:taggings).where(taggings: { tag_id: tag.id }) if tag.present? }
  scope :for_search, ->(query) { where("name ILIKE CONCAT('%', ?, '%') OR title ILIKE CONCAT('%', ?, '%')", sanitize_sql_like(query), sanitize_sql_like(query)) if query.present? }

  scope :with_tags, ->(include) { includes(:tags) if include.present? && include.to_bool }
  scope :with_taggings, ->(include) { includes(:taggings) if include.present? && include.to_bool }

  def type_name
    "Gem"
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
  end
  
  def tag_list
    tags.map(&:name).join(", ")
  end
  
  def tag_list=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip.downcase).first_or_create!
    end
  end

  def hash_tags(separator=' ')
    tags.map{|tag| "##{tag.name.strip.downcase}"}.join(separator)
  end

  def self.import(data)
    gem = Gemm.find_or_initialize_by(slug: data["name"].parameterize)
    gem.name = data["name"]
    gem.title = data["info"]
    gem.description = data["description"]
    gem.version = data["version"]
    gem.platform = data["platform"]
    gem.downloads_count = data["downloads"].to_i
    gem.authors = data["authors"].split(", ")
    gem.licenses = data["licenses"]
    gem.homepage_uri = data["homepage_uri"]
    gem.project_uri = data["project_uri"]
    gem.funding_uri = data["funding_uri"]
    gem.wiki_uri = data["wiki_uri"]
    gem.source_code_uri = data["source_code_uri"]
    gem.documentation_uri = data["documentation_uri"]
    gem.bug_tracker_uri = data["bug_tracker_uri"]
    gem.mailing_list_uri = data["mailing_list_uri"]
    gem.save
    gem
  end

  def add_tags
    Tag.all_cached.each do |tag|
      if self.title.downcase.split.include?(tag.name) && self.tags.exists?(tag.id) == false
        self.taggings.create(tag: tag)
      end  
    end
  end

end