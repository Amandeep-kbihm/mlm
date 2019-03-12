class OfferSerializer < ActiveModel::Serializer
  attributes :id, :link, :logo, :name, :instructions, :amount

  def logo
    object.logo.url
  end
end
