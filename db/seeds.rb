# frozen_string_literal: true

path = Rails.root.join('lib', 'cards', 'full.json')
data = JSON.parse File.read(path)

# Import packs
packs = data['metadata']
packs.each do |key, pack_data|
  # Only import official cards
  next unless pack_data['official']

  Pack.where(name: pack_data['name']).first_or_create!
end

# Import white cards
data['white'].each do |card|
  pack_name = packs.dig(card['deck'], 'name')
  pack = Pack.find_by(name: pack_name)
  next if pack.blank?

  WhiteCard.where(text: card['text']).first_or_create!(pack: pack)
end

# Import black cards
data['black'].each do |card|
  # Multipick cards aren't supported yet.
  next if card['pick'] > 1

  pack_name = packs.dig(card['deck'], 'name')
  pack = Pack.find_by(name: pack_name)
  next if pack.blank?

  BlackCard.where(text: card['text']).first_or_create!(pack: pack)
end
