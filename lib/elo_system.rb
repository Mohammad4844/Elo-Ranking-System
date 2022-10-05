class EloSystem
  attr_reader :less_2100_k, :between_2100_2400_k, :greater_2400_k,
              :min_floor_rating

  def initialize(less_2100_k = 40, between_2100_2400_k = 20, greater_2400_k = 10)
    @less_2100_k = less_2100_k
    @between_2100_2400_k = between_2100_2400_k
    @greater_2400_k = greater_2400_k
    @min_floor_rating = 100
  end

  # winner = 1 indicates item_a won, 0 indicates item_b won
  def adjust_rating(item_a, item_b, winner)
    rating_a = item_a.rating
    rating_b = item_b.rating

    item_a.rating = compute_new_rating(rating_a, rating_b, winner).ceil
    item_b.rating = compute_new_rating(rating_b, rating_a, 1 - winner).ceil

    item_a.rating = min_floor_rating if item_a.rating < min_floor_rating
    item_b.rating = min_floor_rating if item_b.rating < min_floor_rating
  end

  def compute_new_rating(my_rating, opponent_rating, score)
    my_rating + k_factor(my_rating) * (score - expected_score(my_rating, opponent_rating))
  end

  def expected_score(my_rating, opponent_rating)
    1.0 / (1 + 10 ** ((opponent_rating - my_rating) / 400.0))
  end

  def k_factor(rating)
    if rating < 2100
      less_2100_k
    elsif rating > 2400
      greater_2400_k
    else
      between_2100_2400_k
    end
  end
end
