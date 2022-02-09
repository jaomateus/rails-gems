# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  type                   :string           default("User")
#  slug                   :string
#  name                   :string
#  title                  :string
#  description            :text
#  image_data             :jsonb
#  details                :jsonb            default("{}")
#  likes_count            :integer          default("0")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_type        :string
#  invited_by_id          :integer
#  invitations_count      :integer          default("0")
#  identities_count       :integer          default("0")
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invited_by            (invited_by_type,invited_by_id)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_name                  (name)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug)
#  index_users_on_type                  (type)
#

class User < ApplicationRecord

  include ::Typeable
  include ::Slugable
  include ::Imageable
  include ImageUploader::Attachment(:image)

  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :omniauthable, :registerable, :recoverable, :rememberable, :validatable

  store_attribute :details, :homepage_uri, :string
  store_attribute :details, :github_uri, :string
  store_attribute :details, :twitter_uri, :string
  store_attribute :details, :gem_names, :json, default: []

  has_many :identities, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :gems, class_name: "Gemm", foreign_key: "gem_id", through: :likes, dependent: :destroy

  scope :for_gem, ->(gem) { joins(:likes).where(likes: { gem_id: gem.id }) if gem.present? }
  scope :for_search, ->(query) { where(email: query).or(where("name ILIKE CONCAT('%', ?, '%')", sanitize_sql_like(query))).or(where(username: query.downcase)) if query.present? }

  def self.from_omniauth(auth)
    if auth.present? && auth.provider.present? && auth.uid.present?
      identity = Identity.where(provider: auth.provider, uid: auth.uid).first_or_initialize
      if auth.credentials.present?
        identity.token = auth.credentials.token
        identity.refresh_token = auth.credentials.refresh_token
      end
      if identity.user.nil?
        password = Devise.friendly_token
        identity.user = User.create!(
          name: auth.info.name,
          email: auth.info.email,
          password: password,
          password_confirmation: password)
      end
      identity.save!
      identity.user
    end
  end

end
