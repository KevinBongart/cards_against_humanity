# frozen_string_literal: true

[BlackCard, WhiteCard].each do |card_class|
  path = Rails.root.join('lib', 'cards', 'base_pack', "#{card_class.color}.txt")
  data = File.read(path)

  data.each_line(chomp: true) do |line|
    # Cards with more than one '_' aren't supported yet.
    next if line.chars.select { |c| c == '_' }.many?

    card_class.where(text: line).first_or_create!
  end
end
