# frozen_string_literal: true

module CardsHelper
  def formatted_card(card)
    text = card.text.gsub('\n', '<br>')
    text = text.split('_').join('<span class="blank">_</span>')

    simple_format text
  end

  def spread_hand_style(card, index, card_count)
    center = 25
    margin = center - (card_count - index) * center / card_count + center / 2

    max_angle = 30
    min_angle = -45

    # Add or remove 3 degrees to the angle
    max_random = 6
    random_int = (card.id.digits.first + index) % (max_random + 1)
    randomized = random_int - max_random / 2

    angle = min_angle + index * (max_angle * 2 / card_count) + randomized

    styles = {
      'margin-left' => "#{margin}%",
      'transform' => "rotate(#{angle}deg)"
    }

    styles.map { |k, v| "#{k}: #{v}" }.join(';')
  end

  def expanded_hand_style(card)
    # Move the card up to 5 pixels left or right
    max_random_y = 10
    random_int = card.id % (max_random_y + 1)
    randomized_y = random_int - (max_random_y / 2.0)

    # Add or remove 1 degree to the angle
    max_random_angle = 2
    random_int = card.id % (max_random_angle + 1)
    randomized_angle = random_int - max_random_angle / 2.0

    styles = {
      'left' => "#{randomized_y}px",
      'transform' => "rotate(#{randomized_angle}deg)"
    }

    styles.map { |k, v| "#{k}: #{v}" }.join(';')
  end

  def horizontal_hand_style(index)
    offset = 1
    margin = index * offset

    styles = {
      'margin-left' => "#{margin}em"
    }

    styles.map { |k, v| "#{k}: #{v}" }.join(';')
  end
end
