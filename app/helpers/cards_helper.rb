module CardsHelper
  def formatted_card(card)
    text = card.text.gsub('\n', '<br>')
    text = text.split('_').join('<span class="blank">_</span>')

    simple_format text
  end

  def style(index, card_count)
    center = 25
    margin = center - (card_count - index) * center/card_count + center/2

    max_angle = 30
    min_angle = -45
    angle = min_angle + index * (max_angle * 2 / card_count)

    styles = {
      'margin-left' => "#{margin}%",
      'transform'   => "rotate(#{angle}deg)"
    }

    styles.map { |k, v| "#{k}: #{v}" }.join(';')
  end

  def horizontal_style(index, card_count)
    offset = 1
    margin = index * offset

    styles = {
      'margin-left' => "#{margin}em"
    }

    styles.map { |k, v| "#{k}: #{v}" }.join(';')
  end
end
