# frozen_string_literal: true

class Seeds
  attr_reader :data, :packs

  def initialize
    path = Rails.root.join('lib', 'cards', 'full.json')
    @data = JSON.parse File.read(path)
    @packs = data['metadata']
  end

  def import
    import_packs
    import_white_cards
    import_black_cards
  end

  private

  def import_packs
    packs.each do |_key, pack_data|
      # Only import official cards
      next unless pack_data['official']

      Pack.where(name: pack_data['name']).first_or_create!
    end
  end

  def import_white_cards
    data['white'].each do |card|
      break if Rails.env.test? && WhiteCard.count >= 30

      deck      = card['deck']
      pack_name = packs.dig(deck, 'name')

      next unless packs.dig(deck, 'official')

      pack = packs.dig(deck, 'record') || begin
        Pack.find_by(name: pack_name) do |pack|
          packs[deck]['record'] = pack
        end
      end

      next if pack.blank?

      WhiteCard.where(text: card['text']).first_or_create!(pack: pack)
    end
  end

  def import_black_cards
    data['black'].each do |card|
      break if Rails.env.test? && BlackCard.count >= 10

      # Multipick cards aren't supported yet.
      next if card['pick'] > 1

      deck      = card['deck']
      pack_name = packs.dig(deck, 'name')

      next unless packs.dig(deck, 'official')

      pack = packs.dig(deck, 'record') || begin
        Pack.find_by(name: pack_name) do |pack|
          packs[deck]['record'] = pack
        end
      end

      next if pack.blank?

      BlackCard.where(text: card['text']).first_or_create!(pack: pack)
    end
  end
end

Seeds.new.import
