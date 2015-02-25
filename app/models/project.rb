class Project < ActiveRecord::Base
  belongs_to :user
  has_many :images, class_name: 'ProjectImage', dependent: :destroy
  validates :user, :content, :title, presence: true
  validates :slug, uniqueness: { scope: :user_id }
  before_validation :generate_slug
  accepts_nested_attributes_for :images, allow_destroy: true

  def to_liquid
    attributes.deep_stringify_keys
  end

  private

  def generate_slug
    self.slug ||= title.parameterize if title.present?
  end
end
