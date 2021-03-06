# frozen_string_literal: true

##
# A user account
#
class User < ApplicationRecord
  devise :database_authenticatable, :confirmable, :recoverable, :trackable, :validatable, :omniauthable
  include JWT::Auth::Authenticatable

  ##
  # Properties
  #
  attribute :name
  attribute :email
  attribute :locale
  attribute :token_version
  attribute :tos_accepted
  attribute :alert_emails

  ##
  # Associations
  #
  has_many :identities,
           :dependent => :destroy

  has_many :topics,
           :dependent => :destroy,
           :inverse_of => :user

  has_many :grants,
           :dependent => :destroy

  has_many :collaborations,
           :class_name => 'Topic',
           :through => :grants,
           :source => :topic,
           :inverse_of => :collaborators

  has_many :feed_items,
           :dependent => :destroy,
           :inverse_of => :user

  has_many :alerts,
           :dependent => :destroy,
           :inverse_of => :user

  ##
  # Validations
  #
  validates :name,
            :presence => true

  validates :email,
            :presence => true,
            :format => { :with => /\A[^@]+@[^@]+\z/ },
            :uniqueness => true

  validates :locale,
            :presence => true,
            :inclusion => { :in => proc { I18n.available_locales.map(&:to_s) } }

  validates :token_version,
            :presence => true,
            :numericality => { :only_integer => true }

  validates :tos_accepted,
            :presence => true

  validate :readonly_email,
           :on => :update

  validate :accepted_terms

  ##
  # Callbacks
  #
  after_initialize :set_default_locale

  ##
  # Methods
  #
  def self.find_by_token(params)
    confirmed.find_by params
  end

  ##
  # Overrides
  #
  def password=(new_password)
    increment :token_version
    super new_password
  end

  ##
  # Helpers and callback methods
  #
  scope :confirmed, -> { where.not(:confirmed_at => nil) }

  def readonly_email
    errors.add :email, I18n.t('openwebslides.validations.user.readonly_email') if email_changed?
  end

  def accepted_terms
    return if tos_accepted?

    errors.add :tos_accepted, I18n.t('openwebslides.validations.user.accepted_terms')
  end

  private

  def set_default_locale
    self.locale = 'en' if locale.blank?
  end
end
